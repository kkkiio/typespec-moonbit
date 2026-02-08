///|
type JsValue = @js.Value

///|
#module("node:fs")
extern "js" fn exists_sync(path : String) -> Bool = "existsSync"

///|
#module("node:fs")
extern "js" fn mkdir_sync(path : String, options : JsValue) -> Unit = "mkdirSync"

///|
#module("node:fs")
extern "js" fn write_file_sync(path : String, data : String) -> Unit = "writeFileSync"

///|
pub fn path_exists(path : String) -> Bool {
  exists_sync(path)
}

///|
pub fn create_dir(path : String) -> Unit {
  let options = @js.Object::new()
  options["recursive"] = true
  mkdir_sync(path, options.to_value())
}

///|
pub fn write_string_to_file(path : String, content : String) -> Unit {
  write_file_sync(path, content)
}
