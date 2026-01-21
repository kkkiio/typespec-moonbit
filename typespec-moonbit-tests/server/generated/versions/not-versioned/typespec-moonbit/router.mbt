///| Traits for operation handlers
pub(open) trait NotVersionedHandler {
  async without_api_version(Self) -> Unit
  async with_query_api_version(Self, api_version : String) -> Unit
  async with_path_api_version(Self, api_version : String) -> Unit
}

pub struct Router {
  dispatch : async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit
}
pub async fn Router::dispatch(
  self : Router,
  request : @http.Request,
  body : &@io.Reader,
  conn : @http.ServerConnection
) -> Unit {
  (self.dispatch)(request, body, conn)
}
pub fn[H0 : NotVersionedHandler] create_router(h0 : H0) -> Router {
  Router::{
    dispatch: async fn(req, body_stream, conn) {
      let path = strip_request_query(req.path)
      if false { () }      else if req.meth == @http.Head && match_path_template("/server/versions/not-versioned/without-api-version", path) {
        ignore(body_stream)
        h0.without_api_version()
        conn.send_response(204, "No Content")
      }
      else if req.meth == @http.Head && match_path_template("/server/versions/not-versioned/with-query-api-version", path) {
        ignore(body_stream)
        let p_2_api_version = ""
        h0.with_query_api_version(p_2_api_version)
        conn.send_response(204, "No Content")
      }
      else if req.meth == @http.Head && match_path_template("/server/versions/not-versioned/with-path-api-version/{apiVersion}", path) {
        ignore(body_stream)
        let p_3_api_version = ""
        h0.with_path_api_version(p_3_api_version)
        conn.send_response(204, "No Content")
      }
      else {
        conn.send_response(404, "NotFound")
        conn.write("not found")
      }
    }
  }
}

///|
fn strip_request_query(path : String) -> String {
  let parts = path.split("?").to_array()
  if parts.length() == 0 { path } else { parts[0].to_string() }
}
///|
fn match_path_template(template : String, path : String) -> Bool {
  let t = template.trim(char_set="/")
  let p = path.trim(char_set="/")
  let t_segs = if t == "" { [] } else { t.split("/").to_array() }
  let p_segs = if p == "" { [] } else { p.split("/").to_array() }
  if t_segs.length() != p_segs.length() { return false }
  for i in 0..<t_segs.length() {
    let ts = t_segs[i].to_string()
    let ps = p_segs[i].to_string()
    if ts.length() >= 2 && ts.has_prefix("{") && ts.has_suffix("}") {
      if ps == "" { return false }
    } else if ts != ps { return false }
  }
  true
}
