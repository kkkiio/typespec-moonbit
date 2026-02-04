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
    let path = @runtime.strip_request_query(full_path)
    if req.meth == @http.Put &&
      @runtime.match_path_template("/type/model/inheritance/recursive", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_1_body : Extension = @json.from_json(@json.parse(body_str))
      recursive_handler.put(group~, p_1_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get &&
      @runtime.match_path_template("/type/model/inheritance/recursive", path) {
      ignore(body_stream)
      let resp_body = recursive_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }

    // 未找到“method+path 完全匹配”的 handler。再判定是否是“path 匹配但 method 不支持”。
    let mut path_matched = false
    if @runtime.match_path_template("/type/model/inheritance/recursive", path) {
      path_matched = true
    }
    if @runtime.match_path_template("/type/model/inheritance/recursive", path) {
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
