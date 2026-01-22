///|
/// CodeModel 的顶层容器，描述一个 MoonBit 包/模块。
pub(all) struct Crate {
  name : String
  version : String
  clients : Array[Client]
}
