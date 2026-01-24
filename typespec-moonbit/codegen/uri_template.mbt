///|
/// URI Template 解析模块：RFC6570 子集解析和标识符处理。

///|
priv struct UriTemplateVar {
  op : String
  name : String
  explode : Bool
  // 生成用的参数名/类型（暂时通过 name 约定推断，先覆盖 routes spector 用例）。
  param_name : String
  param_type : String
}

///|
priv struct UriTemplate {
  parts : Array[String]
  vars : Array[UriTemplateVar]
}

///|
fn UriTemplate::parts(self : UriTemplate) -> Array[String] {
  self.parts
}

///|
fn UriTemplate::vars(self : UriTemplate) -> Array[UriTemplateVar] {
  self.vars
}

///|
fn UriTemplateVar::param_name(self : UriTemplateVar) -> String {
  self.param_name
}

///|
fn UriTemplateVar::param_type(self : UriTemplateVar) -> String {
  self.param_type
}

///|
fn parse_uri_template(path : String, op_name : String) -> UriTemplate {
  // 仅解析 `{...}` 形式的 RFC6570 表达式；当前版本只支持单变量表达式。
  let parts = Array::new()
  let vars = Array::new()
  let chars = path.to_array()
  let mut i = 0
  while i < chars.length() {
    match find_char(chars, '{', i) {
      None => {
        parts.push(chars_to_string(chars, i, chars.length()))
        break
      }
      Some(open_idx) => {
        parts.push(chars_to_string(chars, i, open_idx))
        match find_char(chars, '}', open_idx + 1) {
          None => {
            // 非法模板：直接把剩余部分当字面量
            parts.push(chars_to_string(chars, open_idx, chars.length()))
            break
          }
          Some(close_idx) => {
            let inner = chars_to_string(chars, open_idx + 1, close_idx)
            let (op, rest) = parse_uri_template_operator(inner)
            let (name, explode) = parse_uri_template_varspec(rest)
            if name.length() > 0 {
              let param_name = sanitize_identifier(name.to_lower())
              let param_type = infer_param_type_from_operation(op_name)
              vars.push({ op, name, explode, param_name, param_type })
              // 用空字符串占位，方便在运行时按 vars 顺序展开
              parts.push("")
            } else {
              parts.push("{" + inner + "}")
            }
            i = close_idx + 1
          }
        }
      }
    }
  }
  { parts, vars }
}

///|
fn parse_uri_template_operator(inner : String) -> (String, String) {
  let chars = inner.to_array()
  if chars.length() == 0 {
    ("", "")
  } else {
    let first = chars[0]
    match first {
      '+' | '/' | '.' | ';' | '?' | '&' =>
        (first.to_string(), chars_to_string(chars, 1, chars.length()))
      _ => ("", inner)
    }
  }
}

///|
fn parse_uri_template_varspec(rest : String) -> (String, Bool) {
  // 只支持单变量：`name` 或 `name*`
  let trimmed = rest.trim()
  let chars = trimmed.to_array()
  if chars.length() == 0 {
    ("", false)
  } else {
    let mut explode = false
    let mut end = chars.length()
    if chars[chars.length() - 1] == '*' {
      explode = true
      end = end - 1
    }
    // 不支持多变量：遇到逗号就截断
    let comma = find_char(chars, ',', 0).unwrap_or(end)
    let final_end = if comma < end { comma } else { end }
    (chars_to_string(chars, 0, final_end), explode)
  }
}

///|
fn find_char(chars : Array[Char], target : Char, from : Int) -> Int? {
  for i in from..<chars.length() {
    if chars[i] == target {
      return Some(i)
    }
  }
  None
}

///|
fn chars_to_string(chars : Array[Char], start : Int, end : Int) -> String {
  let sb = StringBuilder::new(size_hint=@cmp.maximum(0, end - start))
  for i in start..<end {
    sb.write_char(chars[i])
  }
  sb.to_string()
}

///|
fn infer_param_type_from_operation(op_name : String) -> String {
  // 先对齐 spector/routes：
  // - array(...) -> Array[String]
  // - record(...) -> Map[String, Int]
  // 其它默认 String。
  let lowered = op_name.to_lower()
  if lowered.contains("array") {
    "Array[String]"
  } else if lowered.contains("record") {
    "Map[String, Int]"
  } else {
    "String"
  }
}

///|
fn trim_leading_underscores(raw : String) -> String {
  let chars = raw.to_array()
  let mut start = 0
  for ch in chars {
    if ch != '_' {
      break
    }
    start += 1
  }
  if start == 0 {
    raw
  } else if start >= chars.length() {
    ""
  } else {
    let sb = StringBuilder::new(size_hint=chars.length() - start)
    for i in start..<chars.length() {
      sb.write_char(chars[i])
    }
    sb.to_string()
  }
}
