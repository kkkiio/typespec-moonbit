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
pub fn[H0 : NotVersionedHandler] create_router(
  not_versioned_handler~ : H0,
) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if req.meth == @http.Head &&
      match_path_template(
        "/server/versions/not-versioned/without-api-version", path,
      ) {
      ignore(body_stream)
      not_versioned_handler.without_api_version()
      conn.send_response(200, "OK")
      conn.end_response()
      return ()
    }
    if req.meth == @http.Head &&
      match_path_template(
        "/server/versions/not-versioned/with-query-api-version", path,
      ) {
      ignore(body_stream)
      let p_2_api_version = get_query_param(full_path, "api-version")
      not_versioned_handler.with_query_api_version(p_2_api_version)
      conn.send_response(200, "OK")
      conn.end_response()
      return ()
    }
    if req.meth == @http.Head &&
      match_path_template(
        "/server/versions/not-versioned/with-path-api-version/{apiVersion}", path,
      ) {
      ignore(body_stream)
      let p_3_api_version = get_path_param(
        "/server/versions/not-versioned/with-path-api-version/{apiVersion}", path,
        "apiVersion",
      )
      not_versioned_handler.with_path_api_version(p_3_api_version)
      conn.send_response(200, "OK")
      conn.end_response()
      return ()
    }
    conn.send_response(404, "NotFound")
    conn.write("not found")
    conn.end_response()
  }
}
