///|
/// 代码生成入口：将 CodeModel 渲染为 MoonBit 输出文件列表。

///|
/// 将 CodeModel 渲染为 MoonBit 输出文件列表。
pub fn emit(
  crate_ : @codemodel.Crate,
  options : @config.EmitterOptions,
) -> Array[OutputFile] raise {
  if options.emit_kind() == "server" {
    emit_server_files(crate_)
  } else {
    emit_client_files(crate_)
  }
}
