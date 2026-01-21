///| Model definitions
///| Traits for operation handlers
pub(open) trait StringHandler {
  async get_known_value(Self) -> Unit
  async get_unknown_value(Self) -> Unit
  async put_known_value(Self, content_type : String, body : String) -> Unit
  async put_unknown_value(Self, content_type : String, body : String) -> Unit
}

///| Router definition
pub struct Router {
  _dispatch : async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit
}

pub async fn Router::dispatch(
  self : Router,
  request : @http.Request,
  body : &@io.Reader,
  conn : @http.ServerConnection
) -> Unit {
  (self._dispatch)(request, body, conn)
}

pub fn[  H0 : StringHandler] create_router(
  h0 : H0
) -> Router {
  Router::{
    _dispatch: async fn(req, body_stream, conn) {
      let path = strip_request_query(req.path)
      if false { () }
      else if req.meth == @http.Get && match_path_template("/type/enum/extensible/string/known-value", path) {
        ignore(body_stream)
        h0.get_known_value()
        conn.send_response(204, "No Content")
      }
      else if req.meth == @http.Get && match_path_template("/type/enum/extensible/string/unknown-value", path) {
        ignore(body_stream)
        h0.get_unknown_value()
        conn.send_response(204, "No Content")
      }
      else if req.meth == @http.Put && match_path_template("/type/enum/extensible/string/known-value", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_3_content_type = ""
        let p_3_body = body_str
        h0.put_known_value(p_3_content_type, p_3_body)
        conn.send_response(204, "No Content")
      }
      else if req.meth == @http.Put && match_path_template("/type/enum/extensible/string/unknown-value", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_4_content_type = ""
        let p_4_body = body_str
        h0.put_unknown_value(p_4_content_type, p_4_body)
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
