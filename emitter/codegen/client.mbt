///|
/// Client 代码生成模块：生成 HTTP 客户端代码。

///|
/// 生成 client 包的文件列表。
pub fn emit_client_files(crate_ : @codemodel.Crate) -> Array[OutputFile] {
  let files = Array::new(capacity=3)
  files.push(OutputFile::new("moon.pkg.json", emit_client_moon_pkg_json()))
  files.push(OutputFile::new("README.mbt.md", emit_client_readme(crate_)))
  files.push(OutputFile::new("generated.mbt", emit_client_source(crate_)))
  files
}

///|
fn emit_client_moon_pkg_json() -> String {
  let content =
    #|{
    #|  "import": [
    #|    { "path": "moonbitlang/async/http", "alias": "http" }
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
fn emit_client_source(crate_ : @codemodel.Crate) -> String {
  let buf = StringBuilder::new(size_hint=256)
  buf.write_string(uri_utils_tmpl)
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
fn emit_client(buf : StringBuilder, client : @codemodel.Client) -> Unit {
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
) -> Unit {
  let fn_name = make_method_name(op.http_method, op.path, op.name)
  let path = op.path
  let template = parse_uri_template(path, op.name)
  buf.write_string("///|\n")
  buf.write_string("/// 调用 ")
  buf.write_string(op.http_method)
  buf.write_string(" ")
  buf.write_string(path)
  buf.write_string("。\n")
  buf.write_string("pub async fn ")
  buf.write_string(type_name)
  buf.write_string("::")
  buf.write_string(fn_name)
  buf.write_string("(self : ")
  buf.write_string(type_name)
  if template.vars().length() > 0 {
    // 目前只生成 string/array/record 三类参数（先对齐 spector/routes 的需求）。
    for v in template.vars() {
      buf.write_string(", ")
      buf.write_string(v.param_name())
      buf.write_string(" : ")
      buf.write_string(v.param_type())
    }
  }
  buf.write_string(") -> @http.Response raise {\n")
  buf.write_string("  let client = @http.Client::new(self.base_url)\n")
  buf.write_string("  defer client.close()\n")
  if template.vars().length() > 0 {
    buf.write_string("  let sb = StringBuilder::new(size_hint=")
    buf.write_string((path.length() + 32).to_string())
    buf.write_string(")\n")
    let mut vi = 0
    for part in template.parts() {
      if part != "" {
        buf.write_string("  sb.write_string(\"")
        buf.write_string(
          part
          .replace_all(old="\\", new="\\\\")
          .replace_all(old="\"", new="\\\""),
        )
        buf.write_string("\")\n")
      } else {
        let v = template.vars()[vi]
        vi += 1
        buf.write_string("  sb.write_string(")
        match v.param_type() {
          "String" => buf.write_string("__tsmb_expand_string(")
          "Array[String]" => buf.write_string("__tsmb_expand_array(")
          "Map[String, Int]" => buf.write_string("__tsmb_expand_record(")
          _ => buf.write_string("__tsmb_expand_string(")
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
    buf.write_string("  let path = sb.to_string()\n")
    buf.write_string("  let path = __tsmb_encode_request_target(path)\n")
  }
  buf.write_string("  client.")
  buf.write_string(op.http_method.to_lower())
  if template.vars().length() == 0 {
    buf.write_string("(\"")
    buf.write_string(path)
    buf.write_string("\")\n")
  } else {
    buf.write_string("(path)\n")
  }
  buf.write_string("}\n")
}

///|
fn make_client_type_name(raw : String) -> String {
  let cleaned = sanitize_identifier(raw)
  let base = if cleaned.length() == 0 { "CLIENT" } else { cleaned.to_upper() }
  if base.has_suffix("CLIENT") {
    base
  } else {
    base + "CLIENT"
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
