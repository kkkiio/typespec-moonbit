///|
/// Server 代码生成模块：生成基于 `moonbitlang/async/http` 的 server 包。

///|
/// 生成 server 包的文件列表。
pub fn emit_server_files(crate_ : @codemodel.Crate) -> Array[OutputFile] {
  let files = Array::new(capacity=3)
  files.push(OutputFile::new("moon.pkg.json", emit_server_moon_pkg_json()))
  files.push(OutputFile::new("README.mbt.md", emit_server_readme(crate_)))
  files.push(OutputFile::new("router.mbt", emit_server_router(crate_)))
  files
}

///|
fn emit_server_moon_pkg_json() -> String {
  let content =
    #|{
    #|  "import": [
    #|    { "path": "moonbitlang/async/http", "alias": "http" },
    #|    { "path": "moonbitlang/async/io", "alias": "io" }
    #|  ]
    #|}
  content
}

///|
fn emit_server_readme(crate_ : @codemodel.Crate) -> String {
  let buf = StringBuilder::new(size_hint=96)
  buf.write_string("# ")
  buf.write_string(crate_.name())
  buf.write_string("\n\n")
  buf.write_string(
    "由 TypeSpec 生成的 MoonBit HTTP server 包（基于 moonbitlang/async/http）。\n",
  )
  buf.write_string("\n")
  buf.write_string(
    "本目录是一个 MoonBit package，可被其它包 import 后用于启动 server。\n",
  )
  buf.to_string()
}

///|

///|
fn emit_server_router(crate_ : @codemodel.Crate) -> String {
  let buf = StringBuilder::new(size_hint=8192)

  // 1. Collect Models
  let models = Map::new()
  for client in crate_.clients() {
    for op in client.methods() {
      for param in op.parameters() {
        collect_models(param.type_(), models)
      }
    }
  }

  // 2. Generate Model Structs
  buf.write_string("///| Model definitions\n")
  let model_list = models.to_array()
  model_list.sort_by_key(fn(m) { m.0 })
  for item in model_list {
    let m = item.1
    let struct_name = to_pascal_case(m.name)
    buf.write_string("pub(all) struct \{struct_name} {\n")
    for field in m.fields {
      buf.write_string("  ")
      buf.write_string(to_snake_case(field.name))
      buf.write_string(" : ")
      buf.write_string(type_ref_to_string(field.type_))
      buf.write_string("\n")
    }
    buf.write_string("}\n\n")
    buf.write_string(
      "pub impl @json.FromJson for \{struct_name} with from_json(json, _path) {\n",
    )
    buf.write_string("  match json {\n")
    buf.write_string("    Object(_obj) => {\n")
    buf.write_string("      \{struct_name}::{ \n")
    for field in m.fields {
      let fname = to_snake_case(field.name)
      let default_val = type_to_default(field.type_)
      buf.write_string(
        "        \{fname}: _obj.get(\"\{field.name}\").bind(fn(j) { try { Some(@json.from_json(j)) } catch { _ => None } }).unwrap_or(\{default_val}),\n",
      )
    }
    buf.write_string("      }\n")
    buf.write_string("    }\n")
    buf.write_string("    _ => \{struct_name}::{")
    for i in 0..<m.fields.length() {
      if i > 0 {
        buf.write_string(", ")
      }
      let fname = to_snake_case(m.fields[i].name)
      let default_val = type_to_default(m.fields[i].type_)
      buf.write_string("\{fname}: \{default_val}")
    }
    buf.write_string("}\n")
    buf.write_string("  }\n")
    buf.write_string("}\n\n")
  }

  // 3. Generate Handler Traits
  buf.write_string("///| Traits for operation handlers\n")
  for client in crate_.clients() {
    let trait_name = to_pascal_case(client.name()) + "Handler"
    buf.write_string("pub(open) trait \{trait_name} {\n")
    for op in client.methods() {
      buf.write_string("  async ")
      buf.write_string(to_snake_case(op.name()))
      buf.write_string("(Self")
      for param in op.parameters() {
        buf.write_string(", ")
        buf.write_string(to_snake_case(param.name))
        buf.write_string(" : ")
        buf.write_string(type_ref_to_string(param.type_))
      }
      buf.write_string(") -> Unit\n")
    }
    buf.write_string("}\n\n")
  }

  // 4. Generate Router Struct and Factory
  buf.write_string("///| Router definition\n")
  buf.write_string("pub struct Router {\n")
  buf.write_string(
    "  _dispatch : async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit\n",
  )
  buf.write_string("}\n\n")
  buf.write_string("pub async fn Router::dispatch(\n")
  buf.write_string("  self : Router,\n")
  buf.write_string("  request : @http.Request,\n")
  buf.write_string("  body : &@io.Reader,\n")
  buf.write_string("  conn : @http.ServerConnection\n")
  buf.write_string(") -> Unit {\n")
  buf.write_string("  (self._dispatch)(request, body, conn)\n")
  buf.write_string("}\n\n")
  buf.write_string("pub fn[")
  let clients = crate_.clients()
  for i in 0..<clients.length() {
    let client = clients[i]
    let trait_name = to_pascal_case(sanitize_identifier(client.name())) +
      "Handler"
    if i > 0 {
      buf.write_string(",\n")
    }
    buf.write_string("  H\{i} : \{trait_name}")
  }
  buf.write_string("] create_router(\n")
  for i in 0..<clients.length() {
    if i > 0 {
      buf.write_string(",\n")
    }
    buf.write_string("  h\{i} : H\{i}")
  }
  buf.write_string("\n) -> Router {\n")
  buf.write_string("  Router::{\n")
  buf.write_string("    _dispatch: async fn(req, body_stream, conn) {\n")
  buf.write_string("      let path = strip_request_query(req.path)\n")
  buf.write_string("      if false { () }\n")
  let mut op_counter = 0
  for i in 0..<clients.length() {
    let client = clients[i]
    for op in client.methods() {
      op_counter += 1
      let meth = server_meth_ctor(op.http_method())
      let normalized_tmpl = normalize_uri_template(op.path())
      let tmpl = normalized_tmpl
        .replace_all(old="\\", new="\\\\")
        .replace_all(old="\"", new="\\\"")
      buf.write_string(
        "      else if req.meth == \{meth} && match_path_template(\"\{tmpl}\", path) {\n",
      )

      // Parse body if and only if there's a body parameter
      let mut has_body = false
      for param in op.parameters() {
        if param.location == "body" {
          has_body = true
        }
      }
      if has_body {
        buf.write_string("        let body_bytes = body_stream.read_all()\n")
        buf.write_string("        let body_str = body_bytes.text()\n")
      } else {
        buf.write_string("        ignore(body_stream)\n")
      }
      let args = Array::new()
      for param in op.parameters() {
        let pname = sanitize_identifier(to_snake_case(param.name))
        let var_name = "p_\{op_counter}_\{pname}"
        match param.location {
          "body" => {
            let type_str = type_ref_to_string(param.type_)
            if type_str == "String" {
              buf.write_string("        let \{var_name} = body_str\n")
            } else {
              buf.write_string(
                "        let \{var_name} : \{type_str} = try { @json.from_json(@json.parse(body_str)) } catch { _ => @json.from_json(null) }\n",
              )
            }
          }
          "query" => buf.write_string("        let \{var_name} = \"\"\n") // TODO: implement query parser
          _ => buf.write_string("        let \{var_name} = \"\"\n")
        }
        args.push(var_name)
      }
      let args_str = args.join(", ")
      buf.write_string(
        "        h\{i}.\{to_snake_case(op.name())}(\{args_str})\n",
      )
      buf.write_string("        conn.send_response(204, \"No Content\")\n")
      buf.write_string("      }\n")
    }
  }
  buf.write_string("      else {\n")
  buf.write_string("        conn.send_response(404, \"NotFound\")\n")
  buf.write_string("        conn.write(\"not found\")\n")
  buf.write_string("      }\n")
  buf.write_string("    }\n")
  buf.write_string("  }\n")
  buf.write_string("}\n\n")
  buf.write_string("///|\n")
  buf.write_string("fn strip_request_query(path : String) -> String {\n")
  buf.write_string("  let parts = path.split(\"?\").to_array()\n")
  buf.write_string(
    "  if parts.length() == 0 { path } else { parts[0].to_string() }\n",
  )
  buf.write_string("}\n\n")
  buf.write_string("///|\n")
  buf.write_string(
    "fn match_path_template(template : String, path : String) -> Bool {\n",
  )
  buf.write_string("  let t = template.trim(char_set=\"/\")\n")
  buf.write_string("  let p = path.trim(char_set=\"/\")\n")
  buf.write_string(
    "  let t_segs = if t == \"\" { [] } else { t.split(\"/\").to_array() }\n",
  )
  buf.write_string(
    "  let p_segs = if p == \"\" { [] } else { p.split(\"/\").to_array() }\n",
  )
  buf.write_string("  if t_segs.length() != p_segs.length() { return false }\n")
  buf.write_string("  for i in 0..<t_segs.length() {\n")
  buf.write_string("    let ts = t_segs[i].to_string()\n")
  buf.write_string("    let ps = p_segs[i].to_string()\n")
  buf.write_string(
    "    if ts.length() >= 2 && ts.has_prefix(\"{\") && ts.has_suffix(\"}\") {\n",
  )
  buf.write_string("      if ps == \"\" { return false }\n")
  buf.write_string("    } else if ts != ps { return false }\n")
  buf.write_string("  }\n")
  buf.write_string("  true\n")
  buf.write_string("}\n")
  buf.to_string()
}

///|
fn collect_models(
  type_ : @codemodel.TypeRef,
  models : Map[String, @codemodel.Model],
) -> Unit {
  match type_ {
    Model(m) =>
      if !models.contains(m.name) {
        models.set(m.name, m)
        for field in m.fields {
          collect_models(field.type_, models)
        }
      }
    Array(t) => collect_models(t, models)
    _ => ()
  }
}

///|
fn type_ref_to_string(type_ : @codemodel.TypeRef) -> String {
  match type_ {
    String => "String"
    Int32 => "Int"
    Int64 => "Int64"
    Float64 => "Double"
    Bool => "Bool"
    Model(m) => to_pascal_case(m.name)
    Array(t) => "Array[\{type_ref_to_string(t)}]"
    Unknown => "Unit"
  }
}

///|
fn server_meth_ctor(http_method : String) -> String {
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
    _ => "@http.Get"
  }
}

///|
fn normalize_uri_template(template : String) -> String {
  let p1 = template.split("{?").to_array()
  let s = if p1.length() == 0 { template } else { p1[0].to_string() }
  let p2 = s.split("?").to_array()
  if p2.length() == 0 {
    s
  } else {
    p2[0].to_string()
  }
}

///|
fn type_to_default(type_ : @codemodel.TypeRef) -> String {
  match type_ {
    String => "\"\""
    Int32 | Int64 => "0"
    Float64 => "0.0"
    Bool => "false"
    Array(_) => "[]"
    Model(m) =>
      to_pascal_case(m.name) +
      "::{" +
      m.fields
      .map(fn(f) { to_snake_case(f.name) + ": " + type_to_default(f.type_) })
      .join(", ") +
      "}"
    Unknown => "()"
  }
}
