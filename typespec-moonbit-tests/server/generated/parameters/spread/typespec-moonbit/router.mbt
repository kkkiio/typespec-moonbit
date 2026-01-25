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
  h0 : H0,
  h1 : H1,
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
      h0.spread_as_request_body(p_1_body)
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
      h0.spread_parameter_with_inner_model(
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
      h0.spread_as_request_parameter(p_3_id, p_3_x_ms_test_header, p_3_body)
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
      h0.spread_with_multiple_parameters(p_4_id, p_4_x_ms_test_header, p_4_body)
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
      h0.spread_parameter_with_inner_alias(
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
      h1.spread_as_request_body(p_6_body)
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
      h1.spread_composite_request_only_with_body(p_7_body)
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
      h1.spread_composite_request_without_body(p_8_name, p_8_test_header)
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
      h1.spread_composite_request(p_9_name, p_9_test_header, p_9_body)
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
      h1.spread_composite_request_mix(p_10_name, p_10_test_header, p_10_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else {
      conn.send_response(404, "NotFound")
      conn.write("not found")
      conn.end_response()
    }
  }
}

///|
fn strip_request_query(path : String) -> String {
  let parts = path.split("?").to_array()
  if parts.length() == 0 {
    path
  } else {
    parts[0].to_string()
  }
}

///|
fn match_path_template(template : String, path : String) -> Bool {
  let tlen = template.length()
  let plen = path.length()
  let mut ti = 0
  let mut pi = 0
  while ti < tlen && pi < plen {
    if template.code_unit_at(ti) == '{' {
      // find matching `}` in template
      let mut close = ti + 1
      while close < tlen && template.code_unit_at(close) != '}' {
        close += 1
      }
      if close >= tlen {
        return false
      }
      // match a non-empty path segment
      let seg_start = pi
      while pi < plen && path.code_unit_at(pi) != '/' {
        pi += 1
      }
      if pi == seg_start {
        return false
      }
      ti = close + 1
    } else {
      if template.code_unit_at(ti) != path.code_unit_at(pi) {
        return false
      }
      ti += 1
      pi += 1
    }
  }
  ti == tlen && pi == plen
}

///|
fn get_path_param(template : String, path : String, name : String) -> String {
  let tlen = template.length()
  let plen = path.length()
  let mut ti = 0
  let mut pi = 0
  while ti < tlen && pi < plen {
    if template.code_unit_at(ti) == '{' {
      let mut close = ti + 1
      while close < tlen && template.code_unit_at(close) != '}' {
        close += 1
      }
      if close >= tlen {
        return ""
      }
      let key_sb = StringBuilder::new(size_hint=close - (ti + 1))
      for k in (ti + 1)..<close {
        key_sb.write_char(template.code_unit_at(k).to_int().unsafe_to_char())
      }
      let key = key_sb.to_string()
      let seg_start = pi
      while pi < plen && path.code_unit_at(pi) != '/' {
        pi += 1
      }
      if key == name {
        let seg_sb = StringBuilder::new(size_hint=pi - seg_start)
        for k in seg_start..<pi {
          seg_sb.write_char(path.code_unit_at(k).to_int().unsafe_to_char())
        }
        return seg_sb.to_string()
      }
      ti = close + 1
    } else {
      if template.code_unit_at(ti) != path.code_unit_at(pi) {
        return ""
      }
      ti += 1
      pi += 1
    }
  }
  ""
}

///|
fn get_header(headers : Map[String, String], name : String) -> String {
  match headers.get(name.to_lower().to_string()) {
    Some(v) => v
    None => ""
  }
}

///|
fn get_query_param(full_path : String, name : String) -> String {
  let parts = full_path.split("?").to_array()
  if parts.length() < 2 {
    return ""
  }
  let query = parts[1].to_string()
  for pair in query.split("&") {
    let kv = pair.split("=").to_array()
    if kv.length() >= 2 {
      if kv[0].to_string() == name {
        return kv[1].to_string()
      }
    }
  }
  ""
}
