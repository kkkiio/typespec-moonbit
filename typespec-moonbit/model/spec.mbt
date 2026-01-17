///|
/// 适配层输出的中间模型入口。
pub struct Spec {
  services : Array[Service]
}

///|
/// 构建 Spec。
pub fn Spec::new(services : Array[Service]) -> Spec {
  { services, }
}

///|
/// 获取所有服务。
pub fn Spec::services(self : Spec) -> Array[Service] {
  self.services
}

///|
/// 一个逻辑服务，包含多条操作。
pub struct Service {
  name : String
  operations : Array[Operation]
}

///|
/// 构建 Service。
pub fn Service::new(name : String, operations : Array[Operation]) -> Service {
  { name, operations }
}

///|
/// 获取服务名。
pub fn Service::name(self : Service) -> String {
  self.name
}

///|
/// 获取该服务的操作列表。
pub fn Service::operations(self : Service) -> Array[Operation] {
  self.operations
}

///|
/// HTTP 方法枚举。
pub enum HttpMethod {
  Get
  Post
  Put
  Patch
  Delete
}

///|
/// 一条 HTTP 操作描述。
pub struct Operation {
  name : String
  path : String
  method_ : HttpMethod
}

///|
/// 构建 Operation。
pub fn Operation::new(
  name : String,
  path : String,
  method_ : HttpMethod,
) -> Operation {
  { name, path, method_ }
}

///|
/// 获取操作名。
pub fn Operation::name(self : Operation) -> String {
  self.name
}

///|
/// 获取路由路径。
pub fn Operation::path(self : Operation) -> String {
  self.path
}

///|
/// 获取 HTTP 方法。
pub fn Operation::method_(self : Operation) -> HttpMethod {
  self.method_
}

///|
/// 输出文件描述（文件名 + 内容）。
pub struct File {
  name : String
  content : String
}

///|
/// 构建 File。
pub fn File::new(name : String, content : String) -> File {
  { name, content }
}

///|
/// 获取文件名。
pub fn File::name(self : File) -> String {
  self.name
}

///|
/// 获取文件内容。
pub fn File::content(self : File) -> String {
  self.content
}
