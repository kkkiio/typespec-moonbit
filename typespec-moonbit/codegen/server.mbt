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
fn emit_server_router(crate_ : @codemodel.Crate) -> String {
  let buf = StringBuilder::new(size_hint=768)
  buf.write_string("///|\n")
  buf.write_string(
    "/// 由 TypeSpec 生成的 HTTP server 路由分发函数。\n",
  )
  buf.write_string("///\n")
  buf.write_string(
    "/// 该函数可直接作为 `@http.Server::run_forever` 的回调。\n",
  )
  buf.write_string("pub async fn dispatch(\n")
  buf.write_string("  request : @http.Request,\n")
  buf.write_string("  _body : &@io.Reader,\n")
  buf.write_string("  conn : @http.ServerConnection,\n")
  buf.write_string(") -> Unit {\n")
  buf.write_string("  let path = strip_request_query(request.path)\n")
  let mut emitted_any = false
  for client in crate_.clients() {
    for op in client.methods() {
      emitted_any = true
      let meth = server_meth_ctor(op.http_method())
      // Pre-calculate normalized template
      let normalized_tmpl = normalize_uri_template(op.path())
      let tmpl = normalized_tmpl
        .replace_all(old="\\", new="\\\\")
        .replace_all(old="\"", new="\\\"")
      let code = op.status_code().to_string()
      buf.write_string("  if request.meth == ")
      buf.write_string(meth)
      buf.write_string(" && match_path_template(\"")
      buf.write_string(tmpl)
      buf.write_string("\", path) {\n")
      buf.write_string("    let _ = conn.send_response(")
      buf.write_string(code)
      buf.write_string(", \"OK\")\n")
      buf.write_string("    return\n")
      buf.write_string("  }\n")
    }
  }
  if !emitted_any {
    buf.write_string("  let _ = request\n")
  }
  buf.write_string("  conn\n")
  buf.write_string("    ..send_response(404, \"NotFound\")\n")
  buf.write_string("    ..write(\"not found\")\n")
  buf.write_string("}\n\n")
  buf.write_string("///|\n")
  buf.write_string(
    "/// 从请求路径中剥离 query 部分（`?` 之后）。\n",
  )
  buf.write_string("fn strip_request_query(path : String) -> String {\n")
  buf.write_string("  let parts = path.split(\"?\").to_array()\n")
  buf.write_string("  if parts.length() == 0 {\n")
  buf.write_string("    path\n")
  buf.write_string("  } else {\n")
  buf.write_string("    parts[0].to_string()\n")
  buf.write_string("  }\n")
  buf.write_string("}\n\n")
  buf.write_string("///|\n")
  buf.write_string(
    "/// 判断 `path` 是否匹配 `template`（最小实现：支持 `{param}` 段）。\n",
  )
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
  buf.write_string("  if t_segs.length() != p_segs.length() {\n")
  buf.write_string("    return false\n")
  buf.write_string("  }\n")
  buf.write_string("  for i in 0..<t_segs.length() {\n")
  buf.write_string("    let ts = t_segs[i].to_string()\n")
  buf.write_string("    let ps = p_segs[i].to_string()\n")
  buf.write_string(
    "    if ts.length() >= 2 && ts.has_prefix(\"{\") && ts.has_suffix(\"}\") {\n",
  )
  buf.write_string("      if ps == \"\" { return false }\n")
  buf.write_string("    } else if ts != ps {\n")
  buf.write_string("      return false\n")
  buf.write_string("    }\n")
  buf.write_string("  }\n")
  buf.write_string("  true\n")
  buf.write_string("}\n")
  buf.to_string()
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
