///|
/// 从 JS 对象按键读取属性，返回原始 JS 值。
pub fn get_value(obj : JsValue, key : String) -> JsValue {
  obj.get_with_string(key)
}

///|
/// 判断 JS 值是否为 undefined。
pub fn is_undefined(value : JsValue) -> Bool {
  value.is_undefined()
}

///|
/// 将 JS 值强制转换为 String（调用方需确保类型正确）。
pub fn cast_string(value : JsValue) -> String {
  value.cast()
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
/// 判断 JS 值是否为 Array。
pub fn is_array(value : JsValue) -> Bool {
  is_array_ffi(value)
}

///|
extern "js" fn is_array_ffi(value : JsValue) -> Bool =
  #| (value) => Array.isArray(value)

///|
pub fn cast_int(value : JsValue) -> Int {
  value.cast()
}

///|
pub fn cast_bool(value : JsValue) -> Bool {
  value.cast()
}
