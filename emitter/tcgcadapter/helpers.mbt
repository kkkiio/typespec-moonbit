///|
/// 读取 EmitContext.program。
pub fn get_program(context : @ffi.EmitContext) -> @ffi.JsValue {
  @ffi.get_value(context, "program")
}

///|
/// 读取 EmitContext.options。
pub fn get_raw_options(context : @ffi.EmitContext) -> @ffi.JsValue {
  @ffi.get_value(context, "options")
}

///|
/// 读取 EmitContext 的 output 目录。
pub fn get_output_dir(context : @ffi.EmitContext) -> String {
  @ffi.emitter_output_dir(context)
}
