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
/// 生成期固定的路由 ID（用于 match_route 的返回值）。
#warnings("-unused_constructor")
pub enum RouteId {
  AliasSpreadAsRequestBody
  AliasSpreadParameterWithInnerModel(id~ : String)
  AliasSpreadAsRequestParameter(id~ : String)
  AliasSpreadWithMultipleParameters(id~ : String)
  AliasSpreadParameterWithInnerAlias(id~ : String)
  ModelSpreadAsRequestBody
  ModelSpreadCompositeRequestOnlyWithBody
  ModelSpreadCompositeRequestWithoutBody(name~ : String)
  ModelSpreadCompositeRequest(name~ : String)
  ModelSpreadCompositeRequestMix(name~ : String)
}

///|
/// 路由匹配结果（纯匹配：不读 body、不写响应、不调用 handler）。
#warnings("-unused_constructor")
pub enum MatchRouteResult {
  NotMatched
  MethodNotAllowed
  Matched(RouteId)
}

///|
/// 匹配 method + path，并返回命中的 RouteId（若命中）。
///
/// 约定：
/// - `NotMatched`：path 不匹配任何 route
/// - `MethodNotAllowed`：path 匹配但 method 不支持
/// - `Matched`：method+path 匹配（并包含必要的 path 参数）
pub fn match_route(
  meth : @http.RequestMethod,
  full_path : String,
) -> MatchRouteResult {
  let path = @runtime.strip_request_query(full_path)
  if path.length() == 0 {
    return MatchRouteResult::NotMatched
  }
  match path {
    [.. "/parameters/spread/", .. path] => {
      if path.length() == 0 {
        return MatchRouteResult::NotMatched
      }
      match path {
        [.. "alias/", .. path] => {
          if path.length() == 0 {
            return MatchRouteResult::NotMatched
          }
          match path {
            [.. "request-", .. path] => {
              if path.length() == 0 {
                return MatchRouteResult::NotMatched
              }
              match path {
                [.. "body", .. path] => {
                  if path.length() == 0 {
                    match meth {
                      @http.Put =>
                        return MatchRouteResult::Matched(
                          RouteId::AliasSpreadAsRequestBody,
                        )
                      _ => return MatchRouteResult::MethodNotAllowed
                    }
                  }
                  return MatchRouteResult::NotMatched
                }
                [.. "parameter/", .. path] => {
                  if path.length() == 0 {
                    return MatchRouteResult::NotMatched
                  }
                  let mut __id_idx = @runtime.index_of_slash(path)
                  __id_idx = if __id_idx == -1 {
                    path.length()
                  } else {
                    __id_idx
                  }
                  let id = path.view(end_offset=__id_idx)
                  let path = path.view(start_offset=__id_idx)
                  if path.length() == 0 {
                    match meth {
                      @http.Put =>
                        return MatchRouteResult::Matched(
                          RouteId::AliasSpreadAsRequestParameter(
                            id=id.to_string(),
                          ),
                        )
                      _ => return MatchRouteResult::MethodNotAllowed
                    }
                  }
                  return MatchRouteResult::NotMatched
                }
                _ => return MatchRouteResult::NotMatched
              }
            }
            [.. "multiple-parameters/", .. path] => {
              if path.length() == 0 {
                return MatchRouteResult::NotMatched
              }
              let mut __id_idx = @runtime.index_of_slash(path)
              __id_idx = if __id_idx == -1 { path.length() } else { __id_idx }
              let id = path.view(end_offset=__id_idx)
              let path = path.view(start_offset=__id_idx)
              if path.length() == 0 {
                match meth {
                  @http.Put =>
                    return MatchRouteResult::Matched(
                      RouteId::AliasSpreadWithMultipleParameters(
                        id=id.to_string(),
                      ),
                    )
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            [.. "inner-", .. path] => {
              if path.length() == 0 {
                return MatchRouteResult::NotMatched
              }
              match path {
                [.. "model-parameter/", .. path] => {
                  if path.length() == 0 {
                    return MatchRouteResult::NotMatched
                  }
                  let mut __id_idx = @runtime.index_of_slash(path)
                  __id_idx = if __id_idx == -1 {
                    path.length()
                  } else {
                    __id_idx
                  }
                  let id = path.view(end_offset=__id_idx)
                  let path = path.view(start_offset=__id_idx)
                  if path.length() == 0 {
                    match meth {
                      @http.Post =>
                        return MatchRouteResult::Matched(
                          RouteId::AliasSpreadParameterWithInnerModel(
                            id=id.to_string(),
                          ),
                        )
                      _ => return MatchRouteResult::MethodNotAllowed
                    }
                  }
                  return MatchRouteResult::NotMatched
                }
                [.. "alias-parameter/", .. path] => {
                  if path.length() == 0 {
                    return MatchRouteResult::NotMatched
                  }
                  let mut __id_idx = @runtime.index_of_slash(path)
                  __id_idx = if __id_idx == -1 {
                    path.length()
                  } else {
                    __id_idx
                  }
                  let id = path.view(end_offset=__id_idx)
                  let path = path.view(start_offset=__id_idx)
                  if path.length() == 0 {
                    match meth {
                      @http.Post =>
                        return MatchRouteResult::Matched(
                          RouteId::AliasSpreadParameterWithInnerAlias(
                            id=id.to_string(),
                          ),
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
        [.. "model/", .. path] => {
          if path.length() == 0 {
            return MatchRouteResult::NotMatched
          }
          match path {
            [.. "request-body", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Put =>
                    return MatchRouteResult::Matched(
                      RouteId::ModelSpreadAsRequestBody,
                    )
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            [.. "composite-request", .. path] => {
              if path.length() == 0 {
                return MatchRouteResult::NotMatched
              }
              match path {
                [.. "/", .. path] => {
                  if path.length() == 0 {
                    return MatchRouteResult::NotMatched
                  }
                  let mut __name_idx = @runtime.index_of_slash(path)
                  __name_idx = if __name_idx == -1 {
                    path.length()
                  } else {
                    __name_idx
                  }
                  let name = path.view(end_offset=__name_idx)
                  let path = path.view(start_offset=__name_idx)
                  if path.length() == 0 {
                    match meth {
                      @http.Put =>
                        return MatchRouteResult::Matched(
                          RouteId::ModelSpreadCompositeRequest(
                            name=name.to_string(),
                          ),
                        )
                      _ => return MatchRouteResult::MethodNotAllowed
                    }
                  }
                  return MatchRouteResult::NotMatched
                }
                [.. "-", .. path] => {
                  if path.length() == 0 {
                    return MatchRouteResult::NotMatched
                  }
                  match path {
                    [.. "only-with-body", .. path] => {
                      if path.length() == 0 {
                        match meth {
                          @http.Put =>
                            return MatchRouteResult::Matched(
                              RouteId::ModelSpreadCompositeRequestOnlyWithBody,
                            )
                          _ => return MatchRouteResult::MethodNotAllowed
                        }
                      }
                      return MatchRouteResult::NotMatched
                    }
                    [.. "without-body/", .. path] => {
                      if path.length() == 0 {
                        return MatchRouteResult::NotMatched
                      }
                      let mut __name_idx = @runtime.index_of_slash(path)
                      __name_idx = if __name_idx == -1 {
                        path.length()
                      } else {
                        __name_idx
                      }
                      let name = path.view(end_offset=__name_idx)
                      let path = path.view(start_offset=__name_idx)
                      if path.length() == 0 {
                        match meth {
                          @http.Put =>
                            return MatchRouteResult::Matched(
                              RouteId::ModelSpreadCompositeRequestWithoutBody(
                                name=name.to_string(),
                              ),
                            )
                          _ => return MatchRouteResult::MethodNotAllowed
                        }
                      }
                      return MatchRouteResult::NotMatched
                    }
                    [.. "mix/", .. path] => {
                      if path.length() == 0 {
                        return MatchRouteResult::NotMatched
                      }
                      let mut __name_idx = @runtime.index_of_slash(path)
                      __name_idx = if __name_idx == -1 {
                        path.length()
                      } else {
                        __name_idx
                      }
                      let name = path.view(end_offset=__name_idx)
                      let path = path.view(start_offset=__name_idx)
                      if path.length() == 0 {
                        match meth {
                          @http.Put =>
                            return MatchRouteResult::Matched(
                              RouteId::ModelSpreadCompositeRequestMix(
                                name=name.to_string(),
                              ),
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
        _ => return MatchRouteResult::NotMatched
      }
    }
    _ => return MatchRouteResult::NotMatched
  }
}

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
    match match_route(req.meth, full_path) {
      MatchRouteResult::Matched(route_id) =>
        match route_id {
          RouteId::AliasSpreadAsRequestBody => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_1_body : Model0 = @json.from_json(@json.parse(body_str))
            alias_handler.spread_as_request_body(group~, p_1_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::AliasSpreadParameterWithInnerModel(id~) => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_2_x_ms_test_header = @runtime.get_header(
              req.headers,
              "x-ms-test-header",
            )
            let p_2_body : Model1 = @json.from_json(@json.parse(body_str))
            alias_handler.spread_parameter_with_inner_model(
              group~,
              id,
              p_2_x_ms_test_header,
              p_2_body,
            )
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::AliasSpreadAsRequestParameter(id~) => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_3_x_ms_test_header = @runtime.get_header(
              req.headers,
              "x-ms-test-header",
            )
            let p_3_body : Model2 = @json.from_json(@json.parse(body_str))
            alias_handler.spread_as_request_parameter(
              group~,
              id,
              p_3_x_ms_test_header,
              p_3_body,
            )
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::AliasSpreadWithMultipleParameters(id~) => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_4_x_ms_test_header = @runtime.get_header(
              req.headers,
              "x-ms-test-header",
            )
            let p_4_body : Model3 = @json.from_json(@json.parse(body_str))
            alias_handler.spread_with_multiple_parameters(
              group~,
              id,
              p_4_x_ms_test_header,
              p_4_body,
            )
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::AliasSpreadParameterWithInnerAlias(id~) => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_5_x_ms_test_header = @runtime.get_header(
              req.headers,
              "x-ms-test-header",
            )
            let p_5_body : Model4 = @json.from_json(@json.parse(body_str))
            alias_handler.spread_parameter_with_inner_alias(
              group~,
              id,
              p_5_x_ms_test_header,
              p_5_body,
            )
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::ModelSpreadAsRequestBody => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_6_body : BodyParameter5 = @json.from_json(
              @json.parse(body_str),
            )
            model_handler.spread_as_request_body(group~, p_6_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::ModelSpreadCompositeRequestOnlyWithBody => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_7_body : BodyParameter = @json.from_json(
              @json.parse(body_str),
            )
            model_handler.spread_composite_request_only_with_body(
              group~,
              p_7_body,
            )
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::ModelSpreadCompositeRequestWithoutBody(name~) => {
            ignore(body_stream)
            let p_8_test_header = @runtime.get_header(
              req.headers,
              "test-header",
            )
            model_handler.spread_composite_request_without_body(
              group~,
              name,
              p_8_test_header,
            )
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::ModelSpreadCompositeRequest(name~) => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_9_test_header = @runtime.get_header(
              req.headers,
              "test-header",
            )
            let p_9_body : BodyParameter = @json.from_json(
              @json.parse(body_str),
            )
            model_handler.spread_composite_request(
              group~,
              name,
              p_9_test_header,
              p_9_body,
            )
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::ModelSpreadCompositeRequestMix(name~) => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_10_test_header = @runtime.get_header(
              req.headers,
              "test-header",
            )
            let p_10_body : Model6 = @json.from_json(@json.parse(body_str))
            model_handler.spread_composite_request_mix(
              group~,
              name,
              p_10_test_header,
              p_10_body,
            )
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
