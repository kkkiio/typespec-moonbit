///|
fn get_optional_string(
  obj : @ffi.JsValue,
  key : String,
  default : String,
) -> String {
  if @ffi.is_undefined(obj) {
    return default
  }
  let value : @ffi.JsValue = @ffi.get_value(obj, key)
  if @ffi.is_undefined(value) {
    default
  } else {
    @ffi.cast_string(value)
  }
}

///|
/// 从 TypeSpec EmitContext 构建内部 Spec（当前为最小占位实现）。
pub fn from_context(context : @ffi.EmitContext) -> @model.Spec {
  let options : @ffi.JsValue = @ffi.get_value(context, "options")
  let name = get_optional_string(options, "service-name", "Service")
  let operations = Array::new()
  let service = @model.Service::new(name, operations)
  @model.Spec::new([service])
}
