///|
/// Model Extension
pub(all) struct Extension {
  level : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Traits for operation handlers
pub(open) trait RecursiveHandler {
  async put(Self, body : Extension) -> Unit
  async get(Self) -> Unit
}

///|
pub struct Router {
  dispatch : async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit
}

///|
pub async fn Router::dispatch(
  self : Router,
  request : @http.Request,
  body : &@io.Reader,
  conn : @http.ServerConnection,
) -> Unit {
  (self.dispatch)(request, body, conn)
}

///|
pub fn[H0 : RecursiveHandler] create_router(h0 : H0) -> Router {
  Router::{
    dispatch: async fn(req, body_stream, conn) {
      let path = strip_request_query(req.path)
      if false {
        ()
      } else if req.meth == @http.Put &&
        match_path_template("/type/model/inheritance/recursive", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_1_body : Extension = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h0.put(p_1_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Get &&
        match_path_template("/type/model/inheritance/recursive", path) {
        ignore(body_stream)
        h0.get()
        conn.send_response(204, "No Content")
      } else {
        conn.send_response(404, "NotFound")
        conn.write("not found")
      }
    },
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
