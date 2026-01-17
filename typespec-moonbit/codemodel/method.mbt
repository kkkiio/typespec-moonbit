///|
/// HTTP 操作描述。
pub struct Method {
  name : String
  path : String
  http_method : String
}

///|
/// 构建 Method。
pub fn Method::new(
  name : String,
  path : String,
  http_method : String,
) -> Method {
  { name, path, http_method }
}

///|
/// 获取操作名。
pub fn Method::name(self : Method) -> String {
  self.name
}

///|
/// 获取操作路径。
pub fn Method::path(self : Method) -> String {
  self.path
}

///|
/// 获取 HTTP 方法字符串。
pub fn Method::http_method(self : Method) -> String {
  self.http_method
}
