///|
/// JS 运行时通用值类型别名。
pub type JsValue = @js.Value

///|
/// TypeSpec 编译器传入的 EmitContext（JS 对象）。
pub type EmitContext = JsValue

///|
/// 读取 `context.program`（TypeSpec Program 对象）。
pub fn program(context : EmitContext) -> JsValue {
  context.get_with_string("program")
}

///|
/// 读取 `context.options`（Emitter 选项对象）。
pub fn options(context : EmitContext) -> JsValue {
  context.get_with_string("options")
}

///|
/// 读取 `context.emitterOutputDir`，作为输出目录。
pub fn emitter_output_dir(context : EmitContext) -> String {
  context.get_with_string("emitterOutputDir")
}
