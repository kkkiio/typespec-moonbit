///|
/// Traits for operation handlers
pub(open) trait MultipleHandler {
  async no_operation_params(Self) -> Unit
  async with_operation_path_param(Self, keyword : String) -> Unit
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : MultipleHandler] create_router(h0 : H0) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let path = strip_request_query(req.path)
    if false {
      ()
    } else if req.meth == @http.Get &&
      match_path_template("/server/path/multiple/{apiVersion}", path) {
      ignore(body_stream)
      h0.no_operation_params()
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/server/path/multiple/{apiVersion}/{keyword}", path) {
      ignore(body_stream)
      let p_2_keyword = ""
      h0.with_operation_path_param(p_2_keyword)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else {
      conn.send_response(404, "NotFound")
      conn.write("not found")
      conn.end_response()
    }
  }
}

///|
fn strip_request_query(path : String) -> String {
  let parts = path.split("?").to_array()
  if parts.length() == 0 {
    path
  } else {
    parts[0].to_string()
  }
}

///|
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
      if ps == "" {
        return false
      }
    } else if ts != ps {
      return false
    }
  }
  true
}
