///|
/// 服务客户端模型。
pub struct Client {
  name : String
  methods : Array[Method]
}

///|
/// 构建 Client。
pub fn Client::new(name : String, methods : Array[Method]) -> Client {
  { name, methods }
}

///|
/// 获取客户端名称。
pub fn Client::name(self : Client) -> String {
  self.name
}

///|
/// 获取方法列表。
pub fn Client::methods(self : Client) -> Array[Method] {
  self.methods
}
