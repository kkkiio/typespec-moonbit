///|
/// Traits for operation handlers
pub(open) trait NotDefinedHandler {
  async valid(Self) -> Unit
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : NotDefinedHandler] create_router(
  not_defined_handler~ : H0,
) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if false {
      ()
    } else if req.meth == @http.Head &&
      match_path_template("/server/endpoint/not-defined/valid", path) {
      ignore(body_stream)
      not_defined_handler.valid()
      conn.send_response(200, "OK")
      conn.end_response()
    } else {
      conn.send_response(404, "NotFound")
      conn.write("not found")
      conn.end_response()
    }
  }
}
