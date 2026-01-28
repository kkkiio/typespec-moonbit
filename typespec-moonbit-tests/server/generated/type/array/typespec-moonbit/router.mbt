///|
/// Traits for operation handlers
pub(open) trait Int32ValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[Int]
  async put(Self, group~ : @async.TaskGroup[Unit], body : Array[Int]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait Int64ValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[Int64]
  async put(Self, group~ : @async.TaskGroup[Unit], body : Array[Int64]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait ModelValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[InnerModel]
  async put(Self, group~ : @async.TaskGroup[Unit], body : Array[InnerModel]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait StringValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[String]
  async put(Self, group~ : @async.TaskGroup[Unit], body : Array[String]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait BooleanValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[Bool]
  async put(Self, group~ : @async.TaskGroup[Unit], body : Array[Bool]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait Float32ValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[Double]
  async put(Self, group~ : @async.TaskGroup[Unit], body : Array[Double]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait UnknownValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[Json]
  async put(Self, group~ : @async.TaskGroup[Unit], body : Array[Json]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait DatetimeValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[String]
  async put(Self, group~ : @async.TaskGroup[Unit], body : Array[String]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait DurationValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[String]
  async put(Self, group~ : @async.TaskGroup[Unit], body : Array[String]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableFloatValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[Nullable[Double]]
  async put(
    Self,
    group~ : @async.TaskGroup[Unit],
    body : Array[Nullable[Double]],
  ) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableInt32ValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[Nullable[Int]]
  async put(Self, group~ : @async.TaskGroup[Unit], body : Array[Nullable[Int]]) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableModelValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[
    Nullable[InnerModel],
  ]
  async put(
    Self,
    group~ : @async.TaskGroup[Unit],
    body : Array[Nullable[InnerModel]],
  ) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableStringValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[Nullable[String]]
  async put(
    Self,
    group~ : @async.TaskGroup[Unit],
    body : Array[Nullable[String]],
  ) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait NullableBooleanValueHandler {
  async get(Self, group~ : @async.TaskGroup[Unit]) -> Array[Nullable[Bool]]
  async put(Self, group~ : @async.TaskGroup[Unit], body : Array[Nullable[Bool]]) -> Unit
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
  group~ : @async.TaskGroup[Unit],
) -> Router {
  async fn(
    req : @http.Request,
    body_stream : &@io.Reader,
    conn : @http.ServerConnection,
  ) -> RouteMatch {
    let full_path = req.path
    let path = strip_request_query(full_path)
    if req.meth == @http.Get && match_path_template("/type/array/int32", path) {
      ignore(body_stream)
      let resp_body = int32_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put && match_path_template("/type/array/int32", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_2_body : Array[Int] = @json.from_json(@json.parse(body_str))
      int32_value_handler.put(group~, p_2_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get && match_path_template("/type/array/int64", path) {
      ignore(body_stream)
      let resp_body = int64_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put && match_path_template("/type/array/int64", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_4_body : Array[Int64] = @json.from_json(@json.parse(body_str))
      int64_value_handler.put(group~, p_4_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get && match_path_template("/type/array/model", path) {
      ignore(body_stream)
      let resp_body = model_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put && match_path_template("/type/array/model", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_6_body : Array[InnerModel] = @json.from_json(@json.parse(body_str))
      model_value_handler.put(group~, p_6_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get && match_path_template("/type/array/string", path) {
      ignore(body_stream)
      let resp_body = string_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put && match_path_template("/type/array/string", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_8_body : Array[String] = @json.from_json(@json.parse(body_str))
      string_value_handler.put(group~, p_8_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get && match_path_template("/type/array/boolean", path) {
      ignore(body_stream)
      let resp_body = boolean_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put && match_path_template("/type/array/boolean", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_10_body : Array[Bool] = @json.from_json(@json.parse(body_str))
      boolean_value_handler.put(group~, p_10_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get && match_path_template("/type/array/float32", path) {
      ignore(body_stream)
      let resp_body = float32_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put && match_path_template("/type/array/float32", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_12_body : Array[Double] = @json.from_json(@json.parse(body_str))
      float32_value_handler.put(group~, p_12_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get && match_path_template("/type/array/unknown", path) {
      ignore(body_stream)
      let resp_body = unknown_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put && match_path_template("/type/array/unknown", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_14_body : Array[Json] = @json.from_json(@json.parse(body_str))
      unknown_value_handler.put(group~, p_14_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get &&
      match_path_template("/type/array/datetime", path) {
      ignore(body_stream)
      let resp_body = datetime_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template("/type/array/datetime", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_16_body : Array[String] = @json.from_json(@json.parse(body_str))
      datetime_value_handler.put(group~, p_16_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get &&
      match_path_template("/type/array/duration", path) {
      ignore(body_stream)
      let resp_body = duration_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template("/type/array/duration", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_18_body : Array[String] = @json.from_json(@json.parse(body_str))
      duration_value_handler.put(group~, p_18_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get &&
      match_path_template("/type/array/nullable-float", path) {
      ignore(body_stream)
      let resp_body = nullable_float_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template("/type/array/nullable-float", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_20_body : Array[Nullable[Double]] = @json.from_json(
        @json.parse(body_str),
      )
      nullable_float_value_handler.put(group~, p_20_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get &&
      match_path_template("/type/array/nullable-int32", path) {
      ignore(body_stream)
      let resp_body = nullable_int32_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template("/type/array/nullable-int32", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_22_body : Array[Nullable[Int]] = @json.from_json(
        @json.parse(body_str),
      )
      nullable_int32_value_handler.put(group~, p_22_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get &&
      match_path_template("/type/array/nullable-model", path) {
      ignore(body_stream)
      let resp_body = nullable_model_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template("/type/array/nullable-model", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_24_body : Array[Nullable[InnerModel]] = @json.from_json(
        @json.parse(body_str),
      )
      nullable_model_value_handler.put(group~, p_24_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get &&
      match_path_template("/type/array/nullable-string", path) {
      ignore(body_stream)
      let resp_body = nullable_string_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template("/type/array/nullable-string", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_26_body : Array[Nullable[String]] = @json.from_json(
        @json.parse(body_str),
      )
      nullable_string_value_handler.put(group~, p_26_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Get &&
      match_path_template("/type/array/nullable-boolean", path) {
      ignore(body_stream)
      let resp_body = nullable_boolean_value_handler.get(group~)
      let headers : Map[String, String] = { "content-type": "application/json" }
      conn.send_response(200, "OK", extra_headers=headers)
      conn.write(resp_body.to_json().stringify())
      conn.end_response()
      return RouteMatch::Handled
    }
    if req.meth == @http.Put &&
      match_path_template("/type/array/nullable-boolean", path) {
      let body_bytes = body_stream.read_all()
      let body_str = body_bytes.text()
      let p_28_body : Array[Nullable[Bool]] = @json.from_json(
        @json.parse(body_str),
      )
      nullable_boolean_value_handler.put(group~, p_28_body)
      conn.send_response(204, "No Content")
      conn.end_response()
      return RouteMatch::Handled
    }

    // 未找到“method+path 完全匹配”的 handler。再判定是否是“path 匹配但 method 不支持”。
    let mut path_matched = false
    if match_path_template("/type/array/int32", path) {
      path_matched = true
    }
    if match_path_template("/type/array/int32", path) {
      path_matched = true
    }
    if match_path_template("/type/array/int64", path) {
      path_matched = true
    }
    if match_path_template("/type/array/int64", path) {
      path_matched = true
    }
    if match_path_template("/type/array/model", path) {
      path_matched = true
    }
    if match_path_template("/type/array/model", path) {
      path_matched = true
    }
    if match_path_template("/type/array/string", path) {
      path_matched = true
    }
    if match_path_template("/type/array/string", path) {
      path_matched = true
    }
    if match_path_template("/type/array/boolean", path) {
      path_matched = true
    }
    if match_path_template("/type/array/boolean", path) {
      path_matched = true
    }
    if match_path_template("/type/array/float32", path) {
      path_matched = true
    }
    if match_path_template("/type/array/float32", path) {
      path_matched = true
    }
    if match_path_template("/type/array/unknown", path) {
      path_matched = true
    }
    if match_path_template("/type/array/unknown", path) {
      path_matched = true
    }
    if match_path_template("/type/array/datetime", path) {
      path_matched = true
    }
    if match_path_template("/type/array/datetime", path) {
      path_matched = true
    }
    if match_path_template("/type/array/duration", path) {
      path_matched = true
    }
    if match_path_template("/type/array/duration", path) {
      path_matched = true
    }
    if match_path_template("/type/array/nullable-float", path) {
      path_matched = true
    }
    if match_path_template("/type/array/nullable-float", path) {
      path_matched = true
    }
    if match_path_template("/type/array/nullable-int32", path) {
      path_matched = true
    }
    if match_path_template("/type/array/nullable-int32", path) {
      path_matched = true
    }
    if match_path_template("/type/array/nullable-model", path) {
      path_matched = true
    }
    if match_path_template("/type/array/nullable-model", path) {
      path_matched = true
    }
    if match_path_template("/type/array/nullable-string", path) {
      path_matched = true
    }
    if match_path_template("/type/array/nullable-string", path) {
      path_matched = true
    }
    if match_path_template("/type/array/nullable-boolean", path) {
      path_matched = true
    }
    if match_path_template("/type/array/nullable-boolean", path) {
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
