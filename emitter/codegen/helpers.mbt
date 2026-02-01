///|
/// 文本处理辅助函数（占位接口）。
pub fn indent(text : String, spaces : Int) -> String {
  let pad = String::make(spaces, ' ')
  let lines = text.split("\n").to_array()
  let sb = StringBuilder::new(size_hint=text.length() + lines.length() * spaces)
  let mut first = true
  for line in lines {
    if !first {
      sb.write_char('\n')
    }
    first = false
    if line.length() != 0 {
      sb.write_string(pad)
      sb.write_string(line.to_string())
    }
  }
  sb.to_string()
}

///|
let uri_utils_tmpl =
  #|///|
  #|/// 将 path 字符串按 WHATWG URL Standard 的 path percent-encode set 做编码（类似 Rust `url::Url::set_path`）。
  #|///
  #|/// - 保留 `/` 作为路径分隔符（不会被编码为 `%2F`）
  #|/// - 对空格等不安全字符编码为 `%XX`
  #|/// - 如果已经存在合法的 `%XX`，不会 double-encode
  #|fn __tsmb_encode_path(path : String) -> String {
  #|  let bytes = @encoding/utf8.encode(path)
  #|  let out = StringBuilder::new(size_hint=bytes.length() * 3)
  #|  let mut i = 0
  #|  while i < bytes.length() {
  #|    let b = bytes[i]
  #|    // keep %XX
  #|    if b.to_int() == 0x25 &&
  #|      i + 2 < bytes.length() &&
  #|      __tsmb_is_hex_digit(bytes[i + 1]) &&
  #|      __tsmb_is_hex_digit(bytes[i + 2]) {
  #|      out.write_char('%')
  #|      out.write_char(bytes[i + 1].to_int().unsafe_to_char())
  #|      out.write_char(bytes[i + 2].to_int().unsafe_to_char())
  #|      i += 3
  #|      continue
  #|    }
  #|    // '/' as separator
  #|    if b.to_int() == 0x2F {
  #|      out.write_char('/')
  #|      i += 1
  #|      continue
  #|    }
  #|    // for special URLs, backslash is treated as separator
  #|    if b.to_int() == 0x5C {
  #|      out.write_char('/')
  #|      i += 1
  #|      continue
  #|    }
  #|    if __tsmb_should_encode_path_byte(b) {
  #|      out.write_char('%')
  #|      out.write_string(__tsmb_hex2(b))
  #|    } else {
  #|      out.write_char(b.to_int().unsafe_to_char())
  #|    }
  #|    i += 1
  #|  }
  #|  out.to_string()
  #|}
  #|
  #|///|
  #|/// 将 request target 编码为可用于 HTTP 请求的路径字符串。
  #|///
  #|/// - 仅对 `?` 或 `#` 之前的 path 部分做 `__tsmb_encode_path` 等价处理
  #|/// - `?query` 与 `#fragment` 部分保持原样（至少保证 `?` 不会被编码为 `%3F`）
  #|fn __tsmb_encode_request_target(target : String) -> String {
  #|  let bytes = @encoding/utf8.encode(target)
  #|  let out = StringBuilder::new(size_hint=bytes.length() * 3)
  #|  let mut i = 0
  #|  while i < bytes.length() {
  #|    let b = bytes[i]
  #|    // query/fragment separator: keep as-is, and keep the tail as-is
  #|    if b.to_int() == 0x3F || b.to_int() == 0x23 {
  #|      out.write_char(b.to_int().unsafe_to_char())
  #|      i += 1
  #|      while i < bytes.length() {
  #|        let bb = bytes[i]
  #|        // keep %XX
  #|        if bb.to_int() == 0x25 &&
  #|          i + 2 < bytes.length() &&
  #|          __tsmb_is_hex_digit(bytes[i + 1]) &&
  #|          __tsmb_is_hex_digit(bytes[i + 2]) {
  #|          out.write_char('%')
  #|          out.write_char(bytes[i + 1].to_int().unsafe_to_char())
  #|          out.write_char(bytes[i + 2].to_int().unsafe_to_char())
  #|          i += 3
  #|          continue
  #|        }
  #|        // keep ASCII bytes as-is, percent-encode others
  #|        let x = bb.to_int()
  #|        if x <= 0x1F || x == 0x7F || x >= 0x80 {
  #|          out.write_char('%')
  #|          out.write_string(__tsmb_hex2(bb))
  #|        } else {
  #|          out.write_char(x.unsafe_to_char())
  #|        }
  #|        i += 1
  #|      }
  #|      break
  #|    }
  #|    // keep %XX
  #|    if b.to_int() == 0x25 &&
  #|      i + 2 < bytes.length() &&
  #|      __tsmb_is_hex_digit(bytes[i + 1]) &&
  #|      __tsmb_is_hex_digit(bytes[i + 2]) {
  #|      out.write_char('%')
  #|      out.write_char(bytes[i + 1].to_int().unsafe_to_char())
  #|      out.write_char(bytes[i + 2].to_int().unsafe_to_char())
  #|      i += 3
  #|      continue
  #|    }
  #|    // '/' as separator
  #|    if b.to_int() == 0x2F {
  #|      out.write_char('/')
  #|      i += 1
  #|      continue
  #|    }
  #|    // for special URLs, backslash is treated as separator
  #|    if b.to_int() == 0x5C {
  #|      out.write_char('/')
  #|      i += 1
  #|      continue
  #|    }
  #|    if __tsmb_should_encode_path_byte(b) {
  #|      out.write_char('%')
  #|      out.write_string(__tsmb_hex2(b))
  #|    } else {
  #|      out.write_char(b.to_int().unsafe_to_char())
  #|    }
  #|    i += 1
  #|  }
  #|  out.to_string()
  #|}
  #|
  #|///|
  #|fn __tsmb_is_hex_digit(b : Byte) -> Bool {
  #|  match b.to_int() {
  #|    0x30..=0x39 => true // 0-9
  #|    0x41..=0x46 => true // A-F
  #|    0x61..=0x66 => true // a-f
  #|    _ => false
  #|  }
  #|}
  #|
  #|///|
  #|fn __tsmb_hex2(byte : Byte) -> String {
  #|  let mut s = byte.to_int().to_string(radix=16).to_upper()
  #|  if s.length() == 1 { s = "0" + s }
  #|  s
  #|}
  #|
  #|///|
  #|fn __tsmb_should_encode_path_byte(b : Byte) -> Bool {
  #|  // WHATWG URL Standard: path percent-encode set:
  #|  // controls + space + " < > ` + # ? { }
  #|  let x = b.to_int()
  #|  match x {
  #|    0x00..=0x1F => true
  #|    0x7F => true
  #|    0x20 => true // space
  #|    0x22 => true // "
  #|    0x3C => true // <
  #|    0x3E => true // >
  #|    0x60 => true // `
  #|    0x23 => true // #
  #|    0x3F => true // ?
  #|    0x7B => true // {
  #|    0x7D => true // }
  #|    0x25 => true // %
  #|    // for simplicity: encode non-ascii bytes
  #|    0x80..=0xFF => true
  #|    _ => false
  #|  }
  #|}
  #|
  #|///|
  #|fn __tsmb_join(xs : Array[String], sep : String) -> String {
  #|  let sb = StringBuilder::new(size_hint=32)
  #|  for i in 0..<xs.length() {
  #|    if i > 0 { sb.write_string(sep) }
  #|    sb.write_string(xs[i])
  #|  }
  #|  sb.to_string()
  #|}
  #|
  #|///|
  #|fn __tsmb_expand_string(op : String, name : String, _explode : Bool, value : String) -> String {
  #|  match op {
  #|    "?" => "?" + name + "=" + value
  #|    "&" => "&" + name + "=" + value
  #|    "/" => "/" + value
  #|    "." => "." + value
  #|    ";" => ";" + name + "=" + value
  #|    _ => value
  #|  }
  #|}
  #|
  #|///|
  #|fn __tsmb_expand_array(op : String, name : String, explode : Bool, value : Array[String]) -> String {
  #|  match op {
  #|    "?" =>
  #|      if explode {
  #|        let parts = Array::new(capacity=value.length())
  #|        for x in value { parts.push(name + "=" + x) }
  #|        "?" + __tsmb_join(parts, "&")
  #|      } else {
  #|        "?" + name + "=" + __tsmb_join(value, ",")
  #|      }
  #|    "&" =>
  #|      if explode {
  #|        let parts = Array::new(capacity=value.length())
  #|        for x in value { parts.push("&" + name + "=" + x) }
  #|        __tsmb_join(parts, "")
  #|      } else {
  #|        "&" + name + "=" + __tsmb_join(value, ",")
  #|      }
  #|    "/" => "/" + __tsmb_join(value, if explode { "/" } else { "," })
  #|    "." => "." + __tsmb_join(value, if explode { "." } else { "," })
  #|    ";" =>
  #|      if explode {
  #|        let parts = Array::new(capacity=value.length())
  #|        for x in value { parts.push(";" + name + "=" + x) }
  #|        __tsmb_join(parts, "")
  #|      } else {
  #|        ";" + name + "=" + __tsmb_join(value, ",")
  #|      }
  #|    _ => __tsmb_join(value, ",")
  #|  }
  #|}
  #|
  #|///|
  #|fn __tsmb_expand_record(op : String, name : String, explode : Bool, value : Map[String, Int]) -> String {
  #|  let pairs = value.to_array()
  #|  // Keep output stable by sorting by key.
  #|  pairs.sort_by_key(p => p.0)
  #|  match op {
  #|    "?" =>
  #|      if explode {
  #|        "?" + __tsmb_expand_record_inner(pairs, true, "&")
  #|      } else {
  #|        "?" + name + "=" + __tsmb_expand_record_inner(pairs, false, ",")
  #|      }
  #|    "&" =>
  #|      if explode {
  #|        let parts = Array::new()
  #|        for kv in pairs {
  #|          let k = kv.0
  #|          let v = kv.1
  #|          parts.push("&" + k + "=" + v.to_string())
  #|        }
  #|        __tsmb_join(parts, "")
  #|      } else {
  #|        "&" + name + "=" + __tsmb_expand_record_inner(pairs, false, ",")
  #|      }
  #|    "/" => "/" + __tsmb_expand_record_inner(pairs, explode, if explode { "/" } else { "," })
  #|    "." => "." + __tsmb_expand_record_inner(pairs, explode, if explode { "." } else { "," })
  #|    ";" =>
  #|      if explode {
  #|        let parts = Array::new()
  #|        for kv in pairs {
  #|          let k = kv.0
  #|          let v = kv.1
  #|          parts.push(";" + k + "=" + v.to_string())
  #|        }
  #|        __tsmb_join(parts, "")
  #|      } else {
  #|        ";" + name + "=" + __tsmb_expand_record_inner(pairs, false, ",")
  #|      }
  #|    _ => __tsmb_expand_record_inner(pairs, explode, ",")
  #|  }
  #|}
  #|
  #|///|
  #|fn __tsmb_expand_record_inner(pairs : Array[(String, Int)], explode : Bool, sep : String) -> String {
  #|  let parts = Array::new()
  #|  if explode {
  #|    for kv in pairs {
  #|      let k = kv.0
  #|      let v = kv.1
  #|      parts.push(k + "=" + v.to_string())
  #|    }
  #|    __tsmb_join(parts, sep)
  #|  } else {
  #|    for kv in pairs {
  #|      let k = kv.0
  #|      let v = kv.1
  #|      parts.push(k)
  #|      parts.push(v.to_string())
  #|    }
  #|    __tsmb_join(parts, ",")
  #|  }
  #|}
  #|

///|
let strip_request_query_code =
  #|///|
  #|fn strip_request_query(path : String) -> String {
  #|  let parts = path.split("?").to_array()
  #|  if parts.length() == 0 { path } else { parts[0].to_string() }
  #|}
  #|

///|
let match_path_template_code =
  #|///|
  #|fn match_path_template(template : String, path : String) -> Bool {
  #|  let tlen = template.length()
  #|  let plen = path.length()
  #|  let mut ti = 0
  #|  let mut pi = 0
  #|  while ti < tlen && pi < plen {
  #|    if template.code_unit_at(ti) == '{' {
  #|      // find matching `}` in template
  #|      let mut close = ti + 1
  #|      while close < tlen && template.code_unit_at(close) != '}' {
  #|        close += 1
  #|      }
  #|      if close >= tlen {
  #|        return false
  #|      }
  #|      // match a non-empty path segment
  #|      let seg_start = pi
  #|      while pi < plen && path.code_unit_at(pi) != '/' {
  #|        pi += 1
  #|      }
  #|      if pi == seg_start {
  #|        return false
  #|      }
  #|      ti = close + 1
  #|    } else {
  #|      if template.code_unit_at(ti) != path.code_unit_at(pi) {
  #|        return false
  #|      }
  #|      ti += 1
  #|      pi += 1
  #|    }
  #|  }
  #|  ti == tlen && pi == plen
  #|}
  #|

///|
let get_path_param_code =
  #|///|
  #|fn get_path_param(template : String, path : String, name : String) -> String {
  #|  let tlen = template.length()
  #|  let plen = path.length()
  #|  let mut ti = 0
  #|  let mut pi = 0
  #|  while ti < tlen && pi < plen {
  #|    if template.code_unit_at(ti) == '{' {
  #|      let mut close = ti + 1
  #|      while close < tlen && template.code_unit_at(close) != '}' {
  #|        close += 1
  #|      }
  #|      if close >= tlen {
  #|        return ""
  #|      }
  #|      let key_sb = StringBuilder::new(size_hint=close - (ti + 1))
  #|      for k in (ti + 1)..<close {
  #|        key_sb.write_char(template.code_unit_at(k).to_int().unsafe_to_char())
  #|      }
  #|      let key = key_sb.to_string()
  #|      let seg_start = pi
  #|      while pi < plen && path.code_unit_at(pi) != '/' {
  #|        pi += 1
  #|      }
  #|      if key == name {
  #|        let seg_sb = StringBuilder::new(size_hint=pi - seg_start)
  #|        for k in seg_start..<pi {
  #|          seg_sb.write_char(path.code_unit_at(k).to_int().unsafe_to_char())
  #|        }
  #|        return seg_sb.to_string()
  #|      }
  #|      ti = close + 1
  #|    } else {
  #|      if template.code_unit_at(ti) != path.code_unit_at(pi) {
  #|        return ""
  #|      }
  #|      ti += 1
  #|      pi += 1
  #|    }
  #|  }
  #|  ""
  #|}
  #|

///|
let get_header_code =
  #|///|
  #|fn get_header(headers : Map[String, String], name : String) -> String {
  #|  match headers.get(name.to_lower().to_string()) {
  #|    Some(v) => v
  #|    None => ""
  #|  }
  #|}
  #|

///|
let get_query_param_code =
  #|///|
  #|fn get_query_param(full_path : String, name : String) -> String {
  #|  let parts = full_path.split("?").to_array()
  #|  if parts.length() < 2 { return "" }
  #|  let query = parts[1].to_string()
  #|  for pair in query.split("&") {
  #|    let kv = pair.split("=").to_array()
  #|    if kv.length() >= 2 {
  #|      if kv[0].to_string() == name { return kv[1].to_string() }
  #|    }
  #|  }
  #|  ""
  #|}
  #|

///|
let server_event_stream_code : String =
  #|///|
  #|/// Server-Sent Events (SSE) 工具。
  #|///
  #|/// 提供 `text/event-stream` 响应的写入封装，方便 handler 端持续推送事件。
  #|pub struct EventStreamWriter {
  #|  conn : @http.ServerConnection
  #|}
  #|
  #|///|
  #|fn sse_default_headers() -> Map[String, String] {
  #|  {
  #|    "content-type": "text/event-stream",
  #|    "cache-control": "no-cache",
  #|    "connection": "keep-alive",
  #|    "x-accel-buffering": "no",
  #|  }
  #|}
  #|
  #|///|
  #|/// 启动 SSE 响应并返回写入器。
  #|pub async fn EventStreamWriter::start(
  #|  conn : @http.ServerConnection,
  #|  status : Int,
  #|  reason : String,
  #|  extra_headers? : Map[String, String] = {},
  #|) -> EventStreamWriter {
  #|  let headers = sse_default_headers()
  #|  for k, v in extra_headers {
  #|    headers.set(k, v)
  #|  }
  #|  conn.send_response(status, reason, extra_headers=headers)
  #|  EventStreamWriter::{ conn }
  #|}
  #|
  #|///|
  #|/// 发送一条 SSE event（按 SSE 行协议拼装）。
  #|pub async fn EventStreamWriter::write_event(
  #|  self : EventStreamWriter,
  #|  id? : String,
  #|  event? : String,
  #|  data? : &@io.Data,
  #|  flush? : Bool = true,
  #|) -> Unit {
  #|  if event is Some(event) {
  #|    self.conn.write("event: \{event}\n")
  #|  }
  #|  if data is Some(data) {
  #|    self.conn.write(b"data: ")
  #|    self.conn.write(data)
  #|    self.conn.write(b"\n")
  #|  }
  #|  if id is Some(id) {
  #|    self.conn.write("id: \{id}\n")
  #|  }
  #|  self.conn.write(b"\n")
  #|  if flush {
  #|    self.conn.flush()
  #|  }
  #|}
  #|
  #|///|
  #|/// 表示一条 SSE 事件（便于业务类型转换）。
  #|pub struct SseEvent {
  #|  event : String?
  #|  data : String
  #|} derive(ToJson)
  #|
  #|///|
  #|pub fn SseEvent::new(event? : String, data~ : String) -> SseEvent {
  #|  SseEvent::{ event, data }
  #|}
  #|
  #|///|
  #|/// 将业务类型转换为 SSE 事件。
  #|pub(open) trait SseToEvent {
  #|  to_event(self : Self) -> SseEvent
  #|}
  #|
  #|///|
  #|/// 将实现了 `SseToEvent` 的事件写入 SSE stream。
  #|pub async fn[T : SseToEvent] EventStreamWriter::write(
  #|  self : EventStreamWriter,
  #|  event : T,
  #|  flush? : Bool = true,
  #|) -> Unit {
  #|  let sse_event = event.to_event()
  #|  self.write_event(event?=sse_event.event, data=sse_event.data, flush~)
  #|}
  #|

///|
let nullable_support_code : String =
  #|///|
  #|/// Nullable helper used for `T | null`.
  #|pub(all) struct Nullable[T](T?) derive(Show, Default, Eq, Compare)
  #|
  #|///|
  #|pub impl[T : ToJson] ToJson for Nullable[T] with to_json(self : Nullable[T]) -> Json {
  #|  match self.0 {
  #|    Some(v) => v.to_json()
  #|    None => Json::null()
  #|  }
  #|}
  #|
  #|///|
  #|pub impl[T : @json.FromJson] @json.FromJson for Nullable[T] with from_json(
  #|  j : Json,
  #|  path : @json.JsonPath,
  #|) -> Nullable[T] raise @json.JsonDecodeError {
  #|  match j {
  #|    Null => Nullable(None)
  #|    _ => Nullable(Some(@json.from_json(j, path~)))
  #|  }
  #|}
  #|
