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
pub(open) trait NotVersionedHandler {
  async without_api_version(Self) -> Unit
  async with_query_api_version(Self, api_version : String) -> Unit
  async with_path_api_version(Self, api_version : String) -> Unit
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : NotVersionedHandler] create_router(h0 : H0) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let path = strip_request_query(req.path)
    if false {
      ()
    } else if req.meth == @http.Head &&
      match_path_template(
        "/server/versions/not-versioned/without-api-version", path,
      ) {
      ignore(body_stream)
      h0.without_api_version()
      conn.send_response(200, "OK")
      conn.end_response()
    } else if req.meth == @http.Head &&
      match_path_template(
        "/server/versions/not-versioned/with-query-api-version", path,
      ) {
      ignore(body_stream)
      let p_2_api_version = ""
      h0.with_query_api_version(p_2_api_version)
      conn.send_response(200, "OK")
      conn.end_response()
    } else if req.meth == @http.Head &&
      match_path_template(
        "/server/versions/not-versioned/with-path-api-version/{apiVersion}", path,
      ) {
      ignore(body_stream)
      let p_3_api_version = ""
      h0.with_path_api_version(p_3_api_version)
      conn.send_response(200, "OK")
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
