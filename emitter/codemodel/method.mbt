///|
/// HTTP 操作参数。
pub(all) struct Parameter {
  name : String
  type_ : TypeRef
  location : String
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
  parameters : Array[Parameter]
}
