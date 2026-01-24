///|
/// Model EmptyInput
pub(all) struct EmptyInput {} derive (
  Show,
  Default,
  ToJson,
  @json.FromJson(rename_fields="camelCase"),
)

///|
/// Model EmptyOutput
pub(all) struct EmptyOutput {} derive (
  Show,
  Default,
  ToJson,
  @json.FromJson(rename_fields="camelCase"),
)

///|
/// Model EmptyInputOutput
pub(all) struct EmptyInputOutput {} derive (
  Show,
  Default,
  ToJson,
  @json.FromJson(rename_fields="camelCase"),
)

///|
/// Traits for operation handlers
pub(open) trait EmptyHandler {
  async put_empty(Self, body : EmptyInput) -> Unit
  async get_empty(Self) -> EmptyOutput
  async post_round_trip_empty(Self, body : EmptyInputOutput) -> EmptyInputOutput
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : EmptyHandler] create_router(h0 : H0) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let path = strip_request_query(req.path)
    if false {
      ()
    } else if req.meth == @http.Put &&
      match_path_template("/type/model/empty/alone", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_1_body : EmptyInput = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      h0.put_empty(p_1_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/model/empty/alone", path) {
      ignore(body_stream)
      let resp_body = h0.get_empty()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Post &&
      match_path_template("/type/model/empty/round-trip", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_3_body : EmptyInputOutput = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      let resp_body = h0.post_round_trip_empty(p_3_body)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
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
