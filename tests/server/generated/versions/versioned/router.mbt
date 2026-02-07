///|

///|
/// Traits for operation handlers
pub(open) trait VersionedHandler {
  async without_api_version(self : Self, group~ : @async.TaskGroup[Unit]) -> Unit
  async with_path_api_version(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    api_version : String,
  ) -> Unit
  async with_query_api_version(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    api_version : String,
  ) -> Unit
  async with_query_old_api_version(
    self : Self,
    group~ : @async.TaskGroup[Unit],
    api_version : String,
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
  VersionedWithoutApiVersion
  VersionedWithPathApiVersion(Array[String])
  VersionedWithQueryApiVersion
  VersionedWithQueryOldApiVersion
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
    [.. "/server/versions/versioned/with", .. path] => {
      if path.length() == 0 {
        return MatchRouteResult::NotMatched
      }
      match path {
        [.. "out-api-version", .. path] => {
          if path.length() == 0 {
            match meth {
              @http.Head =>
                return MatchRouteResult::Matched(
                  RouteId::VersionedWithoutApiVersion,
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
            [.. "path-api-version/", .. path] => {
              if path.length() == 0 {
                return MatchRouteResult::NotMatched
              }
              let mut __api_version_idx = @runtime.index_of_slash(path)
              __api_version_idx = if __api_version_idx == -1 {
                path.length()
              } else {
                __api_version_idx
              }
              let api_version = path.view(end_offset=__api_version_idx)
              let path = path.view(start_offset=__api_version_idx)
              if path.length() == 0 {
                match meth {
                  @http.Head =>
                    return MatchRouteResult::Matched(
                      RouteId::VersionedWithPathApiVersion([
                        api_version.to_string(),
                      ]),
                    )
                  _ => return MatchRouteResult::MethodNotAllowed
                }
              }
              return MatchRouteResult::NotMatched
            }
            [.. "query-", .. path] => {
              if path.length() == 0 {
                return MatchRouteResult::NotMatched
              }
              match path {
                [.. "api-version", .. path] => {
                  if path.length() == 0 {
                    match meth {
                      @http.Head =>
                        return MatchRouteResult::Matched(
                          RouteId::VersionedWithQueryApiVersion,
                        )
                      _ => return MatchRouteResult::MethodNotAllowed
                    }
                  }
                  return MatchRouteResult::NotMatched
                }
                [.. "old-api-version", .. path] => {
                  if path.length() == 0 {
                    match meth {
                      @http.Head =>
                        return MatchRouteResult::Matched(
                          RouteId::VersionedWithQueryOldApiVersion,
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

///|
pub fn[H0 : VersionedHandler] create_router(
  versioned_handler~ : H0,
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
          RouteId::VersionedWithoutApiVersion => {
            ignore(body_stream)
            versioned_handler.without_api_version(group~)
            conn.send_response(200, "OK")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::VersionedWithPathApiVersion(path_params) => {
            let api_version = path_params[0]
            ignore(body_stream)
            versioned_handler.with_path_api_version(group~, api_version)
            conn.send_response(200, "OK")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::VersionedWithQueryApiVersion => {
            ignore(body_stream)
            let p_3_api_version = @runtime.get_query_param(
              full_path, "api-version",
            )
            versioned_handler.with_query_api_version(group~, p_3_api_version)
            conn.send_response(200, "OK")
            conn.end_response()
            RouteMatch::Handled
          }
          RouteId::VersionedWithQueryOldApiVersion => {
            ignore(body_stream)
            let p_4_api_version = @runtime.get_query_param(
              full_path, "api-version",
            )
            versioned_handler.with_query_old_api_version(
              group~,
              p_4_api_version,
            )
            conn.send_response(200, "OK")
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
