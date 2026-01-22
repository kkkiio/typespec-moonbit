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
pub async fn Adapter::tcgc_to_crate(self : Adapter) -> @codemodel.Crate {
  let program = @ffi.program(self.context())
  let http : @ffi.JsValue = @ffi.import_module("@typespec/http")
  @ffi.import_module("@typespec/compiler") |> ignore
  let services_pair : @ffi.JsValue = http.apply_with_string(
    "getAllHttpServices",
    [program],
  )
  let services_val : @ffi.JsValue = services_pair.get_with_index(0)
  let services : Array[@ffi.JsValue] = services_val.cast()
  let clients = Array::new()
  let processed_models = Map::new()
  for service in services {
    let service_ns = @ffi.get_value(service, "namespace")
    let server_base_path = get_server_base_path(http, program, service_ns)
    let operations_val = @ffi.get_value(service, "operations")
    let operations : Array[@ffi.JsValue] = operations_val.cast()

    // Group operations by container (Interface or Namespace)
    let groups = Map::new() // Map[String, Array[@ffi.JsValue]]
    for op in operations {
      let op_ref = @ffi.get_value(op, "operation")
      let n_val = @ffi.get_value(op_ref, "namespace")
      let i_val = @ffi.get_value(op_ref, "interface")
      let container = if !@ffi.is_undefined(i_val) && !i_val.is_null() {
        i_val
      } else {
        n_val
      }
      let mut container_name = ""
      if !@ffi.is_undefined(container) && !container.is_null() {
        let name_val = @ffi.get_value(container, "name")
        if @ffi.is_string(name_val) {
          container_name = @ffi.cast_string(name_val)
        }
      }
      if container_name == "" {
        container_name = self.service_name()
      }
      if !groups.contains(container_name) {
        groups.set(container_name, Array::new())
      }
      groups.get(container_name).unwrap().push(op)
    }
    let group_list = groups.to_array()
    group_list.sort_by_key(fn(g) { g.0 })
    for group in group_list {
      let full_name = group.0
      let parts = full_name.split(".").to_array()
      let name = if parts.length() > 0 {
        parts[parts.length() - 1].to_string()
      } else {
        full_name
      }
      let ops = group.1
      let methods = Array::new()
      for op in ops {
        methods.push(build_method(op, server_base_path, processed_models))
      }
      clients.push(@codemodel.Client::{ name, methods })
    }
  }
  let resolved_clients = if clients.length() == 0 {
    let methods = Array::new(capacity=1)
    methods.push(@codemodel.Method::{
      name: "placeholder",
      path: "/",
      http_method: "GET",
      status_code: 200,
      parameters: [],
    })
    [@codemodel.Client::{ name: self.service_name(), methods }]
  } else {
    clients
  }
  {
    name: self.options.package_name(),
    version: self.options.package_version(),
    clients: resolved_clients,
  }
}

///|
fn build_method(
  op : @ffi.JsValue,
  server_base_path : String,
  processed_models : Map[String, @codemodel.Model],
) -> @codemodel.Method {
  let verb_val : @ffi.JsValue = op.get_with_string("verb")
  let verb = if verb_val.is_undefined() || verb_val.is_null() {
    "GET"
  } else {
    verb_val.cast()
  }
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
  let params = extract_parameters(op, processed_models)
  { name: op_name, path, http_method: verb, status_code, parameters: params }
}

///|

///|
fn extract_parameters(
  op : @ffi.JsValue,
  processed_models : Map[String, @codemodel.Model],
) -> Array[@codemodel.Parameter] {
  let params = Array::new()
  let params_obj = @ffi.get_value(op, "parameters")
  if @ffi.is_undefined(params_obj) {
    return params
  }

  // Extract explicit parameters
  let list_val = @ffi.get_value(params_obj, "parameters")
  if !@ffi.is_undefined(list_val) {
    let list : Array[@ffi.JsValue] = list_val.cast()
    for p in list {
      let name_val = @ffi.get_value(p, "name")
      let type_val = @ffi.get_value(p, "type")
      let loc = if @ffi.is_string(type_val) {
        @ffi.cast_string(type_val)
      } else {
        "query"
      }
      let name = if @ffi.is_string(name_val) {
        @ffi.cast_string(name_val)
      } else {
        "_"
      }
      let param_val = @ffi.get_value(p, "param")
      let type_ref = resolve_type_ref(param_val, processed_models)
      params.push({ name, type_: type_ref, location: loc })
    }
  }

  // Extract body
  let body_val = @ffi.get_value(params_obj, "body")
  if !@ffi.is_undefined(body_val) {
    let body_type_val = @ffi.get_value(body_val, "type")
    let type_ref = resolve_type_ref(body_type_val, processed_models)
    params.push({ name: "body", type_: type_ref, location: "body" })
  }
  params
}

// Simple counter for anonymous models

///|
let anon_model_counter : Ref[Int] = { val: 0 }

///|
fn resolve_type_ref(
  prop : @ffi.JsValue,
  processed_models : Map[String, @codemodel.Model],
) -> @codemodel.TypeRef {
  let kind_val = @ffi.get_value(prop, "kind")
  if @ffi.is_string(kind_val) {
    let kind = @ffi.cast_string(kind_val)
    if kind == "Model" {
      let name_val = @ffi.get_value(prop, "name")
      let mut name = if @ffi.is_string(name_val) {
        @ffi.cast_string(name_val)
      } else {
        ""
      }
      if name == "" {
        anon_model_counter.val = anon_model_counter.val + 1
        name = "AnonymousModel\{anon_model_counter.val}"
      }
      if processed_models.contains(name) {
        return Model(processed_models.get(name).unwrap())
      }
      let fields = Array::new()
      let model = @codemodel.Model::{ name, fields }
      processed_models.set(name, model)
      let props_obj = @ffi.get_value(prop, "properties")
      if !@ffi.is_undefined(props_obj) && !props_obj.is_null() {
        let props_array = get_model_properties_as_array(props_obj)
        for p_item in props_array {
          let p_name : String = @ffi.cast_string(@ffi.get_value(p_item, "name"))
          let p_prop = @ffi.get_value(p_item, "prop")
          let p_type = resolve_type_ref(
            @ffi.get_value(p_prop, "type"),
            processed_models,
          )
          fields.push({ name: p_name, type_: p_type })
        }
      }
      return Model(model)
    }
    if kind == "String" {
      return String
    }
    if kind == "Number" {
      return Int32
    }
    if kind == "Boolean" {
      return Bool
    }
  }
  let type_sub = @ffi.get_value(prop, "type")
  if !@ffi.is_undefined(type_sub) {
    return resolve_type_ref(type_sub, processed_models)
  }
  @codemodel.TypeRef::String
}

///|
extern "js" fn get_model_properties_as_array(
  props : @ffi.JsValue,
) -> Array[@ffi.JsValue] =
  #| (props) => {
  #|   const result = [];
  #|   if (props.entries) {
  #|     for (const [name, prop] of props.entries()) {
  #|       result.push({ name, prop });
  #|     }
  #|   } else {
  #|     for (const name in props) {
  #|       result.push({ name, prop: props[name] });
  #|     }
  #|   }
  #|   return result;
  #| }

///|
/// 从 `@server("{endpoint}/...")` 里提取 base path（以 `/` 开头）。
///
/// 对于 `@server("{endpoint}")` 或没有 `@server` 的情况，返回空字符串。
fn get_server_base_path(
  http_module : @ffi.JsValue,
  program : @ffi.JsValue,
  service_namespace : @ffi.JsValue,
) -> String {
  let servers_val : @ffi.JsValue = http_module.apply_with_string("getServers", [
    program, service_namespace,
  ])
  if @ffi.is_undefined(servers_val) {
    return ""
  }
  let servers : Array[@ffi.JsValue] = servers_val.cast()
  if servers.length() == 0 {
    return ""
  }
  let server0 = servers[0]
  let url_val = @ffi.get_value(server0, "url")
  if @ffi.is_undefined(url_val) {
    return ""
  }
  let url : String = @ffi.cast_string(url_val)
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
      if path == "" {
        ""
      } else {
        "/" + path
      }
    }
  } else {
    let parts = url.split("/").to_array()
    let path = join_segments(parts, 1)
    if path == "" {
      ""
    } else {
      "/" + path
    }
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
  let responses_val = @ffi.get_value(op, "responses")
  if @ffi.is_undefined(responses_val) {
    return None
  }
  let responses : Array[@ffi.JsValue] = responses_val.cast()
  for r in responses {
    let status_val = @ffi.get_value(r, "statusCodes")
    if @ffi.is_undefined(status_val) {
      continue
    }
    if @ffi.is_number(status_val) {
      let code = @ffi.cast_int(status_val)
      return Some(code)
    }
  }
  None
}
