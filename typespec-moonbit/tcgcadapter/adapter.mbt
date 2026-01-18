///|
/// TypeSpec -> CodeModel 适配器。
pub struct Adapter {
  context : @ffi.EmitContext
  options : @lib.EmitterOptions
  service_name : String
}

///|
/// 构建适配器实例。
pub fn Adapter::create(context : @ffi.EmitContext) -> Adapter {
  let options = @lib.EmitterOptions::from_context(context)
  let raw_options : @ffi.JsValue = @ffi.get_value(context, "options")
  let service_name = @ffi.get_optional_string(
    raw_options,
    "service-name",
    options.module_name(),
  )
  { context, options, service_name }
}

///|
/// 获取 EmitContext。
pub fn Adapter::context(self : Adapter) -> @ffi.EmitContext {
  self.context
}

///|
/// 获取解析后的 EmitterOptions。
pub fn Adapter::options(self : Adapter) -> @lib.EmitterOptions {
  self.options
}

///|
/// 读取默认的服务名。
pub fn Adapter::service_name(self : Adapter) -> String {
  self.service_name
}

///|
/// 将 TypeSpec Program 转换为 CodeModel Crate（占位实现）。
pub async fn Adapter::tcgc_to_crate(self : Adapter) -> @codemodel.Crate {
  let program = @ffi.program(self.context())
  let http : @ffi.JsValue = @ffi.import_module("@typespec/http")
  let compiler : @ffi.JsValue = @ffi.import_module("@typespec/compiler")
  let services_pair : @ffi.JsValue = http.apply_with_string(
    "getAllHttpServices",
    [program],
  )
  let services_val : @ffi.JsValue = services_pair.get_with_index(0)
  let services : Array[@ffi.JsValue] = services_val.cast()
  let clients = Array::new()
  for service in services {
    let ns_value : @ffi.JsValue = service.get_with_string("namespace")
    let raw_name : String = compiler.apply_with_string("getNamespaceFullName", [
      ns_value,
    ])
    let name = if raw_name == "" { self.service_name() } else { raw_name }
    let operations_val = service.get_with_string("operations")
    let methods = build_methods(operations_val)
    clients.push(@codemodel.Client::new(name, methods))
  }
  let resolved_clients = if clients.length() == 0 {
    let methods = Array::new(capacity=1)
    methods.push(@codemodel.Method::new("placeholder", "/", "GET", 200))
    [@codemodel.Client::new(self.service_name(), methods)]
  } else {
    clients
  }
  @codemodel.Crate::new(
    self.options.package_name(),
    self.options.package_version(),
    resolved_clients,
  )
}

///|
fn build_methods(operations_val : @ffi.JsValue) -> Array[@codemodel.Method] {
  let methods = Array::new()
  let operations : Array[@ffi.JsValue] = operations_val.cast()
  for op in operations {
    let verb_val : @ffi.JsValue = op.get_with_string("verb")
    let verb = if verb_val.is_undefined() || verb_val.is_null() {
      "GET"
    } else {
      verb_val.cast()
    }
    // NOTE: 优先使用 uriTemplate（它包含 RFC6570 的展开语义，例如 `{+param}`、`{/param*}`），
    // 这对 spector 的 routes/path 编码测试是必须的。
    let uri_val : @ffi.JsValue = op.get_with_string("uriTemplate")
    let path_val : @ffi.JsValue = op.get_with_string("path")
    let path = if !(uri_val.is_undefined() || uri_val.is_null()) {
      uri_val.cast()
    } else if !(path_val.is_undefined() || path_val.is_null()) {
      path_val.cast()
    } else {
      "/"
    }
    let op_ref : @ffi.JsValue = op.get_with_string("operation")
    let op_name_val : @ffi.JsValue = op_ref.get_with_string("name")
    let op_name = if op_name_val.is_undefined() || op_name_val.is_null() {
      "anonymous"
    } else {
      op_name_val.cast()
    }
    let status_code = try_get_default_status_code(op).unwrap_or(200)
    methods.push(@codemodel.Method::new(op_name, path, verb, status_code))
  }
  methods
}

///|
/// 尝试从 @typespec/http 的 HttpOperation 里提取一个“默认状态码”。
///
/// 目前策略：
/// - 遍历 `responses`，找到第一个 `statusCodes` 是 number 的响应并返回；
/// - 其它情况（`*`、range/object 等）返回 `None`。
fn try_get_default_status_code(op : @ffi.JsValue) -> Int? {
  let responses_val : @ffi.JsValue = op.get_with_string("responses")
  if responses_val.is_undefined() || responses_val.is_null() {
    return None
  }
  let responses : Array[@ffi.JsValue] = responses_val.cast()
  for r in responses {
    let status_val : @ffi.JsValue = r.get_with_string("statusCodes")
    if status_val.is_undefined() || status_val.is_null() {
      continue
    }
    if status_val.is_number() {
      let code : Double = status_val.cast()
      return Some(code.to_int())
    }
  }
  None
}
