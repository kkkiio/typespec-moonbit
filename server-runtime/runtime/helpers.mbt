///|
/// server emitter 生成代码所依赖的通用 helper。
///
/// 注意：这些 helper 需要被“生成的 server package”跨 package 调用，因此必须是 `pub`。

///|
pub fn strip_request_query(path : String) -> String {
  let parts = path.split("?").to_array()
  if parts.length() == 0 {
    path
  } else {
    parts[0].to_string()
  }
}

///|
pub fn match_path_template(template : String, path : String) -> Bool {
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

///|
pub fn get_path_param(
  template : String,
  path : String,
  name : String,
) -> String {
  let tlen = template.length()
  let plen = path.length()
  let mut ti = 0
  let mut pi = 0
  while ti < tlen && pi < plen {
    if template.code_unit_at(ti) == '{' {
      let mut close = ti + 1
      while close < tlen && template.code_unit_at(close) != '}' {
        close += 1
      }
      if close >= tlen {
        return ""
      }
      let key_sb = StringBuilder::new(size_hint=close - (ti + 1))
      for k in (ti + 1)..<close {
        key_sb.write_char(template.code_unit_at(k).to_int().unsafe_to_char())
      }
      let key = key_sb.to_string()
      let seg_start = pi
      while pi < plen && path.code_unit_at(pi) != '/' {
        pi += 1
      }
      if key == name {
        let seg_sb = StringBuilder::new(size_hint=pi - seg_start)
        for k in seg_start..<pi {
          seg_sb.write_char(path.code_unit_at(k).to_int().unsafe_to_char())
        }
        return seg_sb.to_string()
      }
      ti = close + 1
    } else {
      if template.code_unit_at(ti) != path.code_unit_at(pi) {
        return ""
      }
      ti += 1
      pi += 1
    }
  }
  ""
}

///|
pub fn get_header(headers : Map[String, String], name : String) -> String {
  match headers.get(name.to_lower().to_string()) {
    Some(v) => v
    None => ""
  }
}

///|
pub fn get_query_param(full_path : String, name : String) -> String {
  let parts = full_path.split("?").to_array()
  if parts.length() < 2 {
    return ""
  }
  let query = parts[1].to_string()
  for pair in query.split("&") {
    let kv = pair.split("=").to_array()
    if kv.length() >= 2 {
      if kv[0].to_string() == name {
        return kv[1].to_string()
      }
    }
  }
  ""
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
