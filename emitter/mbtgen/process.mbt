///|
/// `node:child_process` 静态模块绑定。
#module("node:child_process")
extern "js" fn exec_sync_ffi(cmd : String, options : @js.Value) -> Unit = "execSync"

///|
pub fn exec_moon_fmt(path : String) -> Unit {
  let options = @js.Object::new()
  options["cwd"] = path
  exec_sync_ffi("moon fmt", options.to_value())
}
