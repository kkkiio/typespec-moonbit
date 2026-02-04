///|
/// 文本处理辅助函数（占位接口）。
pub fn indent(text : String, spaces : Int) -> String {
  let pad = String::make(spaces, ' ')
  let lines = text.split("\n").to_array()
  let sb = StringBuilder::new(size_hint=text.length() + lines.length() * spaces)
  let mut first = true
  for line in lines {
    if !first {
      sb.write_char('\n')
    }
    first = false
    if line.length() != 0 {
      sb.write_string(pad)
      sb.write_string(line.to_string())
    }
  }
  sb.to_string()
}
// http client 代码生成相关的 helper code 已迁移到 `kkkiio/typespec-moonbit-client-runtime/runtime`。
