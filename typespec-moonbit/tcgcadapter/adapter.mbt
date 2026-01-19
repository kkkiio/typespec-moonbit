///|
/// TypeSpec -> CodeModel 适配器。
pub struct Adapter {
  context : @ffi.EmitContext
  options : @config.EmitterOptions
  service_name : String
}

///|
/// 构建适配器实例。
pub fn Adapter::create(context : @ffi.EmitContext) -> Adapter {
  let options = @config.EmitterOptions::from_context(context)
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
pub fn Adapter::options(self : Adapter) -> @config.EmitterOptions {
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
    let server_base_path = get_server_base_path(http, program, ns_value)
    let methods = build_methods(operations_val, server_base_path)
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
fn build_methods(
  operations_val : @ffi.JsValue,
  server_base_path : String,
) -> Array[@codemodel.Method] {
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
    let mut path = if !(uri_val.is_undefined() || uri_val.is_null()) {
      uri_val.cast()
    } else if !(path_val.is_undefined() || path_val.is_null()) {
      path_val.cast()
    } else {
      "/"
    }
    if server_base_path != "" {
      path = join_paths(server_base_path, path)
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
/// 从 `@server("{endpoint}/...")` 里提取 base path（以 `/` 开头）。
///
/// 对于 `@server("{endpoint}")` 或没有 `@server` 的情况，返回空字符串。
fn get_server_base_path(
  http_module : @ffi.JsValue,
  program : @ffi.JsValue,
  service_namespace : @ffi.JsValue,
) -> String {
  let servers_val : @ffi.JsValue = http_module.apply_with_string(
    "getServers",
    [program, service_namespace],
  )
  if servers_val.is_undefined() || servers_val.is_null() {
    return ""
  }
  let servers : Array[@ffi.JsValue] = servers_val.cast()
  if servers.length() == 0 {
    return ""
  }
  let server0 = servers[0]
  let url_val : @ffi.JsValue = server0.get_with_string("url")
  if url_val.is_undefined() || url_val.is_null() {
    return ""
  }
  let url : String = url_val.cast()
  extract_path_from_server_url(url)
}

///|
/// 从 server url（可能包含 `://` 或 `{endpoint}`）中提取 path 部分（含前导 `/`）。
fn extract_path_from_server_url(url : String) -> String {
  if url.contains("://") {
    let parts = url.split("://").to_array()
    if parts.length() < 2 {
      ""
    } else {
      let rest = parts[1].to_string()
      let rest_parts = rest.split("/").to_array()
      let path = join_segments(rest_parts, 1)
      if path == "" { "" } else { "/" + path }
    }
  } else {
    let parts = url.split("/").to_array()
    let path = join_segments(parts, 1)
    if path == "" { "" } else { "/" + path }
  }
}

///|
/// 将 `parts[start..]` 用 `/` 连接起来（跳过空段）。
fn join_segments(parts : Array[StringView], start : Int) -> String {
  if start >= parts.length() {
    return ""
  }
  let mut first = true
  let sb = StringBuilder::new(size_hint=64)
  for i in start..<parts.length() {
    let seg = parts[i].to_string()
    if seg == "" {
      continue
    }
    if first {
      first = false
    } else {
      sb.write_string("/")
    }
    sb.write_string(seg)
  }
  sb.to_string()
}

///|
/// 拼接两个路径片段，避免重复的 `/`。
fn join_paths(a : String, b : String) -> String {
  if a == "" {
    return b
  }
  if b == "" {
    return a
  }
  if b == "/" {
    return a
  }
  let left = a.trim_end(char_set="/").to_string()
  let right = b.trim(char_set="/").to_string()
  if right == "" {
    left
  } else {
    left + "/" + right
  }
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
