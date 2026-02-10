///|

///|
/// SSE stream for TaskEvents
pub(all) struct TaskEventsStream {
  queue : @async.Queue[TaskEvents]
}

///|
pub fn TaskEventsStream::new() -> TaskEventsStream {
  TaskEventsStream::{ queue: @async.Queue::new(kind=Blocking(0)) }
}

///|
pub async fn TaskEventsStream::write_event(
  self : TaskEventsStream,
  event : TaskEvents,
) -> Unit {
  self.queue.put(event)
}

///|
pub fn TaskEventsStream::close(self : TaskEventsStream) -> Unit {
  self.queue.close()
}

///|
async fn TaskEventsStream::next(self : TaskEventsStream) -> TaskEvents? {
  Some(self.queue.get()) catch {
    @aqueue.QueueAlreadyClosed => None
    err => raise err
  }
}

///|
pub(all) enum DottedNameWatchTasksResult {
  Stream(TaskEventsStream)
  Status400(Model0)
}

///|

///|
/// Traits for operation handlers
pub(open) trait DottedNameHandler {
  async watch_tasks(self : Self, group~ : @async.TaskGroup[Unit], mode : String) -> DottedNameWatchTasksResult
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
  DottedNameWatchTasks
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
    [.. "/server/events/dotted-name/tasks", .. path] => {
      if path.length() == 0 {
        match meth {
          @http.Get =>
            return MatchRouteResult::Matched(RouteId::DottedNameWatchTasks)
          _ => return MatchRouteResult::MethodNotAllowed
        }
      }
      return MatchRouteResult::NotMatched
    }
    _ => return MatchRouteResult::NotMatched
  }
}

///|
pub fn[H0 : DottedNameHandler] create_router(
  dotted_name_handler~ : H0,
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
          RouteId::DottedNameWatchTasks => {
            ignore(body_stream)

            let p_1_mode = @runtime.get_query_param(full_path, "mode")
            let sse_result = dotted_name_handler.watch_tasks(group~, p_1_mode)
            match sse_result {
              DottedNameWatchTasksResult::Stream(stream) => {
                let sse = @runtime.EventStreamWriter::start(conn, 200, "OK")
                for {
                  match stream.next() {
                    Some(event) =>
                      match event {
                        MariaQueuedMessagesSynchronized(payload) =>
                          sse.write_event(
                            event?=Some("maria.queued_messages.synchronized"),
                            data=payload.to_json().stringify(),
                          )
                        Maria(payload) =>
                          sse.write_event(
                            event?=Some("maria"),
                            data=payload.to_json().stringify(),
                          )
                      }
                    None => break
                  }
                }
                sse.close()
              }
              DottedNameWatchTasksResult::Status400(resp_body) => {
                let headers : Map[String, String] = {
                  "content-type": "application/json",
                }
                conn.send_response(400, "Bad Request", extra_headers=headers)
                conn.write(resp_body.to_json().stringify())
                conn.end_response()
              }
            }
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
