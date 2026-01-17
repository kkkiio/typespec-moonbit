///|
/// CodeGenerator 占位类型。
#declaration_only
pub type CodeGenerator

///|
/// 构建 CodeGenerator（占位接口）。
#declaration_only
pub fn CodeGenerator::new(crate_ : @codemodel.Crate) -> CodeGenerator raise {
  ...
}

///|
/// 生成输出文件列表（占位接口）。
#declaration_only
pub fn CodeGenerator::emit_files(
  self : CodeGenerator,
  options : @lib.EmitterOptions,
) -> Array[OutputFile] raise {
  ...
}
