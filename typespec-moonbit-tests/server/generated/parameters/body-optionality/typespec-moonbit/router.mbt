///|
/// Traits for operation handlers
pub(open) trait BodyOptionalityHandler {
  async required_explicit(
    Self,
    group~ : @async.TaskGroup[Unit],
    body : BodyModel,
  ) -> Unit
  async required_implicit(
    Self,
    group~ : @async.TaskGroup[Unit],
    body : BodyModel0,
  ) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait OptionalExplicitHandler {
  async set(Self, group~ : @async.TaskGroup[Unit], body : BodyModel) -> Unit
  async omit(Self, group~ : @async.TaskGroup[Unit], body : BodyModel) -> Unit
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
pub fn[H0 : BodyOptionalityHandler, H1 : OptionalExplicitHandler] create_router(
  body_optionality_handler~ : H0,
  optional_explicit_handler~ : H1,
  group~ : @async.TaskGroup[Unit],
) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) -> RouteMatch {
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
      body_optionality_handler.required_explicit(group~, p_1_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
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
      body_optionality_handler.required_implicit(group~, p_2_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
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
      optional_explicit_handler.set(group~, p_3_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
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
      optional_explicit_handler.omit(group~, p_4_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }

    // 未找到“method+path 完全匹配”的 handler。再判定是否是“path 匹配但 method 不支持”。
    let mut path_matched = false
    if match_path_template(
        "/parameters/body-optionality/required-explicit", path,
      ) {
      path_matched = true
    }
    if match_path_template(
        "/parameters/body-optionality/required-implicit", path,
      ) {
      path_matched = true
    }
    if match_path_template(
        "/parameters/body-optionality/optional-explicit/set", path,
      ) {
      path_matched = true
    }
    if match_path_template(
        "/parameters/body-optionality/optional-explicit/omit", path,
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
