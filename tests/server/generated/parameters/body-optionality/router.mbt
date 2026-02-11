///|
/// Traits for operation handlers
pub(open) trait BodyOptionalityHandler {
  async required_explicit(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : BodyModel,
  ) -> Unit
  async required_implicit(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    body : BodyModel1,
  ) -> Unit
}

///|
/// Traits for operation handlers
pub(open) trait OptionalExplicitHandler {
  async set(self : Self, group~ : @async.TaskGroup[Unit], body : BodyModel) -> Unit
  async omit(self : Self, group~ : @async.TaskGroup[Unit], body : BodyModel) -> Unit
}

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
/// 生成期固定的路由 ID（用于 match_route 的返回值）。
pub(all) enum RouteId {
  BodyOptionalityRequiredExplicit
  BodyOptionalityRequiredImplicit
  OptionalExplicitSet
  OptionalExplicitOmit
}

///|
/// 路由匹配结果（纯匹配：不读 body、不写响应、不调用 handler）。
pub(all) enum MatchRouteResult {
  NotMatched
  MethodNotAllowed
  Matched(RouteId)
}

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
    [.. "/parameters/body-optionality/", .. path] => {
      if path.length() == 0 {
        return MatchRouteResult::NotMatched
      }
      match path {
        [.. "required-", .. path] => {
          if path.length() == 0 {
            return MatchRouteResult::NotMatched
          }
          match path {
            [.. "explicit", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Post =>
                    return MatchRouteResult::Matched(
                      RouteId::BodyOptionalityRequiredExplicit,
                    )
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            [.. "implicit", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Post =>
                    return MatchRouteResult::Matched(
                      RouteId::BodyOptionalityRequiredImplicit,
                    )
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            _ => return MatchRouteResult::NotMatched
          }
        }
        [.. "optional-explicit/", .. path] => {
          if path.length() == 0 {
            return MatchRouteResult::NotMatched
          }
          match path {
            [.. "set", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Post =>
                    return MatchRouteResult::Matched(
                      RouteId::OptionalExplicitSet,
                    )
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            [.. "omit", .. path] => {
              if path.length() == 0 {
                match meth {
                  @http.Post =>
                    return MatchRouteResult::Matched(
                      RouteId::OptionalExplicitOmit,
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
pub fn[H0 : BodyOptionalityHandler, H1 : OptionalExplicitHandler] create_router(
  body_optionality_handler~ : H0,
  optional_explicit_handler~ : H1,
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
          RouteId::BodyOptionalityRequiredExplicit => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_1_body : BodyModel = @json.from_json(@json.parse(body_str))
            body_optionality_handler.required_explicit(group~, p_1_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::BodyOptionalityRequiredImplicit => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_2_body : BodyModel1 = @json.from_json(@json.parse(body_str))
            body_optionality_handler.required_implicit(group~, p_2_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::OptionalExplicitSet => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_3_body : BodyModel = @json.from_json(@json.parse(body_str))
            optional_explicit_handler.set(group~, p_3_body)
            conn.send_response(204, "No Content")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::OptionalExplicitOmit => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_4_body : BodyModel = @json.from_json(@json.parse(body_str))
            optional_explicit_handler.omit(group~, p_4_body)
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
