///|
/// Traits for operation handlers
pub(open) trait MultipleHandler {
  async no_operation_params(Self, group~ : @async.TaskGroup[Unit]) -> Unit
  async with_operation_path_param(
    Self,
    group~ : @async.TaskGroup[Unit],
    keyword : String,
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
/// 生成期固定的路由 ID（用于 match_route 的返回值）。
#warnings("-unused_constructor")
pub enum RouteId {
  MultipleNoOperationParams
  MultipleWithOperationPathParam(keyword~ : String)
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
    [.. "/server/path/multiple/", .. path] => {
      if path.length() == 0 {
        return MatchRouteResult::NotMatched
      }
      let mut __param_idx = @runtime.index_of_slash(path)
      __param_idx = if __param_idx == -1 { path.length() } else { __param_idx }
      let path = path.view(start_offset=__param_idx)
      if path.length() == 0 {
        match meth {
          @http.Get =>
            return MatchRouteResult::Matched(RouteId::MultipleNoOperationParams)
          _ => return MatchRouteResult::MethodNotAllowed
        }
      }
      match path {
        [.. "/", .. path] => {
          if path.length() == 0 {
            return MatchRouteResult::NotMatched
          }
          let mut __keyword_idx = @runtime.index_of_slash(path)
          __keyword_idx = if __keyword_idx == -1 {
            path.length()
          } else {
            __keyword_idx
          }
          let keyword = path.view(end_offset=__keyword_idx)
          let path = path.view(start_offset=__keyword_idx)
          if path.length() == 0 {
            match meth {
              @http.Get =>
                return MatchRouteResult::Matched(
                  RouteId::MultipleWithOperationPathParam(
                    keyword=keyword.to_string(),
                  ),
                )
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
pub fn[H0 : MultipleHandler] create_router(
  multiple_handler~ : H0,
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
          RouteId::MultipleNoOperationParams => {
            ignore(body_stream)
            multiple_handler.no_operation_params(group~)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::MultipleWithOperationPathParam(keyword~) => {
            ignore(body_stream)
            multiple_handler.with_operation_path_param(group~, keyword)
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
