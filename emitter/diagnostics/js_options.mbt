///|
/// 读取可选字符串字段，未设置或类型不符时返回默认值。
pub fn get_optional_string(
  obj : JsValue,
  key : String,
  default : String,
) -> String {
  if is_undefined(obj) {
    return default
  }
  let value : JsValue = get_value(obj, key)
  if is_undefined(value) {
    default
  } else if value.is_string() {
    value.cast()
  } else {
    default
  }
}

///|
/// 读取可选布尔字段，未设置或类型不符时返回默认值。
pub fn get_optional_bool(obj : JsValue, key : String, default : Bool) -> Bool {
  if is_undefined(obj) {
    return default
  }
  let value : JsValue = get_value(obj, key)
  if is_undefined(value) {
    default
  } else if value.is_bool() {
    value.cast()
  } else {
    default
  }
}

///|
/// 读取可选原始 JS 值，未设置时返回 None。
pub fn get_optional_value(obj : JsValue, key : String) -> JsValue? {
  if is_undefined(obj) {
    return None
  }
  let value : JsValue = get_value(obj, key)
  if is_undefined(value) {
    None
  } else {
    Some(value)
  }
}
