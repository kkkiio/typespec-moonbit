///|
/// Traits for operation handlers
pub(open) trait RecursiveHandler {
  async put(Self, body : Extension) -> Unit
  async get(Self) -> Extension
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : RecursiveHandler] create_router(recursive_handler~ : H0) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if false {
      ()
    } else if req.meth == @http.Put &&
      match_path_template("/type/model/inheritance/recursive", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_1_body : Extension = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      recursive_handler.put(p_1_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/model/inheritance/recursive", path) {
      ignore(body_stream)
      let resp_body = recursive_handler.get()
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
