///|
type JsValue = @js.Value

///|
#module("node:fs")
extern "js" fn exists_sync(path : String) -> Bool = "existsSync"

///|
#module("node:fs/promises")
extern "js" fn mkdir_ffi(path : String, options : JsValue) -> @js.Promise = "mkdir"

///|
#module("node:fs/promises")
extern "js" fn write_file_ffi(path : String, data : String) -> @js.Promise = "writeFile"

///|
pub fn path_exists(path : String) -> Bool {
  exists_sync(path)
}

///|
pub async fn create_dir(path : String) -> Unit {
  let options = @js.Object::new()
  options["recursive"] = true
  mkdir_ffi(path, options.to_value()).wait() |> ignore
}

///|
pub async fn write_string_to_file(path : String, content : String) -> Unit {
  write_file_ffi(path, content).wait() |> ignore
}
