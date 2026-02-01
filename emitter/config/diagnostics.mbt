///|
/// 诊断严重级别。
#warnings("-unused_constructor")
pub enum DiagnosticSeverity {
  Error
  Warning
}

///|
/// 将诊断严重级别转换为 TypeSpec 所需字符串。
pub fn DiagnosticSeverity::to_string(self : DiagnosticSeverity) -> String {
  match self {
    Error => "error"
    Warning => "warning"
  }
}

///|
/// 诊断码枚举（与 typespec-rust 对齐）。
#warnings("-unused_constructor")
pub enum DiagnosticCode {
  InternalError
  InvalidArgument
  NameCollision
  UnsupportedTsp
  FileAlreadyExists
  EmitFailed
  FormatSkipped
}

///|
/// 将诊断码转换为字符串。
pub fn DiagnosticCode::to_string(self : DiagnosticCode) -> String {
  match self {
    InternalError => "InternalError"
    InvalidArgument => "InvalidArgument"
    NameCollision => "NameCollision"
    UnsupportedTsp => "UnsupportedTsp"
    FileAlreadyExists => "FileAlreadyExists"
    EmitFailed => "EmitFailed"
    FormatSkipped => "FormatSkipped"
  }
}

///|
/// 诊断对象。
pub struct Diagnostic {
  code : DiagnosticCode
  severity : DiagnosticSeverity
  message : String
  target : @ffi.JsValue?
}

///|
/// 构建诊断对象（不指定 target）。
pub fn Diagnostic::new(
  code : DiagnosticCode,
  severity : DiagnosticSeverity,
  message : String,
) -> Diagnostic {
  { code, severity, message, target: None }
}

///|
/// 构建带 target 的诊断对象。
pub fn Diagnostic::with_target(
  code : DiagnosticCode,
  severity : DiagnosticSeverity,
  message : String,
  target : @ffi.JsValue,
) -> Diagnostic {
  { code, severity, message, target: Some(target) }
}

///|
/// 获取诊断码。
pub fn Diagnostic::code(self : Diagnostic) -> DiagnosticCode {
  self.code
}

///|
/// 获取诊断严重级别。
pub fn Diagnostic::severity(self : Diagnostic) -> DiagnosticSeverity {
  self.severity
}

///|
/// 获取诊断文本。
pub fn Diagnostic::message(self : Diagnostic) -> String {
  self.message
}

///|
/// 获取诊断 target。
pub fn Diagnostic::target(self : Diagnostic) -> @ffi.JsValue? {
  self.target
}

///|
/// 通过 TypeSpec Program 上报诊断。
pub fn report(context : @ffi.EmitContext, diagnostic : Diagnostic) -> Unit {
  let program : @ffi.JsValue = @ffi.get_value(context, "program")
  let payload = @js.Object::new()
  payload["code"] = diagnostic.code().to_string()
  payload["severity"] = diagnostic.severity().to_string()
  payload["message"] = diagnostic.message()
  match diagnostic.target() {
    Some(target) => payload["target"] = target
    None => ()
  }
  program.apply_with_string("reportDiagnostic", [payload.to_value()])
}

///|
/// 直接上报诊断消息。
pub fn report_message(
  context : @ffi.EmitContext,
  code : DiagnosticCode,
  severity : DiagnosticSeverity,
  message : String,
) -> Unit {
  let diagnostic = Diagnostic::new(code, severity, message)
  report(context, diagnostic)
}

///|
/// 上报文件已存在的警告（不覆盖）。
pub fn report_file_already_exists(
  context : @ffi.EmitContext,
  path : String,
) -> Unit {
  report_message(
    context,
    DiagnosticCode::FileAlreadyExists,
    DiagnosticSeverity::Warning,
    "skip overwriting file \{path}",
  )
}
