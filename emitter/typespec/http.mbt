///|
pub enum HttpParamKind {
  Query
  Header
  Path
  Body
  Unknown(String)
}

///|
pub struct HttpService {
  raw : JsValue
  base_path_ : String
}

///|
pub struct HttpOperation {
  raw : JsValue
  base_path_ : String
}

///|
pub struct HttpParam {
  raw : JsValue
  name_hint : String
  kind_ : HttpParamKind
  explode_ : Bool
  array_encoding_ : String?
  bytes_encoding_ : String?
}

///|
pub struct HttpResponse {
  raw : JsValue
}

///|
pub fn get_all_http_services(program : JsValue) -> Array[HttpService] {
  let http = require_module("@typespec/http")
  build_http_services(http, program)
}

///|
pub async fn get_all_http_services_async(
  program : JsValue,
) -> Array[HttpService] {
  let http = import_module("@typespec/http")
  build_http_services(http, program)
}

///|
fn build_http_services(http : JsValue, program : JsValue) -> Array[HttpService] {
  let pair = http.apply_with_string("getAllHttpServices", [program])
  let services_val = get_index(pair, 0)
  if is_undefined(services_val) || is_null(services_val) {
    return []
  }
  let services : Array[JsValue] = services_val.cast()
  let out = Array::new(capacity=services.length())
  for service in services {
    let ns = get(service, "namespace")
    out.push(HttpService::{
      raw: service,
      base_path_: get_server_base_path(http, program, ns),
    })
  }
  out
}

///|
pub fn resolve_request_body(op : JsValue) -> TypeSpecType? {
  let params_obj = get(op, "parameters")
  if is_undefined(params_obj) || is_null(params_obj) {
    return None
  }
  let body_val = get(params_obj, "body")
  if is_undefined(body_val) || is_null(body_val) {
    return None
  }
  let type_val = get(body_val, "type")
  if !(is_undefined(type_val) || is_null(type_val)) {
    return Some(resolve_type(type_val))
  }
  let prop_val = get(body_val, "property")
  if is_undefined(prop_val) || is_null(prop_val) {
    return None
  }
  let prop_type = get(prop_val, "type")
  if is_undefined(prop_type) || is_null(prop_type) {
    None
  } else {
    Some(resolve_type(prop_type))
  }
}

///|
pub fn HttpService::namespace_(self : HttpService) -> String {
  let ns_val = get(self.raw, "namespace")
  let name_val = get(ns_val, "name")
  if is_string(name_val) {
    cast_string(name_val)
  } else {
    ""
  }
}

///|
pub fn HttpService::base_path(self : HttpService) -> String {
  self.base_path_
}

///|
pub fn HttpService::operations(self : HttpService) -> Iter[HttpOperation] {
  let ops_val = get(self.raw, "operations")
  if is_undefined(ops_val) || is_null(ops_val) {
    let empty : Array[HttpOperation] = []
    return empty.iter()
  }
  let ops : Array[JsValue] = ops_val.cast()
  let out = Array::new(capacity=ops.length())
  for op in ops {
    out.push(HttpOperation::{ raw: op, base_path_: self.base_path_ })
  }
  out.iter()
}

///|
pub fn HttpOperation::name(self : HttpOperation) -> String {
  let op_val = get(self.raw, "operation")
  let name_val = get(op_val, "name")
  if is_string(name_val) {
    cast_string(name_val)
  } else {
    "anonymous"
  }
}

///|
pub fn HttpOperation::container_name(self : HttpOperation) -> String {
  let container_val = get(self.raw, "container")
  if is_undefined(container_val) || is_null(container_val) {
    return ""
  }
  let name_val = get(container_val, "name")
  if is_string(name_val) {
    cast_string(name_val)
  } else {
    ""
  }
}

///|
pub fn HttpOperation::verb(self : HttpOperation) -> String {
  let verb_val = get(self.raw, "verb")
  if is_string(verb_val) {
    cast_string(verb_val)
  } else {
    "GET"
  }
}

///|
pub fn HttpOperation::path(self : HttpOperation) -> String {
  let uri_template = get(self.raw, "uriTemplate")
  let raw_path = get(self.raw, "path")
  let op_path = if is_string(uri_template) {
    cast_string(uri_template)
  } else if is_string(raw_path) {
    cast_string(raw_path)
  } else {
    "/"
  }
  join_paths(self.base_path_, op_path)
}

///|
pub fn HttpOperation::parameters(self : HttpOperation) -> Iter[HttpParam] {
  let params_obj = get(self.raw, "parameters")
  if is_undefined(params_obj) || is_null(params_obj) {
    let empty : Array[HttpParam] = []
    return empty.iter()
  }
  let out = Array::new()
  let list_val = get(params_obj, "parameters")
  if !(is_undefined(list_val) || is_null(list_val)) {
    let list : Array[JsValue] = list_val.cast()
    for p in list {
      let name_val = get(p, "name")
      let loc_val = get(p, "type")
      let param_val = get(p, "param")
      let name_hint = if is_string(name_val) {
        cast_string(name_val)
      } else {
        ""
      }
      let kind = if is_string(loc_val) {
        parse_param_kind(cast_string(loc_val))
      } else {
        Unknown("unknown")
      }
      let explode_val = get(p, "explode")
      let explode_ = if is_bool(explode_val) {
        cast_bool(explode_val)
      } else {
        false
      }
      let source = if is_undefined(param_val) || is_null(param_val) {
        p
      } else {
        param_val
      }
      out.push({
        raw: source,
        name_hint,
        kind_: kind,
        explode_,
        array_encoding_: try_get_array_encoding(source),
        bytes_encoding_: try_get_bytes_encoding(source),
      })
    }
  }
  let body_val = get(params_obj, "body")
  if !(is_undefined(body_val) || is_null(body_val)) {
    let body_prop = get(body_val, "property")
    let source = if is_undefined(body_prop) || is_null(body_prop) {
      body_val
    } else {
      body_prop
    }
    out.push({
      raw: source,
      name_hint: "body",
      kind_: Body,
      explode_: false,
      array_encoding_: None,
      bytes_encoding_: try_get_bytes_encoding(source),
    })
  }
  out.iter()
}

///|
pub fn HttpOperation::responses(self : HttpOperation) -> Iter[HttpResponse] {
  let responses_val = get(self.raw, "responses")
  if is_undefined(responses_val) || is_null(responses_val) {
    let empty : Array[HttpResponse] = []
    return empty.iter()
  }
  let responses : Array[JsValue] = responses_val.cast()
  let out = Array::new(capacity=responses.length())
  for response in responses {
    out.push(HttpResponse::{ raw: response })
  }
  out.iter()
}

///|
pub fn HttpOperation::sse_event_union(self : HttpOperation) -> Union? {
  let op_val = get(self.raw, "operation")
  if is_undefined(op_val) || is_null(op_val) {
    return None
  }
  let return_type = get(op_val, "returnType")
  if is_undefined(return_type) || is_null(return_type) {
    return None
  }
  find_sse_event_union_from_return_type(return_type)
}

///|
pub fn HttpParam::name(self : HttpParam) -> String {
  if self.name_hint != "" {
    return self.name_hint
  }
  let name_val = get(self.raw, "name")
  if is_string(name_val) {
    cast_string(name_val)
  } else {
    ""
  }
}

///|
fn find_sse_event_union_from_return_type(return_type : JsValue) -> Union? {
  let kind_val = get(return_type, "kind")
  if is_string(kind_val) && cast_string(kind_val) == "Union" {
    let options_val = get(return_type, "options")
    if is_undefined(options_val) ||
      is_null(options_val) ||
      !is_array(options_val) {
      return None
    }
    let options : Array[JsValue] = options_val.cast()
    for option in options {
      if is_sse_stream_model(option) {
        match read_union_from_stream_model(option) {
          Some(u) => return Some(u)
          None => ()
        }
      }
    }
    return None
  }
  if is_sse_stream_model(return_type) {
    return read_union_from_stream_model(return_type)
  }
  None
}

///|
fn is_sse_stream_model(type_ : JsValue) -> Bool {
  let kind_val = get(type_, "kind")
  if !(is_string(kind_val) && cast_string(kind_val) == "Model") {
    return false
  }
  let name_val = get(type_, "name")
  if is_string(name_val) && cast_string(name_val) == "SSEStream" {
    return true
  }
  let source_model = get(type_, "sourceModel")
  if is_undefined(source_model) || is_null(source_model) {
    return false
  }
  let source_name = get(source_model, "name")
  is_string(source_name) && cast_string(source_name) == "HttpStream"
}

///|
fn read_union_from_stream_model(model : JsValue) -> Union? {
  let mapper = get(model, "templateMapper")
  if is_undefined(mapper) || is_null(mapper) {
    return None
  }
  let args_val = get(mapper, "args")
  if is_undefined(args_val) || is_null(args_val) || !is_array(args_val) {
    return None
  }
  let args : Array[JsValue] = args_val.cast()
  if args.length() == 0 {
    return None
  }
  let event_union = args[0]
  let kind_val = get(event_union, "kind")
  if is_string(kind_val) && cast_string(kind_val) == "Union" {
    Some(Union::{ raw: event_union })
  } else {
    None
  }
}

///|
pub fn HttpParam::kind(self : HttpParam) -> HttpParamKind {
  self.kind_
}

///|
pub fn HttpParam::type_(self : HttpParam) -> TypeSpecType {
  let type_val = get(self.raw, "type")
  resolve_type(type_val)
}

///|
pub fn HttpParam::is_optional(self : HttpParam) -> Bool {
  let opt_val = get(self.raw, "optional")
  if is_bool(opt_val) {
    cast_bool(opt_val)
  } else {
    false
  }
}

///|
pub fn HttpParam::explode(self : HttpParam) -> Bool {
  self.explode_
}

///|
pub fn HttpParam::array_encoding(self : HttpParam) -> String? {
  self.array_encoding_
}

///|
pub fn HttpParam::bytes_encoding(self : HttpParam) -> String? {
  self.bytes_encoding_
}

///|
pub fn HttpResponse::status_codes(self : HttpResponse) -> Array[Int] {
  let status_val = get(self.raw, "statusCodes")
  if is_undefined(status_val) || is_null(status_val) {
    return []
  }
  let out = Array::new()
  if is_number(status_val) {
    out.push(cast_int(status_val))
    return out
  }
  if is_array(status_val) {
    let arr : Array[JsValue] = status_val.cast()
    for code in arr {
      if is_number(code) {
        out.push(cast_int(code))
      }
    }
  }
  out
}

///|
pub fn HttpResponse::body_type(self : HttpResponse) -> TypeSpecType? {
  let payload = try_get_response_body_payload(self.raw)
  match payload {
    Some(body) => {
      let type_val = get(body, "type")
      if is_undefined(type_val) || is_null(type_val) {
        None
      } else {
        Some(resolve_type(type_val))
      }
    }
    None => None
  }
}

///|
pub fn HttpResponse::is_sse(self : HttpResponse) -> Bool {
  let payload = try_get_response_body_payload(self.raw)
  match payload {
    Some(body) => is_sse_payload(body)
    None => false
  }
}

///|
pub fn HttpResponse::bytes_encoding(self : HttpResponse) -> String? {
  let payload = try_get_response_body_payload(self.raw)
  match payload {
    Some(body) => try_get_bytes_encoding(body)
    None => None
  }
}

///|
pub fn HttpResponse::has_json_content_type(self : HttpResponse) -> Bool {
  let payload = try_get_response_body_payload(self.raw)
  match payload {
    Some(body) => body_has_json_content_type(body)
    None => false
  }
}

///|
pub fn try_get_array_encoding(p : JsValue) -> String? {
  try_get_array_encoding_ffi(p)
}

///|
pub fn try_get_bytes_encoding(p : JsValue) -> String? {
  try_get_bytes_encoding_ffi(p)
}

///|
extern "js" fn try_get_array_encoding_ffi(p : JsValue) -> String? =
  #| (p) => {
  #|   const decs = p?.decorators;
  #|   if (!Array.isArray(decs)) return undefined;
  #|   const enc = decs.find((d) => d?.decorator?.name === "$encode");
  #|   const v = enc?.args?.[0]?.value;
  #|   const enumType = v?.value?.enum?.name ?? v?.value?.enumType?.name;
  #|   if (enumType !== "ArrayEncoding") return undefined;
  #|   const member = v?.value?.symbol?.name ?? v?.value?.name ?? v?.value?.enumMember?.name;
  #|   return typeof member === "string" ? member : undefined;
  #| }

///|
extern "js" fn try_get_bytes_encoding_ffi(p : JsValue) -> String? =
  #| (p) => {
  #|   const decs = p?.decorators;
  #|   if (!Array.isArray(decs)) return undefined;
  #|   const enc = decs.find((d) => d?.decorator?.name === "$encode");
  #|   const v = enc?.args?.[0]?.value;
  #|   const member = v?.value?.symbol?.name ?? v?.value?.name ?? v?.value?.enumMember?.name;
  #|   return typeof member === "string" ? member : undefined;
  #| }

///|
pub fn is_sse_payload(body : JsValue) -> Bool {
  let cts_val = get(body, "contentTypes")
  if is_undefined(cts_val) || is_null(cts_val) || !is_array(cts_val) {
    return false
  }
  let cts : Array[JsValue] = cts_val.cast()
  for ct in cts {
    if is_string(ct) && cast_string(ct) == "text/event-stream" {
      return true
    }
  }
  false
}

///|
fn body_has_json_content_type(body : JsValue) -> Bool {
  let cts_val = get(body, "contentTypes")
  if is_undefined(cts_val) || is_null(cts_val) || !is_array(cts_val) {
    return false
  }
  let cts : Array[JsValue] = cts_val.cast()
  for ct in cts {
    if is_string(ct) && cast_string(ct).to_lower().contains("application/json") {
      return true
    }
  }
  false
}

///|
pub fn extract_path_from_server_url(url : String) -> String {
  if url.contains("://") {
    let parts = url.split("://").to_array()
    if parts.length() < 2 {
      return ""
    }
    let rest = parts[1].to_string()
    let rest_parts = rest.split("/").to_array()
    let path = join_segments(rest_parts, 1)
    if path == "" {
      ""
    } else {
      "/" + path
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
fn parse_param_kind(kind : String) -> HttpParamKind {
  if kind == "query" {
    return Query
  }
  if kind == "header" {
    return Header
  }
  if kind == "path" {
    return Path
  }
  if kind == "body" {
    return Body
  }
  Unknown(kind)
}

///|
fn get_server_base_path(
  http_module : JsValue,
  program : JsValue,
  service_namespace : JsValue,
) -> String {
  let servers_val = http_module.apply_with_string("getServers", [
    program, service_namespace,
  ])
  if is_undefined(servers_val) || is_null(servers_val) {
    return ""
  }
  let servers : Array[JsValue] = servers_val.cast()
  if servers.length() == 0 {
    return ""
  }
  let server0 = servers[0]
  let url_val = get(server0, "url")
  if is_string(url_val) {
    extract_path_from_server_url(cast_string(url_val))
  } else {
    ""
  }
}

///|
fn join_segments(parts : Array[StringView], start : Int) -> String {
  if start >= parts.length() {
    return ""
  }
  let sb = StringBuilder::new(size_hint=64)
  let mut first = true
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
fn join_paths(a : String, b : String) -> String {
  if a == "" {
    return b
  }
  if b == "" || b == "/" {
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
fn try_get_response_body_payload(response : JsValue) -> JsValue? {
  let variants_val = get(response, "responses")
  if is_undefined(variants_val) || is_null(variants_val) {
    return None
  }
  let variants : Array[JsValue] = variants_val.cast()
  for variant in variants {
    let body_val = get(variant, "body")
    if !(is_undefined(body_val) || is_null(body_val)) {
      return Some(body_val)
    }
    let props_val = get(variant, "properties")
    if is_undefined(props_val) || is_null(props_val) {
      continue
    }
    let props : Array[JsValue] = props_val.cast()
    for prop in props {
      let kind_val = get(prop, "kind")
      if !is_string(kind_val) {
        continue
      }
      let kind = cast_string(kind_val)
      if kind != "body" && kind != "bodyProperty" {
        continue
      }
      let property_val = get(prop, "property")
      if !(is_undefined(property_val) || is_null(property_val)) {
        return Some(property_val)
      }
    }
  }
  None
}
