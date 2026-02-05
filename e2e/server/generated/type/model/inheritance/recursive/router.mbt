///|
/// Traits for operation handlers
pub(open) trait RecursiveHandler {
  async put(Self, group~ : @async.TaskGroup[Unit], body : Extension) -> Unit
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Extension
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
  RecursivePut
  RecursiveGet
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
    [.. "/type/model/inheritance/recursive", .. path] => {
      if path.length() == 0 {
        match meth {
          @http.Put => return MatchRouteResult::Matched(RouteId::RecursivePut)
          @http.Get => return MatchRouteResult::Matched(RouteId::RecursiveGet)
          _ => return MatchRouteResult::MethodNotAllowed
        }
      }
      return MatchRouteResult::NotMatched
    }
    _ => return MatchRouteResult::NotMatched
  }
}

///|
pub fn[H0 : RecursiveHandler] create_router(
  recursive_handler~ : H0,
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
          RouteId::RecursivePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_1_body : Extension = @json.from_json(@json.parse(body_str))
            recursive_handler.put(group~, p_1_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::RecursiveGet => {
            ignore(body_stream)
            let resp_body = recursive_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
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
