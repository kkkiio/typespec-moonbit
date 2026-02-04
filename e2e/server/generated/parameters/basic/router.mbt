///|
/// Traits for operation handlers
pub(open) trait ExplicitBodyHandler {
  async simple(Self, group~ : @async.TaskGroup[Unit], body : User) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait ImplicitBodyHandler {
  async simple(Self, group~ : @async.TaskGroup[Unit], body : Model0) -> Unit
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
/// 生成期固定的路由 ID（用于 match_route 的返回值）。
#warnings("-unused_constructor")
pub enum RouteId {
  ExplicitBodySimple
  ImplicitBodySimple
}

///|
/// 路由匹配结果（纯匹配：不读 body、不写响应、不调用 handler）。
#warnings("-unused_constructor")
pub enum MatchRouteResult {
  NotMatched
  MethodNotAllowed
  Matched(RouteId)
}

///|
/// 匹配 method + path，并返回命中的 RouteId（若命中）。
///
/// 约定：
/// - `NotMatched`：path 不匹配任何 route
/// - `MethodNotAllowed`：path 匹配但 method 不支持
/// - `Matched`：method+path 匹配（并包含必要的 path 参数）
pub fn match_route(
  meth : @http.RequestMethod,
  full_path : String,
) -> MatchRouteResult {
  let path = @runtime.strip_request_query(full_path)
  if path.length() == 0 {
    return MatchRouteResult::NotMatched
  }
  match path {
    [.. "/parameters/basic/", .. path] => {
      if path.length() == 0 {
        return MatchRouteResult::NotMatched
      }
      match path {
        [.. "explicit-body/simple", .. path] => {
          if path.length() == 0 {
            match meth {
              @http.Put =>
                return MatchRouteResult::Matched(RouteId::ExplicitBodySimple)
              _ => return MatchRouteResult::MethodNotAllowed
            }
          }
          return MatchRouteResult::NotMatched
        }
        [.. "implicit-body/simple", .. path] => {
          if path.length() == 0 {
            match meth {
              @http.Put =>
                return MatchRouteResult::Matched(RouteId::ImplicitBodySimple)
              _ => return MatchRouteResult::MethodNotAllowed
            }
          }
          return MatchRouteResult::NotMatched
        }
        _ => return MatchRouteResult::NotMatched
      }
    }
    _ => return MatchRouteResult::NotMatched
  }
}

///|
pub fn[H0 : ExplicitBodyHandler, H1 : ImplicitBodyHandler] create_router(
  explicit_body_handler~ : H0,
  implicit_body_handler~ : H1,
  group~ : @async.TaskGroup[Unit],
) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) -> RouteMatch {
    let full_path = req.path
    match match_route(req.meth, full_path) {
      MatchRouteResult::Matched(route_id) =>
        match route_id {
          RouteId::ExplicitBodySimple => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_1_body : User = @json.from_json(@json.parse(body_str))
            explicit_body_handler.simple(group~, p_1_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::ImplicitBodySimple => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_2_body : Model0 = @json.from_json(@json.parse(body_str))
            implicit_body_handler.simple(group~, p_2_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
        }
      MatchRouteResult::MethodNotAllowed => RouteMatch::MethodNotAllowed
      MatchRouteResult::NotMatched => RouteMatch::NotMatched
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
