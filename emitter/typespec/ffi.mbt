///|
/// JS 运行时通用值类型别名。
pub type JsValue = @js.Value

///|
pub fn is_undefined(value : JsValue) -> Bool {
  value.is_undefined()
}

///|
pub fn is_null(value : JsValue) -> Bool {
  value.is_null()
}

///|
pub fn is_string(value : JsValue) -> Bool {
  value.is_string()
}

///|
pub fn is_number(value : JsValue) -> Bool {
  value.is_number()
}

///|
pub fn is_bool(value : JsValue) -> Bool {
  value.is_bool()
}

///|
pub fn is_array(value : JsValue) -> Bool {
  is_array_ffi(value)
}

///|
extern "js" fn is_array_ffi(value : JsValue) -> Bool =
  #| (value) => Array.isArray(value)

///|
pub fn cast_string(value : JsValue) -> String {
  value.cast()
}

///|
pub fn cast_int(value : JsValue) -> Int {
  value.cast()
}

///|
pub fn cast_bool(value : JsValue) -> Bool {
  value.cast()
}

///|
pub fn cast_float(value : JsValue) -> Double {
  value.cast()
}

///|
pub fn get(obj : JsValue, key : String) -> JsValue {
  obj.get_with_string(key)
}

///|
pub fn set(obj : JsValue, key : String, value : JsValue) -> Unit {
  obj.set_with_string(key, value)
}

///|
pub fn get_index(obj : JsValue, index : Int) -> JsValue {
  obj.get_with_index(index)
}

///|
pub fn require_module(path : String) -> JsValue {
  @js.require(path)
}

///|
pub async fn import_module(path : String) -> JsValue {
  @js.Promise::wait(import_module_ffi(path)).cast()
}

///|
extern "js" fn import_module_ffi(path : String) -> @js.Promise =
  #| (path) => import(path)
