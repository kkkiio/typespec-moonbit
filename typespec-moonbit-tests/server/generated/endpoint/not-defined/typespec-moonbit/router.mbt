///|
/// 由 TypeSpec 生成的 HTTP server 路由分发函数。
///
/// 该函数可直接作为 `@http.Server::run_forever` 的回调。
pub async fn dispatch(
  request : @http.Request,
  _body : &@io.Reader,
  conn : @http.ServerConnection,
) -> Unit {
  let path = strip_request_query(request.path)
  if request.meth == @http.Head && match_path_template("/server/endpoint/not-defined/valid", path) {
    let _ = conn.send_response(200, "OK")
    return
  }
  conn
    ..send_response(404, "NotFound")
    ..write("not found")
}

///|
/// 从请求路径中剥离 query 部分（`?` 之后）。
fn strip_request_query(path : String) -> String {
  let parts = path.split("?").to_array()
  if parts.length() == 0 {
    path
  } else {
    parts[0].to_string()
  }
}

///|
/// 判断 `path` 是否匹配 `template`（最小实现：支持 `{param}` 段）。
fn match_path_template(template : String, path : String) -> Bool {
  let t = template.trim(char_set="/")
  let p = path.trim(char_set="/")
  let t_segs = if t == "" { [] } else { t.split("/").to_array() }
  let p_segs = if p == "" { [] } else { p.split("/").to_array() }
  if t_segs.length() != p_segs.length() {
    return false
  }
  for i in 0..<t_segs.length() {
    let ts = t_segs[i].to_string()
    let ps = p_segs[i].to_string()
    if ts.length() >= 2 && ts.has_prefix("{") && ts.has_suffix("}") {
      if ps == "" { return false }
    } else if ts != ps {
      return false
    }
  }
  true
}
