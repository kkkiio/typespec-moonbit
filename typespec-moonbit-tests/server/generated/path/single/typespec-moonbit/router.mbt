///|
/// Traits for operation handlers
pub(open) trait SingleHandler {
  async my_op(Self) -> Unit
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : SingleHandler] create_router(single_handler~ : H0) -> Router {
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
      match_path_template("/server/path/single/myOp", path) {
      ignore(body_stream)
      single_handler.my_op()
      conn.send_response(200, "OK")
      conn.end_response()
    } else {
      conn.send_response(404, "NotFound")
      conn.write("not found")
      conn.end_response()
    }
  }
}
