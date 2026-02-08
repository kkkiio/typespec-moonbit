///|
pub struct Context {
  emit_context : JsValue
}

///|
pub fn create_context(emit_context : JsValue) -> Context {
  Context::{ emit_context, }
}

///|
pub fn Context::program(self : Context) -> JsValue {
  get(self.emit_context, "program")
}

///|
pub fn Context::emitter_options(self : Context) -> JsValue {
  get(self.emit_context, "options")
}
