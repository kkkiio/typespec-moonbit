///|
/// Server emitter 入口：由 JS shim 以 `$onEmit` 调用（本函数名为 `on_emit`）。
pub fn on_emit(context : @ffi.EmitContext) -> @js.Promise {
  @js.Promise::unsafe_new(async fn() { on_emit_async(context) })
}

///|
/// Server emitter 入口的异步实现。
pub async fn on_emit_async(context : @ffi.EmitContext) -> Unit {
  let options = @config.EmitterOptions::from_context(context)
  let adapter = @tcgcadapter.Adapter::create(context)
  let crate_ = adapter.tcgc_to_crate()
  let files = @codegen.emit_server_files(crate_)
  let out_dir : @path.Path = @ffi.emitter_output_dir(context)
  @fs.create_dir(out_dir.to_string())
  for file in files {
    let rel_path = file.path()
    let full_path = out_dir.join(rel_path)
    let dir = full_path.dirname()
    @fs.create_dir(dir.to_string())
    if @fs.path_exists(full_path.to_string()) &&
      !should_overwrite(rel_path, options) {
      @config.report_file_already_exists(context, full_path.to_string())
    } else {
      @fs.write_string_to_file(full_path.to_string(), file.content())
    }
  }
  @ffi.exec_moon_fmt(out_dir.to_string())
}

///|
fn should_overwrite(path : String, options : @config.EmitterOptions) -> Bool {
  if path == "moon.pkg.json" {
    options.overwrite_moon_pkg()
  } else if path == "README.mbt.md" {
    options.overwrite_readme()
  } else {
    true
  }
}
