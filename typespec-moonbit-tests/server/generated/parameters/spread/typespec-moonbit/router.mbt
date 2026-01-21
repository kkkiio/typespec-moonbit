///|
/// Model Array
pub(all) struct Array {} derive (
  Show,
  Default,
  ToJson,
  @json.FromJson(rename_fields="camelCase"),
)

///|
/// Model BodyParameter
pub(all) struct BodyParameter {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model AnonymousModel1
pub(all) struct AnonymousModel1 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model AnonymousModel2
pub(all) struct AnonymousModel2 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model AnonymousModel3
pub(all) struct AnonymousModel3 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model AnonymousModel4
pub(all) struct AnonymousModel4 {
  required_string : String
  optional_int : String
  required_int_list : Array
  optional_string_list : Array
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model AnonymousModel5
pub(all) struct AnonymousModel5 {
  name : String
  age : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model AnonymousModel6
pub(all) struct AnonymousModel6 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model AnonymousModel7
pub(all) struct AnonymousModel7 {
  prop : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Traits for operation handlers
pub(open) trait AliasHandler {
  async spread_as_request_body(Self, body : AnonymousModel1) -> Unit
  async spread_parameter_with_inner_model(
    Self,
    id : String,
    x_ms_test_header : String,
    body : AnonymousModel2,
  ) -> Unit
  async spread_as_request_parameter(
    Self,
    id : String,
    x_ms_test_header : String,
    body : AnonymousModel3,
  ) -> Unit
  async spread_with_multiple_parameters(
    Self,
    id : String,
    x_ms_test_header : String,
    body : AnonymousModel4,
  ) -> Unit
  async spread_parameter_with_inner_alias(
    Self,
    id : String,
    x_ms_test_header : String,
    body : AnonymousModel5,
  ) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait ModelHandler {
  async spread_as_request_body(Self, body : AnonymousModel6) -> Unit
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
    body : AnonymousModel7,
  ) -> Unit
}

///|
pub struct Router {
  dispatch : async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit
}

///|
pub async fn Router::dispatch(
  self : Router,
  request : @http.Request,
  body : &@io.Reader,
  conn : @http.ServerConnection,
) -> Unit {
  (self.dispatch)(request, body, conn)
}

///|
pub fn[H0 : AliasHandler, H1 : ModelHandler] create_router(
  h0 : H0,
  h1 : H1,
) -> Router {
  Router::{
    dispatch: async fn(req, body_stream, conn) {
      let path = strip_request_query(req.path)
      if false {
        ()
      } else if req.meth == @http.Put &&
        match_path_template("/parameters/spread/alias/request-body", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_1_body : AnonymousModel1 = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h0.spread_as_request_body(p_1_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Post &&
        match_path_template(
          "/parameters/spread/alias/inner-model-parameter/{id}", path,
        ) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_2_id = ""
        let p_2_x_ms_test_header = ""
        let p_2_body : AnonymousModel2 = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h0.spread_parameter_with_inner_model(
          p_2_id, p_2_x_ms_test_header, p_2_body,
        )
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template(
          "/parameters/spread/alias/request-parameter/{id}", path,
        ) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_3_id = ""
        let p_3_x_ms_test_header = ""
        let p_3_body : AnonymousModel3 = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h0.spread_as_request_parameter(p_3_id, p_3_x_ms_test_header, p_3_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template(
          "/parameters/spread/alias/multiple-parameters/{id}", path,
        ) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_4_id = ""
        let p_4_x_ms_test_header = ""
        let p_4_body : AnonymousModel4 = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h0.spread_with_multiple_parameters(
          p_4_id, p_4_x_ms_test_header, p_4_body,
        )
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Post &&
        match_path_template(
          "/parameters/spread/alias/inner-alias-parameter/{id}", path,
        ) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_5_id = ""
        let p_5_x_ms_test_header = ""
        let p_5_body : AnonymousModel5 = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h0.spread_parameter_with_inner_alias(
          p_5_id, p_5_x_ms_test_header, p_5_body,
        )
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template("/parameters/spread/model/request-body", path) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_6_body : AnonymousModel6 = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h1.spread_as_request_body(p_6_body)
        conn.send_response(204, "No Content")
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
      } else if req.meth == @http.Put &&
        match_path_template(
          "/parameters/spread/model/composite-request-without-body/{name}", path,
        ) {
        ignore(body_stream)
        let p_8_name = ""
        let p_8_test_header = ""
        h1.spread_composite_request_without_body(p_8_name, p_8_test_header)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template(
          "/parameters/spread/model/composite-request/{name}", path,
        ) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_9_name = ""
        let p_9_test_header = ""
        let p_9_body : BodyParameter = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h1.spread_composite_request(p_9_name, p_9_test_header, p_9_body)
        conn.send_response(204, "No Content")
      } else if req.meth == @http.Put &&
        match_path_template(
          "/parameters/spread/model/composite-request-mix/{name}", path,
        ) {
        let body_bytes = body_stream.read_all()
        let body_str = body_bytes.text()
        let p_10_name = ""
        let p_10_test_header = ""
        let p_10_body : AnonymousModel7 = @json.from_json(@json.parse(body_str)) catch {
          _ => @json.from_json(null)
        }
        h1.spread_composite_request_mix(p_10_name, p_10_test_header, p_10_body)
        conn.send_response(204, "No Content")
      } else {
        conn.send_response(404, "NotFound")
        conn.write("not found")
      }
    },
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
  let t = template.trim(char_set="/")
  let p = path.trim(char_set="/")
  let t_segs = if t == "" { [] } else { t.split("/").to_array() }
  let p_segs = if p == "" { [] } else { p.split("/").to_array() }
  if t_segs.length() != p_segs.length() {
    return false
  }
  for i in 0..<t_segs.length() {
    let ts = t_segs[i].to_string()
    let ps = p_segs[i].to_string()
    if ts.length() >= 2 && ts.has_prefix("{") && ts.has_suffix("}") {
      if ps == "" {
        return false
      }
    } else if ts != ps {
      return false
    }
  }
  true
}
