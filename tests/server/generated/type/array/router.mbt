///|

///|
/// Traits for operation handlers
pub(open) trait Int32ValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[Int]
  async put(self : Self, group~ : @async.TaskGroup[Unit], body : Array[Int]) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait Int64ValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[Int64]
  async put(self : Self, group~ : @async.TaskGroup[Unit], body : Array[Int64]) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait BooleanValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[Bool]
  async put(self : Self, group~ : @async.TaskGroup[Unit], body : Array[Bool]) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait StringValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[String]
  async put(self : Self, group~ : @async.TaskGroup[Unit], body : Array[String]) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait Float32ValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[Double]
  async put(self : Self, group~ : @async.TaskGroup[Unit], body : Array[Double]) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait DatetimeValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[String]
  async put(self : Self, group~ : @async.TaskGroup[Unit], body : Array[String]) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait DurationValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[String]
  async put(self : Self, group~ : @async.TaskGroup[Unit], body : Array[String]) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait UnknownValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[Json]
  async put(self : Self, group~ : @async.TaskGroup[Unit], body : Array[Json]) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait ModelValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[InnerModel]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Array[InnerModel],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait NullableFloatValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[
    @runtime.Nullable[Double],
  ]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Array[@runtime.Nullable[Double]],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait NullableInt32ValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[
    @runtime.Nullable[Int],
  ]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Array[@runtime.Nullable[Int]],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait NullableBooleanValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[
    @runtime.Nullable[Bool],
  ]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Array[@runtime.Nullable[Bool]],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait NullableStringValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[
    @runtime.Nullable[String],
  ]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Array[@runtime.Nullable[String]],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait NullableModelValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Array[
    @runtime.Nullable[InnerModel],
  ]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Array[@runtime.Nullable[InnerModel]],
  ) -> Unit
}

///|

///|
/// 路由匹配结果。
pub(all) enum RouteMatch {
  Handled
  NotMatched
  MethodNotAllowed
}

///|
pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> RouteMatch

///|

///|
/// 生成期固定的路由 ID（用于 match_route 的返回值）。
pub(all) enum RouteId {
  Int32ValueGet
  Int32ValuePut
  Int64ValueGet
  Int64ValuePut
  BooleanValueGet
  BooleanValuePut
  StringValueGet
  StringValuePut
  Float32ValueGet
  Float32ValuePut
  DatetimeValueGet
  DatetimeValuePut
  DurationValueGet
  DurationValuePut
  UnknownValueGet
  UnknownValuePut
  ModelValueGet
  ModelValuePut
  NullableFloatValueGet
  NullableFloatValuePut
  NullableInt32ValueGet
  NullableInt32ValuePut
  NullableBooleanValueGet
  NullableBooleanValuePut
  NullableStringValueGet
  NullableStringValuePut
  NullableModelValueGet
  NullableModelValuePut
}

///|

///|
/// 路由匹配结果（纯匹配：不读 body、不写响应、不调用 handler）。
pub(all) enum MatchRouteResult {
  NotMatched
  MethodNotAllowed
  Matched(RouteId)
}

///|

///|
/// 匹配 method + path，并返回命中的 RouteId（若命中）。
pub fn match_route(
  meth : @http.RequestMethod,
  full_path : String,
) -> MatchRouteResult {
  let path = @runtime.strip_request_query(full_path)
  if path.length() == 0 {
    return MatchRouteResult::NotMatched
  }
  match path {
    [.. "/type/array/", .. path] => {
      if path.length() == 0 {
        return MatchRouteResult::NotMatched
      }
      match path {
        [.. "int", .. path] => {
          if path.length() == 0 {
            return MatchRouteResult::NotMatched
          }
          match path {
            [.. "32", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Get =>
                    return MatchRouteResult::Matched(RouteId::Int32ValueGet)
                  @http.Put =>
                    return MatchRouteResult::Matched(RouteId::Int32ValuePut)
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            [.. "64", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Get =>
                    return MatchRouteResult::Matched(RouteId::Int64ValueGet)
                  @http.Put =>
                    return MatchRouteResult::Matched(RouteId::Int64ValuePut)
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            _ => return MatchRouteResult::NotMatched
          }
        }
        [.. "boolean", .. path] => {
          if path.length() == 0 {
            match meth {
              @http.Get =>
                return MatchRouteResult::Matched(RouteId::BooleanValueGet)
              @http.Put =>
                return MatchRouteResult::Matched(RouteId::BooleanValuePut)
              _ => return MatchRouteResult::MethodNotAllowed
            }
          }
          return MatchRouteResult::NotMatched
        }
        [.. "string", .. path] => {
          if path.length() == 0 {
            match meth {
              @http.Get =>
                return MatchRouteResult::Matched(RouteId::StringValueGet)
              @http.Put =>
                return MatchRouteResult::Matched(RouteId::StringValuePut)
              _ => return MatchRouteResult::MethodNotAllowed
            }
          }
          return MatchRouteResult::NotMatched
        }
        [.. "float32", .. path] => {
          if path.length() == 0 {
            match meth {
              @http.Get =>
                return MatchRouteResult::Matched(RouteId::Float32ValueGet)
              @http.Put =>
                return MatchRouteResult::Matched(RouteId::Float32ValuePut)
              _ => return MatchRouteResult::MethodNotAllowed
            }
          }
          return MatchRouteResult::NotMatched
        }
        [.. "d", .. path] => {
          if path.length() == 0 {
            return MatchRouteResult::NotMatched
          }
          match path {
            [.. "atetime", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Get =>
                    return MatchRouteResult::Matched(RouteId::DatetimeValueGet)
                  @http.Put =>
                    return MatchRouteResult::Matched(RouteId::DatetimeValuePut)
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            [.. "uration", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Get =>
                    return MatchRouteResult::Matched(RouteId::DurationValueGet)
                  @http.Put =>
                    return MatchRouteResult::Matched(RouteId::DurationValuePut)
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            _ => return MatchRouteResult::NotMatched
          }
        }
        [.. "unknown", .. path] => {
          if path.length() == 0 {
            match meth {
              @http.Get =>
                return MatchRouteResult::Matched(RouteId::UnknownValueGet)
              @http.Put =>
                return MatchRouteResult::Matched(RouteId::UnknownValuePut)
              _ => return MatchRouteResult::MethodNotAllowed
            }
          }
          return MatchRouteResult::NotMatched
        }
        [.. "model", .. path] => {
          if path.length() == 0 {
            match meth {
              @http.Get =>
                return MatchRouteResult::Matched(RouteId::ModelValueGet)
              @http.Put =>
                return MatchRouteResult::Matched(RouteId::ModelValuePut)
              _ => return MatchRouteResult::MethodNotAllowed
            }
          }
          return MatchRouteResult::NotMatched
        }
        [.. "nullable-", .. path] => {
          if path.length() == 0 {
            return MatchRouteResult::NotMatched
          }
          match path {
            [.. "float", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Get =>
                    return MatchRouteResult::Matched(
                      RouteId::NullableFloatValueGet,
                    )
                  @http.Put =>
                    return MatchRouteResult::Matched(
                      RouteId::NullableFloatValuePut,
                    )
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            [.. "int32", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Get =>
                    return MatchRouteResult::Matched(
                      RouteId::NullableInt32ValueGet,
                    )
                  @http.Put =>
                    return MatchRouteResult::Matched(
                      RouteId::NullableInt32ValuePut,
                    )
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            [.. "boolean", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Get =>
                    return MatchRouteResult::Matched(
                      RouteId::NullableBooleanValueGet,
                    )
                  @http.Put =>
                    return MatchRouteResult::Matched(
                      RouteId::NullableBooleanValuePut,
                    )
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            [.. "string", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Get =>
                    return MatchRouteResult::Matched(
                      RouteId::NullableStringValueGet,
                    )
                  @http.Put =>
                    return MatchRouteResult::Matched(
                      RouteId::NullableStringValuePut,
                    )
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            [.. "model", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Get =>
                    return MatchRouteResult::Matched(
                      RouteId::NullableModelValueGet,
                    )
                  @http.Put =>
                    return MatchRouteResult::Matched(
                      RouteId::NullableModelValuePut,
                    )
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
    _ => return MatchRouteResult::NotMatched
  }
}

///|
pub fn[
  H0 : Int32ValueHandler,
  H1 : Int64ValueHandler,
  H2 : BooleanValueHandler,
  H3 : StringValueHandler,
  H4 : Float32ValueHandler,
  H5 : DatetimeValueHandler,
  H6 : DurationValueHandler,
  H7 : UnknownValueHandler,
  H8 : ModelValueHandler,
  H9 : NullableFloatValueHandler,
  H10 : NullableInt32ValueHandler,
  H11 : NullableBooleanValueHandler,
  H12 : NullableStringValueHandler,
  H13 : NullableModelValueHandler,
] create_router(
  int32_value_handler~ : H0,
  int64_value_handler~ : H1,
  boolean_value_handler~ : H2,
  string_value_handler~ : H3,
  float32_value_handler~ : H4,
  datetime_value_handler~ : H5,
  duration_value_handler~ : H6,
  unknown_value_handler~ : H7,
  model_value_handler~ : H8,
  nullable_float_value_handler~ : H9,
  nullable_int32_value_handler~ : H10,
  nullable_boolean_value_handler~ : H11,
  nullable_string_value_handler~ : H12,
  nullable_model_value_handler~ : H13,
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
          RouteId::Int32ValueGet => {
            ignore(body_stream)
            let resp_body = int32_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::Int32ValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_2_body : Array[Int] = @json.from_json(@json.parse(body_str))
            int32_value_handler.put(group~, p_2_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::Int64ValueGet => {
            ignore(body_stream)
            let resp_body = int64_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::Int64ValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_4_body : Array[Int64] = @json.from_json(@json.parse(body_str))
            int64_value_handler.put(group~, p_4_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::BooleanValueGet => {
            ignore(body_stream)
            let resp_body = boolean_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::BooleanValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_6_body : Array[Bool] = @json.from_json(@json.parse(body_str))
            boolean_value_handler.put(group~, p_6_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::StringValueGet => {
            ignore(body_stream)
            let resp_body = string_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::StringValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_8_body : Array[String] = @json.from_json(
              @json.parse(body_str),
            )
            string_value_handler.put(group~, p_8_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::Float32ValueGet => {
            ignore(body_stream)
            let resp_body = float32_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::Float32ValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_10_body : Array[Double] = @json.from_json(
              @json.parse(body_str),
            )
            float32_value_handler.put(group~, p_10_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::DatetimeValueGet => {
            ignore(body_stream)
            let resp_body = datetime_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::DatetimeValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_12_body : Array[String] = @json.from_json(
              @json.parse(body_str),
            )
            datetime_value_handler.put(group~, p_12_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::DurationValueGet => {
            ignore(body_stream)
            let resp_body = duration_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::DurationValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_14_body : Array[String] = @json.from_json(
              @json.parse(body_str),
            )
            duration_value_handler.put(group~, p_14_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::UnknownValueGet => {
            ignore(body_stream)
            let resp_body = unknown_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::UnknownValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_16_body : Array[Json] = @json.from_json(@json.parse(body_str))
            unknown_value_handler.put(group~, p_16_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::ModelValueGet => {
            ignore(body_stream)
            let resp_body = model_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::ModelValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_18_body : Array[InnerModel] = @json.from_json(
              @json.parse(body_str),
            )
            model_value_handler.put(group~, p_18_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::NullableFloatValueGet => {
            ignore(body_stream)
            let resp_body = nullable_float_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::NullableFloatValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_20_body : Array[@runtime.Nullable[Double]] = @json.from_json(
              @json.parse(body_str),
            )
            nullable_float_value_handler.put(group~, p_20_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::NullableInt32ValueGet => {
            ignore(body_stream)
            let resp_body = nullable_int32_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::NullableInt32ValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_22_body : Array[@runtime.Nullable[Int]] = @json.from_json(
              @json.parse(body_str),
            )
            nullable_int32_value_handler.put(group~, p_22_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::NullableBooleanValueGet => {
            ignore(body_stream)
            let resp_body = nullable_boolean_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::NullableBooleanValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_24_body : Array[@runtime.Nullable[Bool]] = @json.from_json(
              @json.parse(body_str),
            )
            nullable_boolean_value_handler.put(group~, p_24_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::NullableStringValueGet => {
            ignore(body_stream)
            let resp_body = nullable_string_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::NullableStringValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_26_body : Array[@runtime.Nullable[String]] = @json.from_json(
              @json.parse(body_str),
            )
            nullable_string_value_handler.put(group~, p_26_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::NullableModelValueGet => {
            ignore(body_stream)
            let resp_body = nullable_model_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::NullableModelValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_28_body : Array[@runtime.Nullable[InnerModel]] = @json.from_json(
              @json.parse(body_str),
            )
            nullable_model_value_handler.put(group~, p_28_body)
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

///|
/// 创建一个带默认 fallback 的 dispatch。
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
