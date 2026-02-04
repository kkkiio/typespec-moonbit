///|
/// Traits for operation handlers
pub(open) trait StringHandler {
  async get_known_value(Self, group~ : @async.TaskGroup[Unit]) -> String
  async get_unknown_value(Self, group~ : @async.TaskGroup[Unit]) -> String
  async put_known_value(
    Self,
    group~ : @async.TaskGroup[Unit],
    content_type : String,
    body : String,
  ) -> Unit
  async put_unknown_value(
    Self,
    group~ : @async.TaskGroup[Unit],
    content_type : String,
    body : String,
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
  StringGetKnownValue
  StringGetUnknownValue
  StringPutKnownValue
  StringPutUnknownValue
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
    [.. "/type/enum/extensible/string/", .. path] => {
      if path.length() == 0 {
        return MatchRouteResult::NotMatched
      }
      match path {
        [.. "known-value", .. path] => {
          if path.length() == 0 {
            match meth {
              @http.Get =>
                return MatchRouteResult::Matched(RouteId::StringGetKnownValue)
              @http.Put =>
                return MatchRouteResult::Matched(RouteId::StringPutKnownValue)
              _ => return MatchRouteResult::MethodNotAllowed
            }
          }
          return MatchRouteResult::NotMatched
        }
        [.. "unknown-value", .. path] => {
          if path.length() == 0 {
            match meth {
              @http.Get =>
                return MatchRouteResult::Matched(RouteId::StringGetUnknownValue)
              @http.Put =>
                return MatchRouteResult::Matched(RouteId::StringPutUnknownValue)
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
pub fn[H0 : StringHandler] create_router(
  string_handler~ : H0,
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
          RouteId::StringGetKnownValue => {
            ignore(body_stream)
            let resp_body = string_handler.get_known_value(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::StringGetUnknownValue => {
            ignore(body_stream)
            let resp_body = string_handler.get_unknown_value(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::StringPutKnownValue => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_3_content_type = @runtime.get_header(
              req.headers,
              "Content-Type",
            )
            let p_3_body : String = @json.from_json(@json.parse(body_str))
            string_handler.put_known_value(group~, p_3_content_type, p_3_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::StringPutUnknownValue => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_4_content_type = @runtime.get_header(
              req.headers,
              "Content-Type",
            )
            let p_4_body : String = @json.from_json(@json.parse(body_str))
            string_handler.put_unknown_value(group~, p_4_content_type, p_4_body)
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
