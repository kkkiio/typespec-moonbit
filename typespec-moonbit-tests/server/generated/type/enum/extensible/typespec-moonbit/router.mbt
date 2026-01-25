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
pub fn[H0 : StringHandler] create_router(string_handler~ : H0) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if false {
      ()
    } else if req.meth == @http.Get &&
      match_path_template("/type/enum/extensible/string/known-value", path) {
      ignore(body_stream)
      let resp_body = string_handler.get_known_value()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/enum/extensible/string/unknown-value", path) {
      ignore(body_stream)
      let resp_body = string_handler.get_unknown_value()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/enum/extensible/string/known-value", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_3_content_type = get_header(req.headers, "Content-Type")
      let p_3_body = body_str
      string_handler.put_known_value(p_3_content_type, p_3_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/enum/extensible/string/unknown-value", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_4_content_type = get_header(req.headers, "Content-Type")
      let p_4_body = body_str
      string_handler.put_unknown_value(p_4_content_type, p_4_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else {
      conn.send_response(404, "NotFound")
      conn.write("not found")
      conn.end_response()
    }
  }
}
