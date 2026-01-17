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
/// 通过 Node.js `require` 加载 JS 模块。
pub fn require_module(path : String) -> JsValue {
  @js.require(path)
}

///|
/// 通过动态 `import()` 加载 JS 模块（适用于 ESM）。
pub async fn import_module(path : String) -> JsValue {
  @js.Promise::wait(import_module_ffi(path)).cast()
}

///|
extern "js" fn import_module_ffi(path : String) -> @js.Promise =
  #| (path) => import(path)
