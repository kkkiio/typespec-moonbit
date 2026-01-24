///|
/// Nullable helper used for `T | null`.
pub(all) struct Nullable[T] {
  value : T?
} derive(Show, Default)

///|
pub fn[T] Nullable::some(v : T) -> Nullable[T] {
  { value: Some(v) }
}

///|
pub fn[T] Nullable::none() -> Nullable[T] {
  { value: None }
}

///|
pub impl[T : ToJson] ToJson for Nullable[T] with to_json(self : Nullable[T]) -> Json {
  match self.value {
    Some(v) => v.to_json()
    None => Json::null()
  }
}

///|
pub impl[T : @json.FromJson] @json.FromJson for Nullable[T] with from_json(
  j : Json,
  path : @json.JsonPath,
) -> Nullable[T] raise @json.JsonDecodeError {
  if j == Json::null() {
    { value: None }
  } else {
    { value: Some(@json.from_json(j, path~)) }
  }
}

///|
/// Traits for operation handlers
pub(open) trait StringHandler {
  async get_known_value(Self) -> String
  async get_unknown_value(Self) -> String
  async put_known_value(Self, content_type : String, body : String) -> Unit
  async put_unknown_value(Self, content_type : String, body : String) -> Unit
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : StringHandler] create_router(h0 : H0) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let path = strip_request_query(req.path)
    if false {
      ()
    } else if req.meth == @http.Get &&
      match_path_template("/type/enum/extensible/string/known-value", path) {
      ignore(body_stream)
      let resp_body = h0.get_known_value()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/enum/extensible/string/unknown-value", path) {
      ignore(body_stream)
      let resp_body = h0.get_unknown_value()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/enum/extensible/string/known-value", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_3_content_type = ""
      let p_3_body = body_str
      h0.put_known_value(p_3_content_type, p_3_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/enum/extensible/string/unknown-value", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_4_content_type = ""
      let p_4_body = body_str
      h0.put_unknown_value(p_4_content_type, p_4_body)
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
