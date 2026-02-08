///|
/// 判断是否是 MoonBit 关键字或保留标识符。
fn is_reserved_identifier(s : String) -> Bool {
  match s {
    "and"
    | "as"
    | "assert"
    | "async"
    | "await"
    | "break"
    | "class"
    | "const"
    | "constructor"
    | "continue"
    | "def"
    | "defer"
    | "del"
    | "elif"
    | "else"
    | "except"
    | "exec"
    | "false"
    | "finally"
    | "fn"
    | "for"
    | "from"
    | "global"
    | "if"
    | "import"
    | "in"
    | "is"
    | "lambda"
    | "let"
    | "match"
    | "mut"
    | "not"
    | "or"
    | "pass"
    | "pub"
    | "raise"
    | "return"
    | "self"
    | "struct"
    | "test"
    | "trait"
    | "true"
    | "try"
    | "type"
    | "using"
    | "while"
    | "with"
    | "yield" => true
    _ => false
  }
}

///|
/// 将任意字符串规范化为合法且稳定的 MoonBit 标识符。
pub fn sanitize_identifier(s : String) -> String {
  let sb = StringBuilder::new()
  let mut first = true
  for c in s.to_array() {
    if (c >= 'a' && c <= 'z') ||
      (c >= 'A' && c <= 'Z') ||
      (c >= '0' && c <= '9') ||
      c == '_' {
      if first && c >= '0' && c <= '9' {
        sb.write_char('_')
      }
      sb.write_char(c)
      first = false
    } else {
      sb.write_char('_')
      first = false
    }
  }
  let res = sb.to_string()
  let normalized = if res == "" { "_" } else { res }
  if is_reserved_identifier(normalized) {
    normalized + "_"
  } else {
    normalized
  }
}
