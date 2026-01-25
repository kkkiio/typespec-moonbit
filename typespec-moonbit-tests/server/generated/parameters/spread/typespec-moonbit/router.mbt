///|
/// Traits for operation handlers
pub(open) trait AliasHandler {
  async spread_as_request_body(Self, body : Model0) -> Unit
  async spread_parameter_with_inner_model(
    Self,
    id : String,
    x_ms_test_header : String,
    body : Model1,
  ) -> Unit
  async spread_as_request_parameter(
    Self,
    id : String,
    x_ms_test_header : String,
    body : Model2,
  ) -> Unit
  async spread_with_multiple_parameters(
    Self,
    id : String,
    x_ms_test_header : String,
    body : Model3,
  ) -> Unit
  async spread_parameter_with_inner_alias(
    Self,
    id : String,
    x_ms_test_header : String,
    body : Model4,
  ) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait ModelHandler {
  async spread_as_request_body(Self, body : BodyParameter5) -> Unit
  async spread_composite_request_only_with_body(Self, body : BodyParameter) -> Unit
  async spread_composite_request_without_body(
    Self,
    name : String,
    test_header : String,
  ) -> Unit
  async spread_composite_request(
    Self,
    name : String,
    test_header : String,
    body : BodyParameter,
  ) -> Unit
  async spread_composite_request_mix(
    Self,
    name : String,
    test_header : String,
    body : Model6,
  ) -> Unit
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[H0 : AliasHandler, H1 : ModelHandler] create_router(
  alias_handler~ : H0,
  model_handler~ : H1,
) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if false {
      ()
    } else if req.meth == @http.Put &&
      match_path_template("/parameters/spread/alias/request-body", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_1_body : Model0 = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      alias_handler.spread_as_request_body(p_1_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Post &&
      match_path_template(
        "/parameters/spread/alias/inner-model-parameter/{id}", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_2_id = get_path_param(
        "/parameters/spread/alias/inner-model-parameter/{id}", path, "id",
      )
      let p_2_x_ms_test_header = get_header(req.headers, "x-ms-test-header")
      let p_2_body : Model1 = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      alias_handler.spread_parameter_with_inner_model(
        p_2_id, p_2_x_ms_test_header, p_2_body,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template(
        "/parameters/spread/alias/request-parameter/{id}", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_3_id = get_path_param(
        "/parameters/spread/alias/request-parameter/{id}", path, "id",
      )
      let p_3_x_ms_test_header = get_header(req.headers, "x-ms-test-header")
      let p_3_body : Model2 = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      alias_handler.spread_as_request_parameter(
        p_3_id, p_3_x_ms_test_header, p_3_body,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template(
        "/parameters/spread/alias/multiple-parameters/{id}", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_4_id = get_path_param(
        "/parameters/spread/alias/multiple-parameters/{id}", path, "id",
      )
      let p_4_x_ms_test_header = get_header(req.headers, "x-ms-test-header")
      let p_4_body : Model3 = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      alias_handler.spread_with_multiple_parameters(
        p_4_id, p_4_x_ms_test_header, p_4_body,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Post &&
      match_path_template(
        "/parameters/spread/alias/inner-alias-parameter/{id}", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_5_id = get_path_param(
        "/parameters/spread/alias/inner-alias-parameter/{id}", path, "id",
      )
      let p_5_x_ms_test_header = get_header(req.headers, "x-ms-test-header")
      let p_5_body : Model4 = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      alias_handler.spread_parameter_with_inner_alias(
        p_5_id, p_5_x_ms_test_header, p_5_body,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/parameters/spread/model/request-body", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_6_body : BodyParameter5 = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      model_handler.spread_as_request_body(p_6_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template(
        "/parameters/spread/model/composite-request-only-with-body", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_7_body : BodyParameter = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      model_handler.spread_composite_request_only_with_body(p_7_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template(
        "/parameters/spread/model/composite-request-without-body/{name}", path,
      ) {
      ignore(body_stream)
      let p_8_name = get_path_param(
        "/parameters/spread/model/composite-request-without-body/{name}", path, "name",
      )
      let p_8_test_header = get_header(req.headers, "test-header")
      model_handler.spread_composite_request_without_body(
        p_8_name, p_8_test_header,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template(
        "/parameters/spread/model/composite-request/{name}", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_9_name = get_path_param(
        "/parameters/spread/model/composite-request/{name}", path, "name",
      )
      let p_9_test_header = get_header(req.headers, "test-header")
      let p_9_body : BodyParameter = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      model_handler.spread_composite_request(
        p_9_name, p_9_test_header, p_9_body,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template(
        "/parameters/spread/model/composite-request-mix/{name}", path,
      ) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_10_name = get_path_param(
        "/parameters/spread/model/composite-request-mix/{name}", path, "name",
      )
      let p_10_test_header = get_header(req.headers, "test-header")
      let p_10_body : Model6 = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      model_handler.spread_composite_request_mix(
        p_10_name, p_10_test_header, p_10_body,
      )
      conn.send_response(204, "No Content")
      conn.end_response()
    } else {
      conn.send_response(404, "NotFound")
      conn.write("not found")
      conn.end_response()
    }
  }
}
