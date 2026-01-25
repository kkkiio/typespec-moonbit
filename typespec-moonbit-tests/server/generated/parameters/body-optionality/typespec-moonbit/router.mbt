///|
/// Traits for operation handlers
pub(open) trait BodyOptionalityHandler {
  async required_explicit(Self, body : BodyModel) -> Unit
  async required_implicit(Self, body : BodyModel0) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait OptionalExplicitHandler {
  async set(Self, body : BodyModel) -> Unit
  async omit(Self, body : BodyModel) -> Unit
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : BodyOptionalityHandler, H1 : OptionalExplicitHandler] create_router(
  body_optionality_handler~ : H0,
  optional_explicit_handler~ : H1,
) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if req.meth == @http.Post &&
      match_path_template(
        "/parameters/body-optionality/required-explicit", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_1_body : BodyModel = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      body_optionality_handler.required_explicit(p_1_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return ()
    }
    if req.meth == @http.Post &&
      match_path_template(
        "/parameters/body-optionality/required-implicit", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_2_body : BodyModel0 = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      body_optionality_handler.required_implicit(p_2_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return ()
    }
    if req.meth == @http.Post &&
      match_path_template(
        "/parameters/body-optionality/optional-explicit/set", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_3_body : BodyModel = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      optional_explicit_handler.set(p_3_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return ()
    }
    if req.meth == @http.Post &&
      match_path_template(
        "/parameters/body-optionality/optional-explicit/omit", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_4_body : BodyModel = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      optional_explicit_handler.omit(p_4_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return ()
    }
    conn.send_response(404, "NotFound")
    conn.write("not found")
    conn.end_response()
  }
}
