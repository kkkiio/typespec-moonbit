///|
/// Client 代码生成模块：生成 HTTP 客户端代码。

///|
/// 生成 client 包的文件列表。
pub fn emit_client_files(crate_ : @codemodel.Crate) -> Array[OutputFile] raise {
  let files = Array::new(capacity=4)
  files.push(OutputFile::new("moon.pkg.json", emit_client_moon_pkg_json()))
  files.push(OutputFile::new("README.mbt.md", emit_client_readme(crate_)))
  files.push(OutputFile::new("models.mbt", emit_client_models(crate_)))
  files.push(OutputFile::new("generated.mbt", emit_client_source(crate_)))
  files
}

///|
fn emit_client_moon_pkg_json() -> String {
  let content =
    #|{
    #|  "import": [
    #|    { "path": "moonbitlang/async/http", "alias": "http" },
    #|    "moonbitlang/core/json",
    #|    { "path": "kkkiio/typespec-moonbit-client-runtime/runtime", "alias": "client_runtime" },
    #|    "kkkiio/typespec-moonbit-server-runtime/runtime"
    #|  ]
    #|}
  content
}

///|
fn emit_client_readme(crate_ : @codemodel.Crate) -> String {
  let buf = StringBuilder::new(size_hint=64)
  buf.write_string("# ")
  buf.write_string(crate_.name)
  buf.write_string("\n\n")
  buf.write_string("由 TypeSpec 生成的 MoonBit 代码。\n")
  buf.to_string()
}

///|
fn emit_client_source(crate_ : @codemodel.Crate) -> String raise {
  let buf = StringBuilder::new(size_hint=256)
  let clients = crate_.clients
  if clients.length() == 0 {
    buf.write_string("// No clients found in CodeModel.\n")
  } else {
    for client in clients {
      emit_client(buf, client)
    }
  }
  buf.to_string()
}

///|
fn emit_client(buf : StringBuilder, client : @codemodel.Client) -> Unit raise {
  let type_name = make_client_type_name(client.name)
  buf.write_string("///|\n")
  buf.write_string("/// ")
  buf.write_string(type_name)
  buf.write_string(" HTTP 客户端。\n")
  buf.write_string("pub struct ")
  buf.write_string(type_name)
  buf.write_string(" {\n")
  buf.write_string("  base_url : String\n")
  buf.write_string("}\n\n")
  buf.write_string("///|\n")
  buf.write_string("/// 创建 ")
  buf.write_string(type_name)
  buf.write_string("。\n")
  buf.write_string("pub fn ")
  buf.write_string(type_name)
  buf.write_string("::new(base_url : String) -> ")
  buf.write_string(type_name)
  buf.write_string(" {\n")
  buf.write_string("  { base_url, }\n")
  buf.write_string("}\n")
  for op in client.methods {
    emit_method(buf, type_name, op)
  }
  buf.write_string("\n")
}

///|
fn emit_method(
  buf : StringBuilder,
  type_name : String,
  op : @codemodel.Method,
) -> Unit raise {
  let fn_name = make_method_name(op.http_method, op.path, op.name)
  let path = op.path
  let template = parse_uri_template(path, op.name)
  let method_ctor = client_meth_ctor(op.http_method)
  let success_responses = if op.success_responses.length() > 0 {
    op.success_responses
  } else {
    [
      {
        status: @codemodel.StatusMatcher::Code(op.status_code),
        body: op.response_body,
      },
    ]
  }
  let has_multi_success = success_responses.length() > 1
  let result_type_name = make_operation_result_type_name(type_name, fn_name)
  let return_type = if has_multi_success {
    result_type_name
  } else {
    let first = success_responses[0]
    match first.body {
      Some(t) => type_ref_to_string(t)
      None => "Unit"
    }
  }
  let needs_response_body = {
    let mut has_body = false
    for r in success_responses {
      match r.body {
        Some(_) => has_body = true
        None => ()
      }
    }
    has_body
  }
  fn find_param_by_name(
    params : Array[@codemodel.Parameter],
    name : String,
    location : String,
  ) -> @codemodel.Parameter? {
    for p in params {
      if sanitize_identifier(p.name.to_lower()) ==
        sanitize_identifier(name.to_lower()) &&
        p.location == location {
        return Some(p)
      }
    }
    None
  }

  // Decide which `{...}` vars we keep as RFC6570 expansion, and infer their param types from CodeModel when possible.
  //
  // We skip query vars that require custom array encoding (spaceDelimited/pipeDelimited),
  // and emit them as ordinary query parameters instead.
  let kept_template_vars = Array::new()
  let kept_template_var_type : Map[String, String] = Map::new() // param_name -> type string
  let kept_template_var_kind : Map[String, String] = Map::new() // param_name -> expand kind: "string"|"array"|"record"
  let skipped_template_params : Map[String, Bool] = Map::new() // param_name -> true
  for v in template.vars() {
    let is_query = v.op == "?" || v.op == "&"
    let loc = if is_query { "query" } else { "path" }
    let matched = find_param_by_name(op.parameters, v.name, loc)
    let mut skip = false
    match matched {
      None => ()
      Some(p) =>
        if is_query {
          match p.array_encoding {
            Some("spaceDelimited") | Some("pipeDelimited") => skip = true
            _ => ()
          }
        }
    }
    if skip {
      skipped_template_params.set(v.param_name(), true)
      continue
    }
    let mut kind = "string"
    let mut ty = v.param_type()
    match matched {
      None => ()
      Some(p) =>
        match p.type_ {
          @codemodel.TypeRef::String => {
            kind = "string"
            ty = "String"
          }
          @codemodel.TypeRef::Array(@codemodel.TypeRef::String) => {
            kind = "array"
            ty = "Array[String]"
          }
          @codemodel.TypeRef::Record(@codemodel.TypeRef::Int32) => {
            kind = "record"
            ty = "Map[String, Int]"
          }
          _ =>
            fail(
              "unsupported uri template parameter type in client codegen: \{p.name}",
            )
        }
    }
    kept_template_vars.push(v)
    kept_template_var_type.set(v.param_name(), ty)
    kept_template_var_kind.set(v.param_name(), kind)
  }

  // Allocate safe parameter variable names (avoid collisions with template vars).
  fn alloc_param_var(used : Map[String, Bool], base : String) -> String {
    let mut candidate = base
    let mut i = 1
    while used.contains(candidate) {
      candidate = "\{base}_\{i.to_string()}"
      i += 1
    }
    used.set(candidate, true)
    candidate
  }

  let used_vars = Map::new()
  for v in kept_template_vars {
    used_vars.set(v.param_name(), true)
  }
  let extra_params = Array::new() // Array[(@codemodel.Parameter, String)]
  for p in op.parameters {
    let key = sanitize_identifier(p.name.to_lower())
    if kept_template_var_type.contains(key) &&
      !skipped_template_params.contains(key) {
      // This parameter is represented as a kept `{...}` template var.
      continue
    }
    let base = sanitize_identifier(@case.snake_case(p.name))
    let var_name = alloc_param_var(used_vars, base)
    extra_params.push((p, var_name))
  }
  buf.write_string("///|\n")
  buf.write_string("/// 调用 ")
  buf.write_string(op.http_method)
  buf.write_string(" ")
  buf.write_string(path)
  buf.write_string("（自动解析响应）。\n")
  buf.write_string("pub async fn ")
  buf.write_string(type_name)
  buf.write_string("::")
  buf.write_string(fn_name)
  buf.write_string("(self : ")
  buf.write_string(type_name)
  if kept_template_vars.length() > 0 {
    // 目前只生成 string/array/record 三类参数（先对齐 spector/routes 的需求）。
    for v in kept_template_vars {
      buf.write_string(", ")
      buf.write_string(v.param_name())
      buf.write_string(" : ")
      buf.write_string(kept_template_var_type.get(v.param_name()).unwrap())
    }
  }
  for item in extra_params {
    let p = item.0
    let var_name = item.1
    buf.write_string(", ")
    buf.write_string(var_name)
    buf.write_string(" : ")
    buf.write_string(type_ref_to_string(p.type_))
    if p.optional {
      buf.write_string("?")
    }
  }
  buf.write_string(") -> ")
  buf.write_string(return_type)
  buf.write_string(" raise {\n")
  buf.write_string("  let client = @http.Client::new(self.base_url)\n")
  buf.write_string("  defer client.close()\n")
  buf.write_string("  let headers : Map[String, String] = {}\n")

  // Build base path (expand uri template vars if present).
  if template.vars().length() == 0 {
    buf.write_string(
      "  let base_path = @client_runtime.encode_request_target(\"",
    )
    buf.write_string(
      path.replace_all(old="\\", new="\\\\").replace_all(old="\"", new="\\\""),
    )
    buf.write_string("\")\n")
  } else {
    buf.write_string("  let sb0 = StringBuilder::new(size_hint=")
    buf.write_string((path.length() + 64).to_string())
    buf.write_string(")\n")
    let mut vi = 0
    for part in template.parts() {
      if part != "" {
        buf.write_string("  sb0.write_string(\"")
        buf.write_string(
          part
          .replace_all(old="\\", new="\\\\")
          .replace_all(old="\"", new="\\\""),
        )
        buf.write_string("\")\n")
      } else {
        let v = template.vars()[vi]
        vi += 1
        if skipped_template_params.contains(v.param_name()) {
          continue
        }
        buf.write_string("  sb0.write_string(")
        let kind = kept_template_var_kind
          .get(v.param_name())
          .unwrap_or("string")
        match kind {
          "array" => buf.write_string("@client_runtime.expand_array(")
          "record" => buf.write_string("@client_runtime.expand_record(")
          _ => buf.write_string("@client_runtime.expand_string(")
        }
        buf.write_string("\"")
        buf.write_string(v.op)
        buf.write_string("\", \"")
        buf.write_string(v.name)
        buf.write_string("\", ")
        buf.write_string(if v.explode { "true" } else { "false" })
        buf.write_string(", ")
        buf.write_string(v.param_name())
        buf.write_string("))\n")
      }
    }
    buf.write_string("  let base_path = sb0.to_string()\n")
    buf.write_string(
      "  let base_path = @client_runtime.encode_request_target(base_path)\n",
    )
  }

  // Apply query parameters (not in uri template).
  buf.write_string(
    "  let sb = StringBuilder::new(size_hint=base_path.length() + 128)\n",
  )
  buf.write_string("  sb.write_string(base_path)\n")
  let mut has_query_params = false
  for item in extra_params {
    if item.0.location == "query" {
      has_query_params = true
      break
    }
  }
  if has_query_params {
    buf.write_string("  let mut first_query = !base_path.contains(\"?\")\n")
  }
  for item in extra_params {
    let p = item.0
    let var_name = item.1
    if p.location == "header" {
      // header parameters
      let header_key = p.name
        .replace_all(old="\\", new="\\\\")
        .replace_all(old="\"", new="\\\"")
      if p.optional {
        buf.write_string("  if \{var_name} is Some(v) {\n")
        match p.type_ {
          @codemodel.TypeRef::Array(@codemodel.TypeRef::String) => {
            buf.write_string("    headers.set(\"")
            buf.write_string(header_key)
            buf.write_string("\", @client_runtime.join(v, \",\"))\n")
          }
          @codemodel.TypeRef::String => {
            buf.write_string("    headers.set(\"")
            buf.write_string(header_key)
            buf.write_string("\", v)\n")
          }
          _ =>
            fail(
              "unsupported header parameter type in client codegen: \{p.name}",
            )
        }
        buf.write_string("  }\n")
      } else {
        match p.type_ {
          @codemodel.TypeRef::Array(@codemodel.TypeRef::String) => {
            buf.write_string("  headers.set(\"")
            buf.write_string(header_key)
            buf.write_string("\", @client_runtime.join(\{var_name}, \",\"))\n")
          }
          @codemodel.TypeRef::String => {
            buf.write_string("  headers.set(\"")
            buf.write_string(header_key)
            buf.write_string("\", \{var_name})\n")
          }
          _ =>
            fail(
              "unsupported header parameter type in client codegen: \{p.name}",
            )
        }
      }
    } else if p.location == "query" {
      // query parameters
      let query_key = p.name
        .replace_all(old="\\", new="\\\\")
        .replace_all(old="\"", new="\\\"")
      fn write_query_pair(
        buf : StringBuilder,
        key : String,
        value_expr : String,
      ) -> Unit {
        buf.write_string("  if first_query {\n")
        buf.write_string("    sb.write_char('?')\n")
        buf.write_string("    first_query = false\n")
        buf.write_string("  } else {\n")
        buf.write_string("    sb.write_char('&')\n")
        buf.write_string("  }\n")
        buf.write_string("  sb.write_string(\"")
        buf.write_string(key)
        buf.write_string("=\")\n")
        buf.write_string(
          "  sb.write_string(@client_runtime.encode_query_component(",
        )
        buf.write_string(value_expr)
        buf.write_string("))\n")
      }

      let delimiter = match p.array_encoding {
        Some("spaceDelimited") => " "
        Some("pipeDelimited") => "|"
        _ => ","
      }
      if p.optional {
        buf.write_string("  if \{var_name} is Some(v) {\n")
        match p.type_ {
          @codemodel.TypeRef::Array(@codemodel.TypeRef::String) =>
            if p.explode {
              buf.write_string("    for x in v {\n")
              write_query_pair(buf, query_key, "x")
              buf.write_string("    }\n")
            } else {
              write_query_pair(
                buf,
                query_key,
                "@client_runtime.join(v, \"\{delimiter}\")",
              )
            }
          @codemodel.TypeRef::String => write_query_pair(buf, query_key, "v")
          _ =>
            fail(
              "unsupported query parameter type in client codegen: \{p.name}",
            )
        }
        buf.write_string("  }\n")
      } else {
        match p.type_ {
          @codemodel.TypeRef::Array(@codemodel.TypeRef::String) =>
            if p.explode {
              buf.write_string("  for x in \{var_name} {\n")
              write_query_pair(buf, query_key, "x")
              buf.write_string("  }\n")
            } else {
              write_query_pair(
                buf,
                query_key,
                "@client_runtime.join(\{var_name}, \"\{delimiter}\")",
              )
            }
          @codemodel.TypeRef::String =>
            write_query_pair(buf, query_key, var_name)
          _ =>
            fail(
              "unsupported query parameter type in client codegen: \{p.name}",
            )
        }
      }
    }
  }
  buf.write_string("  let path = sb.to_string()\n")

  // Send request (body if present).
  let mut body_param : (@codemodel.Parameter, String)? = None
  for item in extra_params {
    if item.0.location == "body" {
      body_param = Some(item)
      break
    }
  }
  match body_param {
    None => {
      buf.write_string("  client.request(")
      buf.write_string(method_ctor)
      buf.write_string(", path, extra_headers=headers)\n")
    }
    Some(item) => {
      let p = item.0
      let var_name = item.1
      if p.optional {
        buf.write_string("  if \{var_name} is Some(body) {\n")
        buf.write_string(
          "    headers.set(\"content-type\", \"application/json\")\n",
        )
        buf.write_string("    client.request(")
        buf.write_string(method_ctor)
        buf.write_string(", path, extra_headers=headers)\n")
        buf.write_string("    client.write(body.to_json())\n")
        buf.write_string("  } else {\n")
        buf.write_string("    client.request(")
        buf.write_string(method_ctor)
        buf.write_string(", path, extra_headers=headers)\n")
        buf.write_string("  }\n")
      } else {
        buf.write_string(
          "  headers.set(\"content-type\", \"application/json\")\n",
        )
        buf.write_string("  client.request(")
        buf.write_string(method_ctor)
        buf.write_string(", path, extra_headers=headers)\n")
        buf.write_string("  client.write(\{var_name}.to_json())\n")
      }
    }
  }
  buf.write_string("  let response = client.end_request()\n")
  if needs_response_body {
    buf.write_string("  let response_body = client.read_all().text()\n")
  }
  for r in success_responses {
    let cond = status_matcher_condition(r.status)
    buf.write_string("  if ")
    buf.write_string(cond)
    buf.write_string(" {\n")
    match r.body {
      Some(t) => {
        let tstr = type_ref_to_string(t)
        buf.write_string(
          "    @client_runtime.expect_json_content_type(response)\n",
        )
        buf.write_string("    let parsed : ")
        buf.write_string(tstr)
        buf.write_string(" = @json.from_json(@json.parse(response_body))\n")
        if has_multi_success {
          buf.write_string("    ")
          buf.write_string(return_type)
          buf.write_string("::")
          buf.write_string(status_matcher_variant_name(r.status))
          buf.write_string("(parsed)\n")
        } else {
          buf.write_string("    parsed\n")
        }
      }
      None =>
        if has_multi_success {
          buf.write_string("    ")
          buf.write_string(return_type)
          buf.write_string("::")
          buf.write_string(status_matcher_variant_name(r.status))
          buf.write_string("\n")
        } else {
          buf.write_string("    ()\n")
        }
    }
    buf.write_string("  } else ")
  }
  buf.write_string("{\n")
  buf.write_string(
    "    fail(\"unexpected status code: \" + response.code.to_string())\n",
  )
  buf.write_string("  }\n")
  buf.write_string("}\n\n")
  if has_multi_success {
    buf.write_string("///|\n")
    buf.write_string("pub enum ")
    buf.write_string(result_type_name)
    buf.write_string(" {\n")
    for r in success_responses {
      let ctor = status_matcher_variant_name(r.status)
      match r.body {
        Some(t) =>
          if type_ref_is_union(t) {
            fail(
              "unsupported response body union in client codegen: \{op.name}",
            )
          } else {
            buf.write_string("  ")
            buf.write_string(ctor)
            buf.write_string("(")
            buf.write_string(type_ref_to_string(t))
            buf.write_string(")\n")
          }
        None => {
          buf.write_string("  ")
          buf.write_string(ctor)
          buf.write_string("\n")
        }
      }
    }
    buf.write_string("} derive(Show)\n\n")
  } else {
    let first = success_responses[0]
    match first.body {
      Some(t) =>
        if type_ref_is_union(t) {
          fail("unsupported response body union in client codegen: \{op.name}")
        }
      None => ()
    }
  }
}

///|
fn make_client_type_name(raw : String) -> String {
  let cleaned = sanitize_identifier(raw)
  let base0 = @case.pascal_case(cleaned)
  let base = if base0 == "" { "Client" } else { base0 }
  if base.has_suffix("Client") {
    base
  } else {
    base + "Client"
  }
}

///|
fn make_method_name(
  http_method : String,
  path : String,
  raw_name : String,
) -> String {
  let prefix = sanitize_identifier(http_method.to_lower())
  let path_part = trim_leading_underscores(sanitize_identifier(path.to_lower()))
  let name_part = sanitize_identifier(raw_name.to_lower())
  let base = if path_part.length() > 0 {
    path_part
  } else if name_part.length() > 0 {
    name_part
  } else {
    "call"
  }
  prefix + "_" + base
}

///|
fn client_meth_ctor(http_method : String) -> String raise {
  match http_method.to_upper() {
    "GET" => "@http.Get"
    "HEAD" => "@http.Head"
    "POST" => "@http.Post"
    "PUT" => "@http.Put"
    "DELETE" => "@http.Delete"
    "PATCH" => "@http.Patch"
    "OPTIONS" => "@http.Options"
    "TRACE" => "@http.Trace"
    "CONNECT" => "@http.Connect"
    _ => fail("unsupported http method: \{http_method}")
  }
}

///|
fn make_operation_result_type_name(
  type_name : String,
  fn_name : String,
) -> String {
  @case.pascal_case(type_name + "_" + fn_name + "_result")
}

///|
fn status_matcher_variant_name(status : @codemodel.StatusMatcher) -> String {
  match status {
    @codemodel.StatusMatcher::Code(code) => "Status\{code.to_string()}"
    @codemodel.StatusMatcher::Range(start, end_) =>
      "Status\{start.to_string()}To\{end_.to_string()}"
  }
}

///|
fn status_matcher_condition(status : @codemodel.StatusMatcher) -> String {
  match status {
    @codemodel.StatusMatcher::Code(code) =>
      "response.code == \{code.to_string()}"
    @codemodel.StatusMatcher::Range(start, end_) =>
      "response.code >= \{start.to_string()} && response.code <= \{end_.to_string()}"
  }
}

///|
fn type_ref_is_union(type_ : @codemodel.TypeRef) -> Bool {
  match type_ {
    @codemodel.TypeRef::Union(_) => true
    @codemodel.TypeRef::Nullable(inner) => type_ref_is_union(inner)
    _ => false
  }
}

///|
fn type_ref_to_string(type_ : @codemodel.TypeRef) -> String raise {
  match type_ {
    String => "String"
    Int32 => "Int"
    Int64 => "Int64"
    Float64 => "Double"
    Bool => "Bool"
    Json => "Json"
    Model(m) => @case.pascal_case(m.name)
    Union(u) => @case.pascal_case(u.name)
    Array(t) => "Array[\{type_ref_to_string(t)}]"
    Record(t) => "Map[String, \{type_ref_to_string(t)}]"
    Nullable(t) => "Nullable[\{type_ref_to_string(t)}]"
  }
}

///|
fn wln(sb : StringBuilder, s : String) -> Unit {
  sb.write_string(s)
  sb.write_char('\n')
}

///|
fn write_model(sb : StringBuilder, m : @codemodel.Model) -> Unit raise {
  wln(sb, "///|")
  wln(sb, "/// Model \{m.name}")
  let struct_name = @case.pascal_case(m.name)
  wln(sb, "pub(all) struct \{struct_name} {")

  // NOTE: 不考虑 @encodedName；wire name 直接用 TypeSpec property.name。
  // 为避免歧义，若两个字段映射到同一个 snake_case 标识符，直接报错。
  let seen_field_names : Map[String, String] = Map::new() // field_name -> wire_name
  let rename_entries : Array[(String, String)] = Array::new()
  for f in m.fields {
    let field_name = sanitize_identifier(@case.snake_case(f.name))
    if seen_field_names.contains(field_name) {
      let prev = seen_field_names.get(field_name).unwrap()
      if prev != f.name {
        fail(
          "model field name collision after snake_case: \{m.name}.\{prev} and \{m.name}.\{f.name} both map to \{field_name}",
        )
      }
    } else {
      seen_field_names.set(field_name, f.name)
    }
    let mut line = "  \{field_name} : \{type_ref_to_string(f.type_)}"
    if f.optional {
      line = line + "?"
    }
    wln(sb, line)
    if field_name != f.name {
      rename_entries.push((field_name, f.name))
    }
  }
  sb.write_string("} derive(Show, ")
  let has_renames = rename_entries.length() > 0
  if !has_renames {
    sb.write_string("ToJson, @json.FromJson")
  } else {
    sb.write_string("ToJson(fields(")
    let n = rename_entries.length()
    for i in 0..<n {
      let entry = rename_entries[i]
      sb.write_string("\{entry.0}(rename=\"\{entry.1}\")")
      if i != n - 1 {
        sb.write_string(", ")
      }
    }
    sb.write_string(")), @json.FromJson(fields(")
    for i in 0..<n {
      let entry = rename_entries[i]
      sb.write_string("\{entry.0}(rename=\"\{entry.1}\")")
      if i != n - 1 {
        sb.write_string(", ")
      }
    }
    sb.write_string("))")
  }
  wln(sb, ")")
  wln(sb, "")
}

///|
fn collect_encode_types_from_crate(
  crate_ : @codemodel.Crate,
) -> (Map[String, @codemodel.Model], Map[String, @codemodel.Union]) {
  let models : Map[String, @codemodel.Model] = Map::new()
  let unions : Map[String, @codemodel.Union] = Map::new()
  fn collect(type_ : @codemodel.TypeRef) -> Unit {
    match type_ {
      Model(m) =>
        if !models.contains(m.name) {
          models.set(m.name, m)
          for field in m.fields {
            collect(field.type_)
          }
        }
      Union(u) =>
        if !unions.contains(u.name) {
          unions.set(u.name, u)
          for v in u.variants {
            collect(v.type_)
          }
        }
      Array(t) => collect(t)
      Record(t) => collect(t)
      Nullable(t) => collect(t)
      _ => ()
    }
  }

  for client in crate_.clients {
    for op in client.methods {
      for p in op.parameters {
        collect(p.type_)
      }
      if op.success_responses.length() > 0 {
        for r in op.success_responses {
          match r.body {
            None => ()
            Some(t) => collect(t)
          }
        }
      } else {
        match op.response_body {
          None => ()
          Some(t) => collect(t)
        }
      }
    }
  }
  (models, unions)
}

///|
fn write_union(sb : StringBuilder, u : @codemodel.Union) -> Unit raise {
  let enum_name = @case.pascal_case(u.name)
  wln(sb, "///|")
  wln(sb, "/// Union \{u.name}")
  wln(sb, "#warnings(\"-unused_constructor\")")
  wln(sb, "pub(all) enum \{enum_name} {")
  for v in u.variants {
    let ctor = @case.pascal_case(sanitize_identifier(v.name))
    wln(sb, "  \{ctor}(\{type_ref_to_string(v.type_)})")
  }
  wln(sb, "} derive(Show)")
  wln(sb, "")
  wln(
    sb,
    "pub impl ToJson for \{enum_name} with to_json(self : \{enum_name}) -> Json {",
  )
  wln(sb, "  match self {")
  for v in u.variants {
    let ctor = @case.pascal_case(sanitize_identifier(v.name))
    wln(sb, "    \{ctor}(v) => v.to_json()")
  }
  wln(sb, "  }")
  wln(sb, "}")
  wln(sb, "")
}

///|
fn emit_client_models(crate_ : @codemodel.Crate) -> String raise {
  let buf = StringBuilder::new(size_hint=4096)

  // Nullable helper (for `T | null`) is provided by runtime.
  wln(
    buf, "///|\n#warnings(\"-unused_type_declaration\")\npub using @runtime {type Nullable}\n",
  )
  let (models, unions) = collect_encode_types_from_crate(crate_)
  let union_list = unions.to_array()
  union_list.sort_by_key(fn(u) { u.0 })
  for item in union_list {
    write_union(buf, item.1)
  }
  let model_list = models.to_array()
  model_list.sort_by_key(fn(m) { m.0 })
  for item in model_list {
    write_model(buf, item.1)
  }
  buf.to_string()
}
