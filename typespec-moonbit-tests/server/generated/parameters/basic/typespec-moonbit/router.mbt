///|
/// Traits for operation handlers
pub(open) trait ExplicitBodyHandler {
  async simple(Self, body : User) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait ImplicitBodyHandler {
  async simple(Self, body : Model0) -> Unit
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : ExplicitBodyHandler, H1 : ImplicitBodyHandler] create_router(
  explicit_body_handler~ : H0,
  implicit_body_handler~ : H1,
) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if req.meth == @http.Put &&
      match_path_template("/parameters/basic/explicit-body/simple", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_1_body : User = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      explicit_body_handler.simple(p_1_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return ()
    }
    if req.meth == @http.Put &&
      match_path_template("/parameters/basic/implicit-body/simple", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_2_body : Model0 = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      implicit_body_handler.simple(p_2_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return ()
    }
    conn.send_response(404, "NotFound")
    conn.write("not found")
    conn.end_response()
  }
}
