///|
/// Traits for operation handlers
pub(open) trait AliasHandler {
  async spread_as_request_body(
    Self,
    group~ : @async.TaskGroup[Unit],
    body : Model0,
  ) -> Unit
  async spread_parameter_with_inner_model(
    Self,
    group~ : @async.TaskGroup[Unit],
    id : String,
    x_ms_test_header : String,
    body : Model1,
  ) -> Unit
  async spread_as_request_parameter(
    Self,
    group~ : @async.TaskGroup[Unit],
    id : String,
    x_ms_test_header : String,
    body : Model2,
  ) -> Unit
  async spread_with_multiple_parameters(
    Self,
    group~ : @async.TaskGroup[Unit],
    id : String,
    x_ms_test_header : String,
    body : Model3,
  ) -> Unit
  async spread_parameter_with_inner_alias(
    Self,
    group~ : @async.TaskGroup[Unit],
    id : String,
    x_ms_test_header : String,
    body : Model4,
  ) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait ModelHandler {
  async spread_as_request_body(
    Self,
    group~ : @async.TaskGroup[Unit],
    body : BodyParameter5,
  ) -> Unit
  async spread_composite_request_only_with_body(
    Self,
    group~ : @async.TaskGroup[Unit],
    body : BodyParameter,
  ) -> Unit
  async spread_composite_request_without_body(
    Self,
    group~ : @async.TaskGroup[Unit],
    name : String,
    test_header : String,
  ) -> Unit
  async spread_composite_request(
    Self,
    group~ : @async.TaskGroup[Unit],
    name : String,
    test_header : String,
    body : BodyParameter,
  ) -> Unit
  async spread_composite_request_mix(
    Self,
    group~ : @async.TaskGroup[Unit],
    name : String,
    test_header : String,
    body : Model6,
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
pub fn[H0 : AliasHandler, H1 : ModelHandler] create_router(
  alias_handler~ : H0,
  model_handler~ : H1,
  group~ : @async.TaskGroup[Unit],
) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) -> RouteMatch {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if req.meth == @http.Put &&
      match_path_template("/parameters/spread/alias/request-body", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_1_body : Model0 = @json.from_json(@json.parse(body_str))
      alias_handler.spread_as_request_body(group~, p_1_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Post &&
      match_path_template(
        "/parameters/spread/alias/inner-model-parameter/{id}", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_2_id = get_path_param(
        "/parameters/spread/alias/inner-model-parameter/{id}", path, "id",
      )
      let p_2_x_ms_test_header = get_header(req.headers, "x-ms-test-header")
      let p_2_body : Model1 = @json.from_json(@json.parse(body_str))
      alias_handler.spread_parameter_with_inner_model(
        group~,
        p_2_id,
        p_2_x_ms_test_header,
        p_2_body,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template(
        "/parameters/spread/alias/request-parameter/{id}", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_3_id = get_path_param(
        "/parameters/spread/alias/request-parameter/{id}", path, "id",
      )
      let p_3_x_ms_test_header = get_header(req.headers, "x-ms-test-header")
      let p_3_body : Model2 = @json.from_json(@json.parse(body_str))
      alias_handler.spread_as_request_parameter(
        group~,
        p_3_id,
        p_3_x_ms_test_header,
        p_3_body,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template(
        "/parameters/spread/alias/multiple-parameters/{id}", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_4_id = get_path_param(
        "/parameters/spread/alias/multiple-parameters/{id}", path, "id",
      )
      let p_4_x_ms_test_header = get_header(req.headers, "x-ms-test-header")
      let p_4_body : Model3 = @json.from_json(@json.parse(body_str))
      alias_handler.spread_with_multiple_parameters(
        group~,
        p_4_id,
        p_4_x_ms_test_header,
        p_4_body,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Post &&
      match_path_template(
        "/parameters/spread/alias/inner-alias-parameter/{id}", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_5_id = get_path_param(
        "/parameters/spread/alias/inner-alias-parameter/{id}", path, "id",
      )
      let p_5_x_ms_test_header = get_header(req.headers, "x-ms-test-header")
      let p_5_body : Model4 = @json.from_json(@json.parse(body_str))
      alias_handler.spread_parameter_with_inner_alias(
        group~,
        p_5_id,
        p_5_x_ms_test_header,
        p_5_body,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template("/parameters/spread/model/request-body", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_6_body : BodyParameter5 = @json.from_json(@json.parse(body_str))
      model_handler.spread_as_request_body(group~, p_6_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template(
        "/parameters/spread/model/composite-request-only-with-body", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_7_body : BodyParameter = @json.from_json(@json.parse(body_str))
      model_handler.spread_composite_request_only_with_body(group~, p_7_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template(
        "/parameters/spread/model/composite-request-without-body/{name}", path,
      ) {
      ignore(body_stream)
      let p_8_name = get_path_param(
        "/parameters/spread/model/composite-request-without-body/{name}", path, "name",
      )
      let p_8_test_header = get_header(req.headers, "test-header")
      model_handler.spread_composite_request_without_body(
        group~,
        p_8_name,
        p_8_test_header,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template(
        "/parameters/spread/model/composite-request/{name}", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_9_name = get_path_param(
        "/parameters/spread/model/composite-request/{name}", path, "name",
      )
      let p_9_test_header = get_header(req.headers, "test-header")
      let p_9_body : BodyParameter = @json.from_json(@json.parse(body_str))
      model_handler.spread_composite_request(
        group~,
        p_9_name,
        p_9_test_header,
        p_9_body,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template(
        "/parameters/spread/model/composite-request-mix/{name}", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_10_name = get_path_param(
        "/parameters/spread/model/composite-request-mix/{name}", path, "name",
      )
      let p_10_test_header = get_header(req.headers, "test-header")
      let p_10_body : Model6 = @json.from_json(@json.parse(body_str))
      model_handler.spread_composite_request_mix(
        group~,
        p_10_name,
        p_10_test_header,
        p_10_body,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }

    // 未找到“method+path 完全匹配”的 handler。再判定是否是“path 匹配但 method 不支持”。
    let mut path_matched = false
    if match_path_template("/parameters/spread/alias/request-body", path) {
      path_matched = true
    }
    if match_path_template(
        "/parameters/spread/alias/inner-model-parameter/{id}", path,
      ) {
      path_matched = true
    }
    if match_path_template(
        "/parameters/spread/alias/request-parameter/{id}", path,
      ) {
      path_matched = true
    }
    if match_path_template(
        "/parameters/spread/alias/multiple-parameters/{id}", path,
      ) {
      path_matched = true
    }
    if match_path_template(
        "/parameters/spread/alias/inner-alias-parameter/{id}", path,
      ) {
      path_matched = true
    }
    if match_path_template("/parameters/spread/model/request-body", path) {
      path_matched = true
    }
    if match_path_template(
        "/parameters/spread/model/composite-request-only-with-body", path,
      ) {
      path_matched = true
    }
    if match_path_template(
        "/parameters/spread/model/composite-request-without-body/{name}", path,
      ) {
      path_matched = true
    }
    if match_path_template(
        "/parameters/spread/model/composite-request/{name}", path,
      ) {
      path_matched = true
    }
    if match_path_template(
        "/parameters/spread/model/composite-request-mix/{name}", path,
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
