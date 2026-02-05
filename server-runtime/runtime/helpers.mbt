///|
/// server emitter 生成代码所依赖的通用 helper。
///
/// 注意：这些 helper 需要被“生成的 server package”跨 package 调用，因此必须是 `pub`。

///|
pub fn strip_request_query(path : String) -> StringView {
  let view = path.view()
  match view.find("?"[:]) {
    None => view
    Some(i) => view.view(end_offset=i)
  }
}

///|
pub fn index_of_slash(path : StringView) -> Int {
  match path.find("/"[:]) {
    None => -1
    Some(i) => i
  }
}

///|
pub fn get_header(headers : Map[String, String], name : String) -> String {
  match headers.get(name.to_lower()) {
    Some(v) => v
    None => ""
  }
}

///|
pub fn get_query_param(full_path : String, name : String) -> String {
  let view = full_path.view()
  let name_view = name.view()
  match view.find("?"[:]) {
    None => ""
    Some(qidx) => {
      let query = view.view(start_offset=qidx + 1)
      for pair in query.split("&"[:]) {
        guard pair.find("="[:]) is Some(eq) else { continue }
        let key = pair.view(end_offset=eq)
        if key == name_view {
          return pair.view(start_offset=eq + 1).to_string()
        }
      }
      ""
    }
  }
}

///|
/// Server-Sent Events (SSE) 工具。
///
/// 提供 `text/event-stream` 响应的写入封装，方便 handler 端持续推送事件。
pub struct EventStreamWriter {
  conn : @http.ServerConnection
}

///|
fn sse_default_headers() -> Map[String, String] {
  {
    "content-type": "text/event-stream",
    "cache-control": "no-cache",
    "connection": "keep-alive",
    "x-accel-buffering": "no",
  }
}

///|
/// 启动 SSE 响应并返回写入器。
pub async fn EventStreamWriter::start(
  conn : @http.ServerConnection,
  status : Int,
  reason : String,
  extra_headers? : Map[String, String] = {},
) -> EventStreamWriter {
  let headers = sse_default_headers()
  for k, v in extra_headers {
    headers.set(k, v)
  }
  conn.send_response(status, reason, extra_headers=headers)
  EventStreamWriter::{ conn, }
}

///|
/// 发送一条 SSE event（按 SSE 行协议拼装）。
pub async fn EventStreamWriter::write_event(
  self : EventStreamWriter,
  id? : String,
  event? : String,
  data? : &@io.Data,
  flush? : Bool = true,
) -> Unit {
  if event is Some(event) {
    self.conn.write("event: \{event}\n")
  }
  if data is Some(data) {
    self.conn.write(b"data: ")
    self.conn.write(data)
    self.conn.write(b"\n")
  }
  if id is Some(id) {
    self.conn.write("id: \{id}\n")
  }
  self.conn.write(b"\n")
  if flush {
    self.conn.flush()
  }
}

///|
/// 表示一条 SSE 事件（便于业务类型转换）。
pub struct SseEvent {
  event : String?
  data : String
} derive(ToJson)

///|
pub fn SseEvent::new(event? : String, data~ : String) -> SseEvent {
  SseEvent::{ event, data }
}

///|
/// 将业务类型转换为 SSE 事件。
pub(open) trait SseToEvent {
  to_event(self : Self) -> SseEvent
}

///|
/// 将实现了 `SseToEvent` 的事件写入 SSE stream。
pub async fn[T : SseToEvent] EventStreamWriter::write(
  self : EventStreamWriter,
  event : T,
  flush? : Bool = true,
) -> Unit {
  let sse_event = event.to_event()
  self.write_event(event?=sse_event.event, data=sse_event.data, flush~)
}
