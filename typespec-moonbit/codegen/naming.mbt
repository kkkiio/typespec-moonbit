///|
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
  if res == "" {
    "_"
  } else {
    res
  }
}
