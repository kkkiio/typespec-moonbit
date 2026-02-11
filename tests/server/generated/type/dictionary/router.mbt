///|

///|
/// Traits for operation handlers
pub(open) trait Int32ValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Map[String, Int]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Map[String, Int],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait Int64ValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Map[String, Int64]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Map[String, Int64],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait BooleanValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Map[String, Bool]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Map[String, Bool],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait StringValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Map[String, String]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Map[String, String],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait Float32ValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Map[String, Double]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Map[String, Double],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait DatetimeValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Map[String, String]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Map[String, String],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait DurationValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Map[String, String]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Map[String, String],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait UnknownValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Map[String, Json]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Map[String, Json],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait ModelValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Map[
    String,
    InnerModel,
  ]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Map[String, InnerModel],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait RecursiveModelValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Map[
    String,
    InnerModel,
  ]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Map[String, InnerModel],
  ) -> Unit
}

///|

///|
/// Traits for operation handlers
pub(open) trait NullableFloatValueHandler {
  async get(self : Self, group~ : @async.TaskGroup[Unit]) -> Map[
    String,
    @runtime.Nullable[Double],
  ]
  async put(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : Map[String, @runtime.Nullable[Double]],
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
  RecursiveModelValueGet
  RecursiveModelValuePut
  NullableFloatValueGet
  NullableFloatValuePut
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
    [.. "/type/dictionary/", .. path] => {
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
          match path {
            [.. "/recursive", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Get =>
                    return MatchRouteResult::Matched(
                      RouteId::RecursiveModelValueGet,
                    )
                  @http.Put =>
                    return MatchRouteResult::Matched(
                      RouteId::RecursiveModelValuePut,
                    )
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            _ => return MatchRouteResult::NotMatched
          }
        }
        [.. "nullable-float", .. path] => {
          if path.length() == 0 {
            match meth {
              @http.Get =>
                return MatchRouteResult::Matched(RouteId::NullableFloatValueGet)
              @http.Put =>
                return MatchRouteResult::Matched(RouteId::NullableFloatValuePut)
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
  H9 : RecursiveModelValueHandler,
  H10 : NullableFloatValueHandler,
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
  recursive_model_value_handler~ : H9,
  nullable_float_value_handler~ : H10,
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
            let p_2_body : Map[String, Int] = @json.from_json(
              @json.parse(body_str),
            )
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
            let p_4_body : Map[String, Int64] = @json.from_json(
              @json.parse(body_str),
            )
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
            let p_6_body : Map[String, Bool] = @json.from_json(
              @json.parse(body_str),
            )
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
            let p_8_body : Map[String, String] = @json.from_json(
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
            let p_10_body : Map[String, Double] = @json.from_json(
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
            let p_12_body : Map[String, String] = @json.from_json(
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
            let p_14_body : Map[String, String] = @json.from_json(
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
            let p_16_body : Map[String, Json] = @json.from_json(
              @json.parse(body_str),
            )
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
            let p_18_body : Map[String, InnerModel] = @json.from_json(
              @json.parse(body_str),
            )
            model_value_handler.put(group~, p_18_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::RecursiveModelValueGet => {
            ignore(body_stream)

            let resp_body = recursive_model_value_handler.get(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::RecursiveModelValuePut => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_20_body : Map[String, InnerModel] = @json.from_json(
              @json.parse(body_str),
            )
            recursive_model_value_handler.put(group~, p_20_body)
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
            let p_22_body : Map[String, @runtime.Nullable[Double]] = @json.from_json(
              @json.parse(body_str),
            )
            nullable_float_value_handler.put(group~, p_22_body)
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
