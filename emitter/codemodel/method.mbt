///|
/// HTTP 操作参数。
pub(all) struct Parameter {
  name : String
  type_ : TypeRef
  location : String
  optional : Bool
  /// Query parameter explode (e.g. `colors=blue&colors=red`).
  explode : Bool
  /// Array encoding strategy for query/header arrays (when known).
  /// - `spaceDelimited` => join with `" "`
  /// - `pipeDelimited` => join with `"|"`
  /// - `commaDelimited` => join with `","` (default)
  array_encoding : String?
}

///|
/// SSE 非流式错误响应。
pub(all) struct SseErrorResponse {
  status_code : Int
  body : TypeRef?
}

///|
/// HTTP 操作描述。
pub(all) struct Method {
  name : String
  path : String
  http_method : String
  /// 默认响应状态码
  status_code : Int
  /// 默认响应体类型（如果存在）
  response_body : TypeRef?
  /// 是否为 Server-Sent Events (`text/event-stream`) 的流式响应。
  ///
  /// 当 `is_sse` 为 `true` 时，server 端代码生成会把连接交给实现方持续写入，
  /// 而不是走默认的 JSON 返回值序列化逻辑。
  is_sse : Bool
  /// SSE 事件联合类型（来自 `SSEStream<EventsUnion>` 的 `EventsUnion`）。
  ///
  /// 当 `is_sse` 为 `true` 时应为 `Some(_)`；缺失时生成阶段会直接报错。
  sse_event_union : Union?
  /// SSE operation 的非流式响应（例如 `400/404 + json body`）。
  ///
  /// 仅当 `is_sse` 为 `true` 时使用；其他场景为空。
  sse_error_responses : Array[SseErrorResponse]
  parameters : Array[Parameter]
}
