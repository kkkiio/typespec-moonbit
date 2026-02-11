///|
/// 渲染状态。
priv struct RenderState {
  mut indent : Int
  lines : Array[String]
}

///|
fn new_state() -> RenderState {
  { indent: 0, lines: [] }
}

///|
fn push_line(state : RenderState, line : String) -> Unit {
  state.lines.push(indent_prefix(state.indent) + line)
}

///|
fn push_raw_lines(state : RenderState, raw : String) -> Unit {
  for line in split_lines(raw) {
    push_line(state, line)
  }
}

///|
fn indent_prefix(level : Int) -> String {
  let sb = StringBuilder::new(size_hint=level * 2)
  for _ in 0..<level {
    sb.write_string("  ")
  }
  sb.to_string()
}

///|
fn split_lines(s : String) -> Array[String] {
  let chars = s.to_array()
  let lines = Array::new()
  let sb = StringBuilder::new()
  for ch in chars {
    if ch == '\n' {
      lines.push(sb.to_string())
      sb.reset()
    } else {
      sb.write_char(ch)
    }
  }
  lines.push(sb.to_string())
  lines
}

///|
fn escape_string(s : String) -> String {
  let sb = StringBuilder::new(size_hint=s.length())
  for ch in s.to_array() {
    match ch {
      '\\' => sb.write_string("\\\\")
      '"' => sb.write_string("\\\"")
      '\n' => sb.write_string("\\n")
      '\r' => sb.write_string("\\r")
      '\t' => sb.write_string("\\t")
      _ => sb.write_char(ch)
    }
  }
  sb.to_string()
}

///|
fn format_doc_line(line : String) -> String {
  if line.is_empty() {
    "///"
  } else {
    "/// \{line}"
  }
}

///|
fn render_doc(state : RenderState, doc : String?) -> Unit {
  match doc {
    Some(text) =>
      for line in split_lines(text) {
        push_line(state, format_doc_line(line))
      }
    None => ()
  }
}

///|
fn insertion_sort(xs : Array[String]) -> Array[String] {
  let arr = Array::new(capacity=xs.length())
  for x in xs {
    arr.push(x)
  }
  for i in 1..<arr.length() {
    let value = arr[i]
    let mut j = i
    while j > 0 && arr[j - 1] > value {
      arr[j] = arr[j - 1]
      j = j - 1
    }
    arr[j] = value
  }
  arr
}

///|
fn unique_sorted_imports(imports : Array[String]) -> Array[String] {
  let sorted = insertion_sort(imports)
  if sorted.length() == 0 {
    return []
  }
  let result = Array::new()
  for import_path in sorted {
    if result.length() == 0 || result[result.length() - 1] != import_path {
      result.push(import_path)
    }
  }
  result
}

///|
fn render_param(param : Param) -> String {
  let type_text = param.type_.to_string()
  match param.is_optional {
    None => "\{param.name} : \{type_text}"
    Some(is_opt) =>
      if is_opt {
        "\{param.name}? : \{type_text}"
      } else {
        "\{param.name}~ : \{type_text}"
      }
  }
}

///|
fn render_expr(expr : Expr) -> String {
  match expr {
    LitString(value) => "\"\{escape_string(value)}\""
    LitInt(value) => value.to_string()
    LitBool(value) => value.to_string()
    Ident(name) => name
    Call(func, args) => {
      let rendered_args = args.map(render_expr).join(", ")
      "\{render_expr(func)}(\{rendered_args})"
    }
    MethodCall(receiver, method_name, args) => {
      let rendered_args = args.map(render_expr).join(", ")
      "\{render_expr(receiver)}.\{method_name}(\{rendered_args})"
    }
    Raw(raw) => raw
  }
}

///|
fn render_stmt(state : RenderState, stmt : Stmt) -> Unit {
  match stmt {
    Let(name, type_, expr) =>
      match type_ {
        Some(type_value) =>
          push_line(
            state,
            "let \{name} : \{type_value.to_string()} = \{render_expr(expr)}",
          )
        None => push_line(state, "let \{name} = \{render_expr(expr)}")
      }
    Return(expr) =>
      match expr {
        Some(value) => push_line(state, "return \{render_expr(value)}")
        None => push_line(state, "return")
      }
    Expr(expr) => push_line(state, render_expr(expr))
    Assign(target, value) =>
      push_line(state, "\{render_expr(target)} = \{render_expr(value)}")
    Raw(raw) => push_raw_lines(state, raw)
  }
}

///|
fn render_derives(derives : Array[String]) -> String {
  if derives.length() == 0 {
    ""
  } else {
    let derive_values = derives.join(", ")
    " derive(\{derive_values})"
  }
}

///|
fn render_field_line(field : Field) -> String {
  let mut type_text = field.type_.to_string()
  if field.is_optional {
    type_text = "\{type_text}?"
  }
  let mut suffix = ""
  match field.json_name {
    Some(json_name) => suffix = " // rename=\"\{json_name}\""
    None => ()
  }
  "\{field.name} : \{type_text}\{suffix}"
}

///|
fn render_enum_variant_line(variant : EnumVariant) -> String {
  let mut suffix = ""
  match variant.json_name {
    Some(json_name) => suffix = " // rename=\"\{json_name}\""
    None => ()
  }
  match variant.payload {
    Some(payload) => "\{variant.name}(\{payload.to_string()})\{suffix}"
    None => "\{variant.name}\{suffix}"
  }
}

///|
fn render_function_signature(
  name : String,
  params : Array[Param],
  return_type : Type,
  is_async : Bool,
  can_raise : Bool,
  is_pub : Bool?,
) -> String {
  let visibility = match is_pub {
    Some(value) => if value { "pub " } else { "" }
    None => ""
  }
  let async_prefix = if is_async { "async " } else { "" }
  let raise_suffix = if can_raise { " raise" } else { "" }
  let rendered_params = params.map(render_param).join(", ")
  let rendered_return = return_type.to_string()
  "\{visibility}\{async_prefix}fn \{name}(\{rendered_params}) -> \{rendered_return}\{raise_suffix}"
}

///|
fn render_function_decl(state : RenderState, function : Function) -> Unit {
  render_doc(state, function.doc)
  let signature = render_function_signature(
    function.name,
    function.params,
    function.return_type,
    function.is_async,
    function.can_raise,
    Some(function.is_pub),
  )
  push_line(state, "\{signature} {")
  state.indent += 1
  for stmt in function.body {
    render_stmt(state, stmt)
  }
  state.indent -= 1
  push_line(state, "}")
}

///|
fn render_trait_method(
  state : RenderState,
  method_sig : FunctionSignature,
) -> Unit {
  render_doc(state, method_sig.doc)
  let async_prefix = if method_sig.is_async { "async " } else { "" }
  let raise_suffix = if method_sig.can_raise { " raise" } else { "" }
  let rendered_params = method_sig.params.map(render_param).join(", ")
  push_line(
    state,
    "\{async_prefix}\{method_sig.name}(\{rendered_params}) -> \{method_sig.return_type.to_string()}\{raise_suffix}",
  )
}

///|
fn render_struct(
  state : RenderState,
  name : String,
  fields : Array[Field],
  derives : Array[String],
  doc : String?,
) -> Unit {
  render_doc(state, doc)
  push_line(state, "pub(all) struct \{name} {")
  state.indent += 1
  for field in fields {
    render_doc(state, field.doc)
    push_line(state, render_field_line(field))
  }
  state.indent -= 1
  push_line(state, "}\{render_derives(derives)}")
}

///|
fn render_enum(
  state : RenderState,
  name : String,
  variants : Array[EnumVariant],
  derives : Array[String],
  doc : String?,
) -> Unit {
  render_doc(state, doc)
  push_line(state, "pub(all) enum \{name} {")
  state.indent += 1
  for variant in variants {
    render_doc(state, variant.doc)
    push_line(state, render_enum_variant_line(variant))
  }
  state.indent -= 1
  push_line(state, "}\{render_derives(derives)}")
}

///|
fn render_trait(
  state : RenderState,
  name : String,
  methods : Array[FunctionSignature],
  doc : String?,
) -> Unit {
  render_doc(state, doc)
  push_line(state, "pub(open) trait \{name} {")
  state.indent += 1
  for method_sig in methods {
    render_trait_method(state, method_sig)
  }
  state.indent -= 1
  push_line(state, "}")
}

///|
fn render_impl(
  state : RenderState,
  trait_name : String,
  for_type : Type,
  methods : Array[Function],
) -> Unit {
  for i in 0..<methods.length() {
    let impl_method = methods[i]
    let async_prefix = if impl_method.is_async { "async " } else { "" }
    let raise_suffix = if impl_method.can_raise { " raise" } else { "" }
    let rendered_params = impl_method.params.map(render_param).join(", ")
    push_line(
      state,
      "pub impl \{trait_name} for \{for_type.to_string()} with \{async_prefix}\{impl_method.name}(\{rendered_params}) -> \{impl_method.return_type.to_string()}\{raise_suffix} {",
    )
    state.indent += 1
    for stmt in impl_method.body {
      render_stmt(state, stmt)
    }
    state.indent -= 1
    push_line(state, "}")
    if i != methods.length() - 1 {
      push_line(state, "")
    }
  }
}

///|
fn render_type_alias(
  state : RenderState,
  name : String,
  type_ : Type,
  doc : String?,
) -> Unit {
  render_doc(state, doc)
  push_line(state, "pub type \{name} = \{type_.to_string()}")
}

///|
fn render_top_level(state : RenderState, top_level : TopLevel) -> Unit {
  push_line(state, "///|")
  match top_level {
    Struct(name, fields, derives, doc) =>
      render_struct(state, name, fields, derives, doc)
    Enum(name, variants, derives, doc) =>
      render_enum(state, name, variants, derives, doc)
    Function(function) => render_function_decl(state, function)
    Trait(name, methods, doc) => render_trait(state, name, methods, doc)
    Impl(trait_name, for_type, methods) =>
      render_impl(state, trait_name, for_type, methods)
    TypeAlias(name, type_, doc) => render_type_alias(state, name, type_, doc)
  }
}

///|
/// 渲染完整文件内容。
pub fn render(file : File) -> String {
  let state = new_state()
  match file.package_name {
    Some(package_name) => {
      push_line(state, "// package: \{package_name}")
      push_line(state, "")
    }
    None => ()
  }
  for import_path in unique_sorted_imports(file.imports) {
    push_line(state, "import \"\{import_path}\"")
  }
  if file.imports.length() > 0 {
    push_line(state, "")
  }
  for i in 0..<file.top_levels.length() {
    render_top_level(state, file.top_levels[i])
    if i != file.top_levels.length() - 1 {
      push_line(state, "")
    }
  }
  state.lines.join("\n")
}
