///|
/// Traits for operation handlers
pub(open) trait Int32ValueHandler {
  async get(Self) -> Array[Int]
  async put(Self, body : Array[Int]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait Int64ValueHandler {
  async get(Self) -> Array[Int64]
  async put(Self, body : Array[Int64]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait ModelValueHandler {
  async get(Self) -> Array[InnerModel]
  async put(Self, body : Array[InnerModel]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait StringValueHandler {
  async get(Self) -> Array[String]
  async put(Self, body : Array[String]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait BooleanValueHandler {
  async get(Self) -> Array[Bool]
  async put(Self, body : Array[Bool]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait Float32ValueHandler {
  async get(Self) -> Array[Double]
  async put(Self, body : Array[Double]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait UnknownValueHandler {
  async get(Self) -> Array[Json]
  async put(Self, body : Array[Json]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait DatetimeValueHandler {
  async get(Self) -> Array[String]
  async put(Self, body : Array[String]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait DurationValueHandler {
  async get(Self) -> Array[String]
  async put(Self, body : Array[String]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableFloatValueHandler {
  async get(Self) -> Array[Nullable[Double]]
  async put(Self, body : Array[Nullable[Double]]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableInt32ValueHandler {
  async get(Self) -> Array[Nullable[Int]]
  async put(Self, body : Array[Nullable[Int]]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableModelValueHandler {
  async get(Self) -> Array[Nullable[InnerModel]]
  async put(Self, body : Array[Nullable[InnerModel]]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableStringValueHandler {
  async get(Self) -> Array[Nullable[String]]
  async put(Self, body : Array[Nullable[String]]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableBooleanValueHandler {
  async get(Self) -> Array[Nullable[Bool]]
  async put(Self, body : Array[Nullable[Bool]]) -> Unit
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
  H10 : NullableInt32ValueHandler,
  H11 : NullableModelValueHandler,
  H12 : NullableStringValueHandler,
  H13 : NullableBooleanValueHandler,
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
  nullable_int32_value_handler~ : H10,
  nullable_model_value_handler~ : H11,
  nullable_string_value_handler~ : H12,
  nullable_boolean_value_handler~ : H13,
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
      match_path_template("/type/array/int32", path) {
      ignore(body_stream)
      let resp_body = int32_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/int32", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_2_body : Array[Int] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      int32_value_handler.put(p_2_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/array/int64", path) {
      ignore(body_stream)
      let resp_body = int64_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/int64", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_4_body : Array[Int64] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      int64_value_handler.put(p_4_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/array/model", path) {
      ignore(body_stream)
      let resp_body = model_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/model", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_6_body : Array[InnerModel] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      model_value_handler.put(p_6_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/array/string", path) {
      ignore(body_stream)
      let resp_body = string_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/string", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_8_body : Array[String] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      string_value_handler.put(p_8_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/array/boolean", path) {
      ignore(body_stream)
      let resp_body = boolean_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/boolean", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_10_body : Array[Bool] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      boolean_value_handler.put(p_10_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/array/float32", path) {
      ignore(body_stream)
      let resp_body = float32_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/float32", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_12_body : Array[Double] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      float32_value_handler.put(p_12_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/array/unknown", path) {
      ignore(body_stream)
      let resp_body = unknown_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/unknown", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_14_body : Array[Json] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      unknown_value_handler.put(p_14_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/array/datetime", path) {
      ignore(body_stream)
      let resp_body = datetime_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/datetime", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_16_body : Array[String] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      datetime_value_handler.put(p_16_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/array/duration", path) {
      ignore(body_stream)
      let resp_body = duration_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/duration", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_18_body : Array[String] = @json.from_json(@json.parse(body_str)) catch {
        _ => @json.from_json(null)
      }
      duration_value_handler.put(p_18_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/array/nullable-float", path) {
      ignore(body_stream)
      let resp_body = nullable_float_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/nullable-float", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_20_body : Array[Nullable[Double]] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      nullable_float_value_handler.put(p_20_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/array/nullable-int32", path) {
      ignore(body_stream)
      let resp_body = nullable_int32_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/nullable-int32", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_22_body : Array[Nullable[Int]] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      nullable_int32_value_handler.put(p_22_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/array/nullable-model", path) {
      ignore(body_stream)
      let resp_body = nullable_model_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/nullable-model", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_24_body : Array[Nullable[InnerModel]] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      nullable_model_value_handler.put(p_24_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/array/nullable-string", path) {
      ignore(body_stream)
      let resp_body = nullable_string_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/nullable-string", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_26_body : Array[Nullable[String]] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      nullable_string_value_handler.put(p_26_body)
      conn.send_response(204, "No Content")
      conn.end_response()
    } else if req.meth == @http.Get &&
      match_path_template("/type/array/nullable-boolean", path) {
      ignore(body_stream)
      let resp_body = nullable_boolean_value_handler.get()
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
    } else if req.meth == @http.Put &&
      match_path_template("/type/array/nullable-boolean", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_28_body : Array[Nullable[Bool]] = @json.from_json(
        @json.parse(body_str),
      ) catch {
        _ => @json.from_json(null)
      }
      nullable_boolean_value_handler.put(p_28_body)
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
