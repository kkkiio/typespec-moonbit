///|
/// Traits for operation handlers
pub(open) trait Int32ValueHandler {
  async get(Self) -> Map[String, Int]
  async put(Self, body : Map[String, Int]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait Int64ValueHandler {
  async get(Self) -> Map[String, Int64]
  async put(Self, body : Map[String, Int64]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait ModelValueHandler {
  async get(Self) -> Map[String, InnerModel]
  async put(Self, body : Map[String, InnerModel]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait StringValueHandler {
  async get(Self) -> Map[String, String]
  async put(Self, body : Map[String, String]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait BooleanValueHandler {
  async get(Self) -> Map[String, Bool]
  async put(Self, body : Map[String, Bool]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait Float32ValueHandler {
  async get(Self) -> Map[String, Double]
  async put(Self, body : Map[String, Double]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait UnknownValueHandler {
  async get(Self) -> Map[String, Json]
  async put(Self, body : Map[String, Json]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait DatetimeValueHandler {
  async get(Self) -> Map[String, String]
  async put(Self, body : Map[String, String]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait DurationValueHandler {
  async get(Self) -> Map[String, String]
  async put(Self, body : Map[String, String]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableFloatValueHandler {
  async get(Self) -> Map[String, Nullable[Double]]
  async put(Self, body : Map[String, Nullable[Double]]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait RecursiveModelValueHandler {
  async get(Self) -> Map[String, InnerModel]
  async put(Self, body : Map[String, InnerModel]) -> Unit
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
pub fn[
  H0 : Int32ValueHandler,
  H1 : Int64ValueHandler,
  H2 : ModelValueHandler,
  H3 : StringValueHandler,
  H4 : BooleanValueHandler,
  H5 : Float32ValueHandler,
  H6 : UnknownValueHandler,
  H7 : DatetimeValueHandler,
  H8 : DurationValueHandler,
  H9 : NullableFloatValueHandler,
  H10 : RecursiveModelValueHandler,
] create_router(
  int32_value_handler~ : H0,
  int64_value_handler~ : H1,
  model_value_handler~ : H2,
  string_value_handler~ : H3,
  boolean_value_handler~ : H4,
  float32_value_handler~ : H5,
  unknown_value_handler~ : H6,
  datetime_value_handler~ : H7,
  duration_value_handler~ : H8,
  nullable_float_value_handler~ : H9,
  recursive_model_value_handler~ : H10,
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
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/int32", path) {
      ignore(body_stream)
      let resp_body = int32_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/int32", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_2_body : Map[String, Int] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      int32_value_handler.put(p_2_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/int64", path) {
      ignore(body_stream)
      let resp_body = int64_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/int64", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_4_body : Map[String, Int64] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      int64_value_handler.put(p_4_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/model", path) {
      ignore(body_stream)
      let resp_body = model_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/model", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_6_body : Map[String, InnerModel] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      model_value_handler.put(p_6_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/string", path) {
      ignore(body_stream)
      let resp_body = string_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/string", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_8_body : Map[String, String] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      string_value_handler.put(p_8_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/boolean", path) {
      ignore(body_stream)
      let resp_body = boolean_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/boolean", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_10_body : Map[String, Bool] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      boolean_value_handler.put(p_10_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/float32", path) {
      ignore(body_stream)
      let resp_body = float32_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/float32", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_12_body : Map[String, Double] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      float32_value_handler.put(p_12_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/unknown", path) {
      ignore(body_stream)
      let resp_body = unknown_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/unknown", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_14_body : Map[String, Json] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      unknown_value_handler.put(p_14_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/datetime", path) {
      ignore(body_stream)
      let resp_body = datetime_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/datetime", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_16_body : Map[String, String] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      datetime_value_handler.put(p_16_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/duration", path) {
      ignore(body_stream)
      let resp_body = duration_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/duration", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_18_body : Map[String, String] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      duration_value_handler.put(p_18_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/nullable-float", path) {
      ignore(body_stream)
      let resp_body = nullable_float_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/nullable-float", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_20_body : Map[String, Nullable[Double]] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      nullable_float_value_handler.put(p_20_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/dictionary/model/recursive", path) {
      ignore(body_stream)
      let resp_body = recursive_model_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/dictionary/model/recursive", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_22_body : Map[String, InnerModel] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      recursive_model_value_handler.put(p_22_body)
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
