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
  parameters : Array[Parameter]
}
