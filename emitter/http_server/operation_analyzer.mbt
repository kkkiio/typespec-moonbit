///|
priv struct ServerParam {
  name : String
  var_name : String
  location : String
  type_ : @typespec.TypeSpecType
}

///|
priv struct SuccessResponse {
  code : Int
  body : @typespec.TypeSpecType?
  is_sse : Bool
}

///|
priv struct SseErrorResponse {
  status_code : Int
  body : @typespec.TypeSpecType?
}

///|
priv struct ServerOperation {
  name : String
  method_name : String
  http_method : String
  path : String
  route_id_ctor : String
  status_code : Int
  response_body : @typespec.TypeSpecType?
  params : Array[ServerParam]
  is_sse : Bool
  sse_event_union : @typespec.Union?
  sse_error_responses : Array[SseErrorResponse]
}

///|
priv struct ServerService {
  name : String
  trait_name : String
  handler_var : String
  operations : Array[ServerOperation]
}

///|
fn collect_server_services(
  services : Array[@typespec.HttpService],
) -> Array[ServerService] raise {
  let out = Array::new()
  let used_service_names : Map[String, Bool] = Map::new()
  let used_trait_names : Map[String, Bool] = Map::new()
  let used_handler_vars : Map[String, Bool] = Map::new()
  fn alloc_unique(used : Map[String, Bool], base : String) -> String {
    let mut candidate = base
    let mut i = 1
    while used.contains(candidate) {
      candidate = "\{base}\{i.to_string()}"
      i += 1
    }
    used.set(candidate, true)
    candidate
  }

  for idx in 0..<services.length() {
    let service = services[idx]
    let namespace_name = service.namespace_()
    let group_names = Array::new()
    let grouped_ops : Map[String, Array[@typespec.HttpOperation]] = Map::new()
    for op in service.operations() {
      let container = op.container_name()
      let group_name = if container == "" { namespace_name } else { container }
      if !grouped_ops.contains(group_name) {
        grouped_ops.set(group_name, Array::new())
        group_names.push(group_name)
      }
      grouped_ops.get(group_name).unwrap().push(op)
    }
    for group_name in group_names {
      let raw_name = if group_name == "" {
        "Service\{idx.to_string()}"
      } else {
        group_name
      }
      let service_name = alloc_unique(
        used_service_names,
        @case.pascal_case(sanitize_identifier(raw_name)),
      )
      let trait_name = alloc_unique(used_trait_names, service_name + "Handler")
      let base_handler_var = {
        let s = compact_alpha_digit_underscore(
          sanitize_identifier(@case.snake_case(service_name)),
        )
        if s == "" || s == "_" {
          "handler"
        } else {
          s + "_handler"
        }
      }
      let handler_var = alloc_unique(used_handler_vars, base_handler_var)
      let operations = Array::new()
      for op in grouped_ops.get(group_name).unwrap() {
        operations.push(build_server_operation(service_name, op))
      }
      operations.sort_by_key(fn(op) { op.path + "#" + op.name })
      out.push({ name: service_name, trait_name, handler_var, operations })
    }
  }
  out
}

///|
fn build_server_operation(
  service_name : String,
  op : @typespec.HttpOperation,
) -> ServerOperation raise {
  let op_name = op.name()
  let method_name = @case.snake_case(sanitize_identifier(op_name))
  let route_id_ctor = service_name + @case.pascal_case(method_name)
  let params = collect_server_params(op)
  let success_responses = collect_success_responses_with_sse(op)
  let success = success_responses[0]
  let is_sse = success.is_sse
  let sse_event_union = if is_sse {
    match op.sse_event_union() {
      Some(u) => Some(u)
      None =>
        fail("sse operation \{service_name}.\{op_name} missing events union")
    }
  } else {
    None
  }
  let response_body = if is_sse { None } else { success.body }
  {
    name: op_name,
    method_name,
    http_method: op.verb(),
    path: op.path(),
    route_id_ctor,
    status_code: success.code,
    response_body,
    params,
    is_sse,
    sse_event_union,
    sse_error_responses: collect_sse_error_responses(op),
  }
}

///|
fn collect_server_params(op : @typespec.HttpOperation) -> Array[ServerParam] {
  let out = Array::new()
  for p in op.parameters() {
    let name = p.name()
    out.push({
      name,
      var_name: sanitize_identifier(@case.snake_case(name)),
      location: param_kind_to_location(p.kind()),
      type_: p.type_(),
    })
  }
  out
}

///|
fn collect_success_responses_with_sse(
  op : @typespec.HttpOperation,
) -> Array[SuccessResponse] {
  let out = Array::new()
  for r in op.responses() {
    let codes = r.status_codes()
    let body = r.body_type()
    let is_sse = r.is_sse()
    for code in codes {
      if code >= 200 && code < 400 {
        out.push({ code, body, is_sse })
      }
    }
  }
  if out.length() == 0 {
    return [
      {
        code: infer_default_status_code(op),
        body: infer_default_response_body(op),
        is_sse: false,
      },
    ]
  }
  let deduped = dedup_success_responses(out)
  for r in deduped {
    if r.is_sse {
      return [r]
    }
  }
  [deduped[0]]
}

///|
fn dedup_success_responses(
  responses : Array[SuccessResponse],
) -> Array[SuccessResponse] {
  let out = Array::new()
  let seen : Map[Int, Bool] = Map::new()
  for r in responses {
    if !seen.contains(r.code) {
      seen.set(r.code, true)
      out.push(r)
    }
  }
  out
}

///|
fn collect_sse_error_responses(
  op : @typespec.HttpOperation,
) -> Array[SseErrorResponse] {
  let out = Array::new()
  let seen : Map[Int, Bool] = Map::new()
  for r in op.responses() {
    let body = r.body_type()
    for code in r.status_codes() {
      if code < 400 || seen.contains(code) {
        continue
      }
      seen.set(code, true)
      out.push({ status_code: code, body })
    }
  }
  out
}

///|
fn infer_default_status_code(op : @typespec.HttpOperation) -> Int {
  for r in op.responses() {
    let codes = r.status_codes()
    if codes.length() > 0 {
      return codes[0]
    }
  }
  200
}

///|
fn infer_default_response_body(
  op : @typespec.HttpOperation,
) -> @typespec.TypeSpecType? {
  for r in op.responses() {
    match r.body_type() {
      Some(t) => return Some(t)
      None => ()
    }
  }
  None
}
