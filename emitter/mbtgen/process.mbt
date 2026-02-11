///|
#module("node:child_process")
extern "js" fn exec_ffi(
  cmd : String,
  options : @js.Value,
  callback : @js.Value,
) -> @js.Value = "exec"

///|
#module("node:util")
extern "js" fn promisify(f : @js.Value) -> @js.Value = "promisify"

///|
let exec_promise_ffi : (String, @js.Value) -> @js.Promise = promisify(
    exec_ffi |> @js.Value::cast_from,
  )
  |> @js.Value::cast

///|
pub async fn exec_moon_fmt(path : String) -> Unit {
  let options = @js.Object::new()
  options["cwd"] = path
  exec_promise_ffi("moon fmt", options.to_value()).wait() |> ignore
}
