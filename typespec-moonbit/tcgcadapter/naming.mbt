///|
/// 将字符串转为安全的 MoonBit 标识符（占位实现）。
pub fn sanitize_identifier(name : String) -> String {
  let s = name
    .replace_all(old="-", new="_")
    .replace_all(old=" ", new="_")
    .replace_all(old=":", new="_")
    .replace_all(old=".", new="_")
  if s.length() == 0 {
    "_"
  } else {
    s
  }
}

///|
/// 将包名规范化为 module 名（占位实现）。
pub fn sanitize_module_name(name : String) -> String {
  sanitize_identifier(name.to_lower())
}
