///|
/// 将 CodeModel 渲染为 MoonBit 输出文件列表。
pub fn emit(
  crate_ : @codemodel.Crate,
  options : @lib.EmitterOptions,
) -> Array[OutputFile] {
  let files = Array::new(capacity=3)
  files.push(
    OutputFile::new("moon.pkg.json", emit_moon_pkg_json(crate_, options)),
  )
  files.push(OutputFile::new("README.mbt.md", emit_readme(crate_)))
  files.push(OutputFile::new("generated.mbt", emit_source(crate_)))
  files
}

///|
fn emit_moon_pkg_json(
  crate_ : @codemodel.Crate,
  _options : @lib.EmitterOptions,
) -> String {
  let _ = crate_
  let content =
    #|{
    #|  "import": [
    #|    { "path": "moonbitlang/async/http", "alias": "http" }
    #|  ]
    #|}
  content
}

///|
fn emit_readme(crate_ : @codemodel.Crate) -> String {
  let buf = StringBuilder::new(size_hint=64)
  buf.write_string("# ")
  buf.write_string(crate_.name())
  buf.write_string("\n\n")
  buf.write_string("由 TypeSpec 生成的 MoonBit 代码。\n")
  buf.to_string()
}

///|
fn emit_source(crate_ : @codemodel.Crate) -> String {
  let buf = StringBuilder::new(size_hint=256)
  buf.write_string(uri_utils_tmpl)
  let clients = crate_.clients()
  if clients.length() == 0 {
    buf.write_string("// No clients found in CodeModel.\n")
  } else {
    for client in clients {
      emit_client(buf, client)
    }
  }
  buf.to_string()
}

///|
fn emit_client(buf : StringBuilder, client : @codemodel.Client) -> Unit {
  let type_name = make_client_type_name(client.name())
  buf.write_string("///|\n")
  buf.write_string("/// ")
  buf.write_string(type_name)
  buf.write_string(" HTTP 客户端。\n")
  buf.write_string("pub struct ")
  buf.write_string(type_name)
  buf.write_string(" {\n")
  buf.write_string("  base_url : String\n")
  buf.write_string("}\n\n")
  buf.write_string("///|\n")
  buf.write_string("/// 创建 ")
  buf.write_string(type_name)
  buf.write_string("。\n")
  buf.write_string("pub fn ")
  buf.write_string(type_name)
  buf.write_string("::new(base_url : String) -> ")
  buf.write_string(type_name)
  buf.write_string(" {\n")
  buf.write_string("  { base_url, }\n")
  buf.write_string("}\n")
  for op in client.methods() {
    emit_method(buf, type_name, op)
  }
  buf.write_string("\n")
}

///|
fn emit_method(
  buf : StringBuilder,
  type_name : String,
  op : @codemodel.Method,
) -> Unit {
  let fn_name = make_method_name(op.http_method(), op.path(), op.name())
  let path = op.path()
  let template = parse_uri_template(path, op.name())
  buf.write_string("///|\n")
  buf.write_string("/// 调用 ")
  buf.write_string(op.http_method())
  buf.write_string(" ")
  buf.write_string(path)
  buf.write_string("。\n")
  buf.write_string("pub async fn ")
  buf.write_string(type_name)
  buf.write_string("::")
  buf.write_string(fn_name)
  buf.write_string("(self : ")
  buf.write_string(type_name)
  if template.vars().length() > 0 {
    // 目前只生成 string/array/record 三类参数（先对齐 spector/routes 的需求）。
    for v in template.vars() {
      buf.write_string(", ")
      buf.write_string(v.param_name())
      buf.write_string(" : ")
      buf.write_string(v.param_type())
    }
  }
  buf.write_string(") -> @http.Response raise {\n")
  buf.write_string("  let client = @http.Client::new(self.base_url)\n")
  buf.write_string("  defer client.close()\n")
  if template.vars().length() > 0 {
    buf.write_string("  let sb = StringBuilder::new(size_hint=")
    buf.write_string((path.length() + 32).to_string())
    buf.write_string(")\n")
    let mut vi = 0
    for part in template.parts() {
      if part != "" {
        buf.write_string("  sb.write_string(\"")
        buf.write_string(
          part
          .replace_all(old="\\", new="\\\\")
          .replace_all(old="\"", new="\\\""),
        )
        buf.write_string("\")\n")
      } else {
        let v = template.vars()[vi]
        vi += 1
        buf.write_string("  sb.write_string(")
        match v.param_type() {
          "String" => buf.write_string("__tsmb_expand_string(")
          "Array[String]" => buf.write_string("__tsmb_expand_array(")
          "Map[String, Int]" => buf.write_string("__tsmb_expand_record(")
          _ => buf.write_string("__tsmb_expand_string(")
        }
        buf.write_string("\"")
        buf.write_string(v.op)
        buf.write_string("\", \"")
        buf.write_string(v.name)
        buf.write_string("\", ")
        buf.write_string(if v.explode { "true" } else { "false" })
        buf.write_string(", ")
        buf.write_string(v.param_name())
        buf.write_string("))\n")
      }
    }
    buf.write_string("  let path = sb.to_string()\n")
    buf.write_string("  let path = __tsmb_encode_request_target(path)\n")
  }
  buf.write_string("  client.")
  buf.write_string(op.http_method().to_lower())
  if template.vars().length() == 0 {
    buf.write_string("(\"")
    buf.write_string(path)
    buf.write_string("\")\n")
  } else {
    buf.write_string("(path)\n")
  }
  buf.write_string("}\n")
}

///|
fn make_client_type_name(raw : String) -> String {
  let cleaned = sanitize_identifier(raw)
  let base = if cleaned.length() == 0 { "CLIENT" } else { cleaned.to_upper() }
  if base.has_suffix("CLIENT") {
    base
  } else {
    base + "CLIENT"
  }
}

///|
fn make_method_name(
  http_method : String,
  path : String,
  raw_name : String,
) -> String {
  let prefix = sanitize_identifier(http_method.to_lower())
  let path_part = trim_leading_underscores(sanitize_identifier(path.to_lower()))
  let name_part = sanitize_identifier(raw_name.to_lower())
  let base = if path_part.length() > 0 {
    path_part
  } else if name_part.length() > 0 {
    name_part
  } else {
    "call"
  }
  prefix + "_" + base
}

///|
fn sanitize_identifier(raw : String) -> String {
  let out = raw
    .replace_all(old="-", new="_")
    .replace_all(old=" ", new="_")
    .replace_all(old=":", new="_")
    .replace_all(old=";", new="_")
    .replace_all(old=".", new="_")
    .replace_all(old="/", new="_")
    .replace_all(old="{", new="_")
    .replace_all(old="}", new="_")
    .replace_all(old="+", new="_")
    .replace_all(old="*", new="_")
    .replace_all(old="?", new="_")
    .replace_all(old="=", new="_")
    .replace_all(old="&", new="_")
    .replace_all(old=",", new="_")
  if out.length() == 0 {
    "_"
  } else {
    out
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

///|
struct UriTemplateVar {
  raw : String
  op : String
  name : String
  explode : Bool
  // 生成用的参数名/类型（暂时通过 name 约定推断，先覆盖 routes spector 用例）。
  param_name : String
  param_type : String
}

///|
struct UriTemplate {
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
              vars.push({
                raw: inner,
                op,
                name,
                explode,
                param_name,
                param_type,
              })
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
