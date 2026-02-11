///|

///|
/// Traits for operation handlers
pub(open) trait NotDiscriminatedHandler {
  async get_valid(self : Self, group~ : @async.TaskGroup[Unit]) -> Siamese
  async put_valid(self : Self, group~ : @async.TaskGroup[Unit], body : Siamese) -> Siamese
  async post_valid(self : Self, group~ : @async.TaskGroup[Unit], body : Siamese) -> Unit
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
  NotDiscriminatedGetValid
  NotDiscriminatedPutValid
  NotDiscriminatedPostValid
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
    [.. "/type/model/inheritance/not-discriminated/valid", .. path] => {
      if path.length() == 0 {
        match meth {
          @http.Get =>
            return MatchRouteResult::Matched(RouteId::NotDiscriminatedGetValid)
          @http.Put =>
            return MatchRouteResult::Matched(RouteId::NotDiscriminatedPutValid)
          @http.Post =>
            return MatchRouteResult::Matched(RouteId::NotDiscriminatedPostValid)
          _ => return MatchRouteResult::MethodNotAllowed
        }
      }
      return MatchRouteResult::NotMatched
    }
    _ => return MatchRouteResult::NotMatched
  }
}

///|
pub fn[H0 : NotDiscriminatedHandler] create_router(
  not_discriminated_handler~ : H0,
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
          RouteId::NotDiscriminatedGetValid => {
            ignore(body_stream)

            let resp_body = not_discriminated_handler.get_valid(group~)
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::NotDiscriminatedPutValid => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_2_body : Siamese = @json.from_json(@json.parse(body_str))
            let resp_body = not_discriminated_handler.put_valid(
              group~,
              p_2_body,
            )
            let headers : Map[String, String] = {
              "content-type": "application/json",
            }
            conn.send_response(200, "OK", extra_headers=headers)
            conn.write(resp_body.to_json().stringify())
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::NotDiscriminatedPostValid => {
            let body_bytes = body_stream.read_all()
            let body_str = body_bytes.text()
            let p_3_body : Siamese = @json.from_json(@json.parse(body_str))
            not_discriminated_handler.post_valid(group~, p_3_body)
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
