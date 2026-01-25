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
pub fn[H0 : EmptyHandler] create_router(empty_handler~ : H0) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if req.meth == @http.Put &&
      match_path_template("/type/model/empty/alone", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_1_body : EmptyInput = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      empty_handler.put_empty(p_1_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return ()
    }
    if req.meth == @http.Get &&
      match_path_template("/type/model/empty/alone", path) {
      ignore(body_stream)
      let resp_body = empty_handler.get_empty()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return ()
    }
    if req.meth == @http.Post &&
      match_path_template("/type/model/empty/round-trip", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_3_body : EmptyInputOutput = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      let resp_body = empty_handler.post_round_trip_empty(p_3_body)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return ()
    }
    conn.send_response(404, "NotFound")
    conn.write("not found")
    conn.end_response()
  }
}
