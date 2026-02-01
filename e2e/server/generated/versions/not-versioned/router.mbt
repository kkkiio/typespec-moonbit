///|
/// Traits for operation handlers
pub(open) trait NotVersionedHandler {
  async without_api_version(Self, group~ : @async.TaskGroup[Unit]) -> Unit
  async with_query_api_version(
    Self,
    group~ : @async.TaskGroup[Unit],
    api_version : String,
  ) -> Unit
  async with_path_api_version(
    Self,
    group~ : @async.TaskGroup[Unit],
    api_version : String,
  ) -> Unit
}

///|
/// 路由匹配结果。
#warnings("-unused_constructor")
pub enum RouteMatch {
  /// 已命中并写入响应（或已开始 SSE）。
  Handled
  /// 路径完全不匹配。
  NotMatched
  /// 路径匹配但 method 不被支持（可用于返回 405）。
  MethodNotAllowed
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> RouteMatch

///|
pub fn[H0 : NotVersionedHandler] create_router(
  not_versioned_handler~ : H0,
  group~ : @async.TaskGroup[Unit],
) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) -> RouteMatch {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if req.meth == @http.Head &&
      match_path_template(
        "/server/versions/not-versioned/without-api-version", path,
      ) {
      ignore(body_stream)
      not_versioned_handler.without_api_version(group~)
      conn.send_response(200, "OK")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Head &&
      match_path_template(
        "/server/versions/not-versioned/with-query-api-version", path,
      ) {
      ignore(body_stream)
      let p_2_api_version = get_query_param(full_path, "api-version")
      not_versioned_handler.with_query_api_version(group~, p_2_api_version)
      conn.send_response(200, "OK")
      conn.end_response()
      return RouteMatch::Handled
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
      not_versioned_handler.with_path_api_version(group~, p_3_api_version)
      conn.send_response(200, "OK")
      conn.end_response()
      return RouteMatch::Handled
    }

    // 未找到“method+path 完全匹配”的 handler。再判定是否是“path 匹配但 method 不支持”。
    let mut path_matched = false
    if match_path_template(
        "/server/versions/not-versioned/without-api-version", path,
      ) {
      path_matched = true
    }
    if match_path_template(
        "/server/versions/not-versioned/with-query-api-version", path,
      ) {
      path_matched = true
    }
    if match_path_template(
        "/server/versions/not-versioned/with-path-api-version/{apiVersion}", path,
      ) {
      path_matched = true
    }
    if path_matched {
      RouteMatch::MethodNotAllowed
    } else {
      RouteMatch::NotMatched
    }
  }
}

///|
/// 创建一个“带默认 fallback”的 dispatch（`async (...)->Unit`），便于直接挂到 http server。
///
/// - `Handled`：router 已写入响应
/// - `MethodNotAllowed`：发送 405
/// - `NotMatched`：发送 404
pub fn create_dispatch(
  router : Router,
) -> async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let result = router(req, body_stream, conn)
    match result {
      RouteMatch::Handled => ()
      RouteMatch::MethodNotAllowed => {
        conn.send_response(405, "Method Not Allowed")
        conn.end_response()
      }
      RouteMatch::NotMatched => {
        conn.send_response(404, "Not Found")
        conn.write("not found")
        conn.end_response()
      }
    }
  }
}
