///| Model definitions
pub(all) struct User {
  name : String
}

pub impl @json.FromJson for User with from_json(json, _path) {
  match json {
    Object(_obj) => {
      User::{ 
        name: _obj.get("name").bind(fn(j) { try { Some(@json.from_json(j)) } catch { _ => None } }).unwrap_or(""),
      }
    }
    _ => User::{name: ""}
  }
}

pub(all) struct AnonymousModel1 {
  name : String
}

pub impl @json.FromJson for AnonymousModel1 with from_json(json, _path) {
  match json {
    Object(_obj) => {
      AnonymousModel1::{ 
        name: _obj.get("name").bind(fn(j) { try { Some(@json.from_json(j)) } catch { _ => None } }).unwrap_or(""),
      }
    }
    _ => AnonymousModel1::{name: ""}
  }
}

///| Traits for operation handlers
pub(open) trait ExplicitBodyHandler {
  async simple(Self, body : User) -> Unit
}

pub(open) trait ImplicitBodyHandler {
  async simple(Self, body : AnonymousModel1) -> Unit
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

pub fn[  H0 : ExplicitBodyHandler,
  H1 : ImplicitBodyHandler] create_router(
  h0 : H0,
  h1 : H1
) -> Router {
  Router::{
    _dispatch: async fn(req, body_stream, conn) {
      let path = strip_request_query(req.path)
      if false { () }
      else if req.meth == @http.Put && match_path_template("/parameters/basic/explicit-body/simple", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_1_body : User = try { @json.from_json(@json.parse(body_str)) } catch { _ => @json.from_json(null) }
        h0.simple(p_1_body)
        conn.send_response(204, "No Content")
      }
      else if req.meth == @http.Put && match_path_template("/parameters/basic/implicit-body/simple", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_2_body : AnonymousModel1 = try { @json.from_json(@json.parse(body_str)) } catch { _ => @json.from_json(null) }
        h1.simple(p_2_body)
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
