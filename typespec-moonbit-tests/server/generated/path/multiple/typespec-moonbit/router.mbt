///|
/// Traits for operation handlers
pub(open) trait MultipleHandler {
  async no_operation_params(Self) -> Unit
  async with_operation_path_param(Self, keyword : String) -> Unit
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : MultipleHandler] create_router(multiple_handler~ : H0) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if req.meth == @http.Get &&
      match_path_template("/server/path/multiple/{apiVersion}", path) {
      ignore(body_stream)
      multiple_handler.no_operation_params()
      conn.send_response(204, "No Content")
      conn.end_response()
      return ()
    }
    if req.meth == @http.Get &&
      match_path_template("/server/path/multiple/{apiVersion}/{keyword}", path) {
      ignore(body_stream)
      let p_2_keyword = get_path_param(
        "/server/path/multiple/{apiVersion}/{keyword}", path, "keyword",
      )
      multiple_handler.with_operation_path_param(p_2_keyword)
      conn.send_response(204, "No Content")
      conn.end_response()
      return ()
    }
    conn.send_response(404, "NotFound")
    conn.write("not found")
    conn.end_response()
  }
}
