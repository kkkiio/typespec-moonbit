///|
/// TypeSpec Library 的占位类型（用于声明诊断与选项 schema）。
#declaration_only
pub type Library

///|
/// 创建并返回 TypeSpec Library 对象（当前仅保留接口声明）。
#declaration_only
pub fn create_library() -> Library raise {
  ...
}
