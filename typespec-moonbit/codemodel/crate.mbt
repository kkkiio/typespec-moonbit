///|
/// CodeModel 的顶层容器，描述一个 MoonBit 包/模块。
pub struct Crate {
  name : String
  version : String
  clients : Array[Client]
}

///|
/// 构建 Crate。
pub fn Crate::new(
  name : String,
  version : String,
  clients : Array[Client],
) -> Crate {
  { name, version, clients }
}

///|
/// 获取包名。
pub fn Crate::name(self : Crate) -> String {
  self.name
}

///|
/// 获取包版本。
pub fn Crate::version(self : Crate) -> String {
  self.version
}

///|
/// 获取客户端列表。
pub fn Crate::clients(self : Crate) -> Array[Client] {
  self.clients
}
