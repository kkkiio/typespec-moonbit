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
      response_body: None,
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
  let response_body = try_get_default_response_body(
    op, status_code, processed_models,
  )
  let params = extract_parameters(op, processed_models)
  {
    name: op_name,
    path,
    http_method: verb,
    status_code,
    response_body,
    parameters: params,
  }
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
  fn model_field_exists(
    fields : Array[@codemodel.ModelField],
    name : String,
  ) -> Bool {
    for f in fields {
      if f.name == name {
        return true
      }
    }
    false
  }

  let kind_val = @ffi.get_value(prop, "kind")
  if @ffi.is_string(kind_val) {
    let kind = @ffi.cast_string(kind_val)
    if kind == "Union" {
      // Support nullable unions like `T | null`.
      let variants_val = @ffi.get_value(prop, "variants")
      if !@ffi.is_undefined(variants_val) && !variants_val.is_null() {
        let variants = get_union_variants_as_array(variants_val)
        let mut saw_null = false
        let non_null_types = Array::new()
        for v in variants {
          let t = @ffi.get_value(v, "type")
          if @ffi.is_undefined(t) || t.is_null() {
            continue
          }
          let tk = @ffi.get_value(t, "kind")
          if @ffi.is_string(tk) && @ffi.cast_string(tk) == "Intrinsic" {
            let tn = @ffi.get_value(t, "name")
            if @ffi.is_string(tn) && @ffi.cast_string(tn) == "null" {
              saw_null = true
              continue
            }
          }
          non_null_types.push(t)
        }
        if saw_null && non_null_types.length() == 1 {
          return Nullable(resolve_type_ref(non_null_types[0], processed_models))
        }
      }
      return @codemodel.TypeRef::String
    }
    if kind == "Model" {
      // Array / Record types are represented as Models with an indexer.
      // Prefer mapping them to `TypeRef::Array` / `TypeRef::Record` instead of
      // generating an empty placeholder model like `Array {}` / `Record {}`.
      let indexer_val = @ffi.get_value(prop, "indexer")
      if !@ffi.is_undefined(indexer_val) && !indexer_val.is_null() {
        // Distinguish arrays and dictionaries by indexer key type.
        let mut is_array_indexer = false
        let mut is_record_indexer = false
        let key_val = @ffi.get_value(indexer_val, "key")
        if !@ffi.is_undefined(key_val) && !key_val.is_null() {
          let key_kind_val = @ffi.get_value(key_val, "kind")
          let key_name_val = @ffi.get_value(key_val, "name")
          if @ffi.is_string(key_kind_val) &&
            @ffi.cast_string(key_kind_val) == "Scalar" &&
            @ffi.is_string(key_name_val) {
            let key_name = @ffi.cast_string(key_name_val)
            if key_name == "string" {
              is_record_indexer = true
            }
            if key_name == "integer" ||
              key_name == "int32" ||
              key_name == "int16" ||
              key_name == "int8" {
              is_array_indexer = true
            }
          }
        }
        if is_array_indexer || is_record_indexer {
          // `indexer.value` is usually a ModelProperty whose `.type` is the element type.
          let value_val = @ffi.get_value(indexer_val, "value")
          if !@ffi.is_undefined(value_val) && !value_val.is_null() {
            // In some cases, `indexer.value` is already the element type (e.g. Model/Union/Intrinsic).
            let value_kind_val = @ffi.get_value(value_val, "kind")
            if @ffi.is_string(value_kind_val) {
              let elem = resolve_type_ref(value_val, processed_models)
              return if is_array_indexer { Array(elem) } else { Record(elem) }
            }
            let value_type_val = @ffi.get_value(value_val, "type")
            if !@ffi.is_undefined(value_type_val) && !value_type_val.is_null() {
              let elem = resolve_type_ref(value_type_val, processed_models)
              return if is_array_indexer { Array(elem) } else { Record(elem) }
            }
          }
          // Some representations may expose `valueType` directly.
          let value_type_val = @ffi.get_value(indexer_val, "valueType")
          if !@ffi.is_undefined(value_type_val) && !value_type_val.is_null() {
            let elem = resolve_type_ref(value_type_val, processed_models)
            return if is_array_indexer { Array(elem) } else { Record(elem) }
          }
        }
      }
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

      // Inheritance: merge base model fields first.
      let base_model_val = @ffi.get_value(prop, "baseModel")
      if !@ffi.is_undefined(base_model_val) && !base_model_val.is_null() {
        let base_ref = resolve_type_ref(base_model_val, processed_models)
        if base_ref is Model(base_model) {
          for bf in base_model.fields {
            if !model_field_exists(fields, bf.name) {
              fields.push(bf)
            }
          }
        }
      }
      let props_obj = @ffi.get_value(prop, "properties")
      if !@ffi.is_undefined(props_obj) && !props_obj.is_null() {
        let props_array = get_model_properties_as_array(props_obj)
        for p_item in props_array {
          let p_name : String = @ffi.cast_string(@ffi.get_value(p_item, "name"))
          let p_prop = @ffi.get_value(p_item, "prop")
          let optional_val = @ffi.get_value(p_prop, "optional")
          let optional = if @ffi.is_bool(optional_val) {
            @ffi.cast_bool(optional_val)
          } else {
            false
          }
          let p_type = resolve_type_ref(
            @ffi.get_value(p_prop, "type"),
            processed_models,
          )
          fields.push({ name: p_name, type_: p_type, optional })
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
    if kind == "Scalar" {
      let name_val = @ffi.get_value(prop, "name")
      let name = if @ffi.is_string(name_val) {
        @ffi.cast_string(name_val)
      } else {
        ""
      }
      if name == "string" {
        return String
      }
      if name == "boolean" {
        return Bool
      }
      if name == "int32" || name == "int16" || name == "int8" {
        return Int32
      }
      if name == "int64" {
        return Int64
      }
      if name == "float32" || name == "float64" {
        return Float64
      }
    }
    if kind == "Intrinsic" {
      let name_val = @ffi.get_value(prop, "name")
      let name = if @ffi.is_string(name_val) {
        @ffi.cast_string(name_val)
      } else {
        ""
      }
      if name == "unknown" {
        return Json
      }
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
extern "js" fn get_union_variants_as_array(
  variants : @ffi.JsValue,
) -> Array[@ffi.JsValue] =
  #| (variants) => {
  #|   const result = [];
  #|   if (!variants) return result;
  #|   // In TypeSpec compiler, union.variants is usually a Map.
  #|   if (variants.values) {
  #|     for (const v of variants.values()) {
  #|       result.push(v);
  #|     }
  #|     return result;
  #|   }
  #|   // Fallback: already an array-like.
  #|   if (Array.isArray(variants)) return variants;
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
    if @ffi.is_array(status_val) {
      let codes : Array[@ffi.JsValue] = status_val.cast()
      for c in codes {
        if @ffi.is_number(c) {
          return Some(@ffi.cast_int(c))
        }
      }
    }
  }
  None
}

///|
/// 尝试从“默认响应”（`status_code` 匹配的那个 response）里提取响应体类型。
fn try_get_default_response_body(
  op : @ffi.JsValue,
  status_code : Int,
  processed_models : Map[String, @codemodel.Model],
) -> @codemodel.TypeRef? {
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
    let mut matched = false
    if @ffi.is_number(status_val) {
      matched = @ffi.cast_int(status_val) == status_code
    } else if @ffi.is_array(status_val) {
      let codes : Array[@ffi.JsValue] = status_val.cast()
      for c in codes {
        if @ffi.is_number(c) && @ffi.cast_int(c) == status_code {
          matched = true
        }
      }
    }
    if !matched {
      continue
    }
    let variants_val = @ffi.get_value(r, "responses")
    if @ffi.is_undefined(variants_val) {
      return None
    }
    let variants : Array[@ffi.JsValue] = variants_val.cast()
    for v in variants {
      // Prefer `responses[*].body.type` when available.
      let body_val = @ffi.get_value(v, "body")
      if !@ffi.is_undefined(body_val) && !body_val.is_null() {
        let body_type_val = @ffi.get_value(body_val, "type")
        if !@ffi.is_undefined(body_type_val) && !body_type_val.is_null() {
          return Some(resolve_type_ref(body_type_val, processed_models))
        }
      }

      // Fallback: scan `responses[*].properties[*]` for body-related entries.
      let props_val = @ffi.get_value(v, "properties")
      if @ffi.is_undefined(props_val) {
        continue
      }
      let props : Array[@ffi.JsValue] = props_val.cast()
      for p in props {
        let kind_val = @ffi.get_value(p, "kind")
        if !@ffi.is_string(kind_val) {
          continue
        }
        let kind = @ffi.cast_string(kind_val)
        if kind != "body" && kind != "bodyProperty" {
          continue
        }
        let prop_val = @ffi.get_value(p, "property")
        if @ffi.is_undefined(prop_val) {
          continue
        }
        let typ_val = @ffi.get_value(prop_val, "type")
        if @ffi.is_undefined(typ_val) {
          continue
        }
        return Some(resolve_type_ref(typ_val, processed_models))
      }
    }
    return None
  }
  None
}
