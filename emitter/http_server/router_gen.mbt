///|
fn emit_router_file(
  services : Array[ServerService],
  type_ctx : EncodeTypeContext,
) -> String raise {
  let top_levels = Array::new()
  let sse_unions = collect_sse_unions(services, type_ctx)
  let sse_union_entries = sse_unions.to_array()
  sse_union_entries.sort_by_key(fn(entry) { entry.0 })
  for entry in sse_union_entries {
    let union_name = entry.0
    top_levels.push(emit_sse_event_stream_struct(union_name))
    top_levels.push(emit_sse_stream_new(union_name))
    top_levels.push(emit_sse_stream_write_event(union_name))
    top_levels.push(emit_sse_stream_close(union_name))
    top_levels.push(emit_sse_stream_next(union_name))
  }
  for service in services {
    for op in service.operations {
      if op.is_sse {
        top_levels.push(emit_sse_result_enum(service, op, type_ctx))
      }
    }
  }
  for service in services {
    top_levels.push(emit_handler_trait(service, type_ctx))
  }
  top_levels.push(emit_route_match_enum())
  top_levels.push(emit_router_type_alias())
  top_levels.push(emit_route_id_enum(services))
  top_levels.push(emit_match_route_result_enum())
  top_levels.push(emit_match_route_fn(services))
  top_levels.push(emit_create_router_fn(services, type_ctx))
  top_levels.push(emit_create_dispatch_fn())
  @mbtgen.render({ package_name: None, imports: [], top_levels })
}

///|
fn collect_sse_unions(
  services : Array[ServerService],
  type_ctx : EncodeTypeContext,
) -> Map[String, @typespec.Union] raise {
  let out : Map[String, @typespec.Union] = Map::new()
  for service in services {
    for op in service.operations {
      if !op.is_sse {
        continue
      }
      match op.sse_event_union {
        Some(union) => {
          let union_name = union_to_type_string_with_ctx(type_ctx, union)
          if !out.contains(union_name) {
            out.set(union_name, union)
          }
        }
        None =>
          fail("sse operation \{service.name}.\{op.name} missing events union")
      }
    }
  }
  out
}

///|
fn sse_stream_name(union_name : String) -> String {
  "\{union_name}Stream"
}

///|
fn sse_result_name(service : ServerService, op : ServerOperation) -> String {
  "\{service.name}\{@case.pascal_case(sanitize_identifier(op.name))}Result"
}

///|
fn emit_sse_event_stream_struct(union_name : String) -> @mbtgen.TopLevel {
  let fields : Array[@mbtgen.Field] = [
    {
      name: "queue",
      type_: @mbtgen.Type::Named("@async.Queue[\{union_name}]"),
      is_optional: false,
      doc: None,
      json_name: None,
    },
  ]
  @mbtgen.TopLevel::Struct(
    sse_stream_name(union_name),
    fields,
    [],
    Some("SSE stream for \{union_name}"),
  )
}

///|
fn emit_sse_stream_new(union_name : String) -> @mbtgen.TopLevel {
  let stream_name = sse_stream_name(union_name)
  @mbtgen.TopLevel::Function({
    name: "\{stream_name}::new",
    params: [],
    return_type: @mbtgen.Type::Named(stream_name),
    body: [
      @mbtgen.Stmt::Raw(
        "\{stream_name}::{ queue: @async.Queue::new(kind=Blocking(0)) }",
      ),
    ],
    is_async: false,
    is_pub: true,
    can_raise: false,
    doc: None,
  })
}

///|
fn emit_sse_stream_write_event(union_name : String) -> @mbtgen.TopLevel {
  let stream_name = sse_stream_name(union_name)
  let params : Array[@mbtgen.Param] = [
    { name: "self", type_: @mbtgen.Type::Named(stream_name), is_optional: None },
    { name: "event", type_: @mbtgen.Type::Named(union_name), is_optional: None },
  ]
  @mbtgen.TopLevel::Function({
    name: "\{stream_name}::write_event",
    params,
    return_type: @mbtgen.Type::Unit,
    body: [@mbtgen.Stmt::Raw("self.queue.put(event)")],
    is_async: true,
    is_pub: true,
    can_raise: false,
    doc: None,
  })
}

///|
fn emit_sse_stream_close(union_name : String) -> @mbtgen.TopLevel {
  let stream_name = sse_stream_name(union_name)
  let params : Array[@mbtgen.Param] = [
    { name: "self", type_: @mbtgen.Type::Named(stream_name), is_optional: None },
  ]
  @mbtgen.TopLevel::Function({
    name: "\{stream_name}::close",
    params,
    return_type: @mbtgen.Type::Unit,
    body: [@mbtgen.Stmt::Raw("self.queue.close()")],
    is_async: false,
    is_pub: true,
    can_raise: false,
    doc: None,
  })
}

///|
fn emit_sse_stream_next(union_name : String) -> @mbtgen.TopLevel {
  let stream_name = sse_stream_name(union_name)
  let raw_body =
    #|Some(self.queue.get()) catch {
    #|  @aqueue.QueueAlreadyClosed => None
    #|  err => raise err
    #|}
  let params : Array[@mbtgen.Param] = [
    { name: "self", type_: @mbtgen.Type::Named(stream_name), is_optional: None },
  ]
  @mbtgen.TopLevel::Function({
    name: "\{stream_name}::next",
    params,
    return_type: @mbtgen.Type::Named("\{union_name}?"),
    body: [@mbtgen.Stmt::Raw(raw_body)],
    is_async: true,
    is_pub: false,
    can_raise: false,
    doc: None,
  })
}

///|
fn emit_sse_result_enum(
  service : ServerService,
  op : ServerOperation,
  type_ctx : EncodeTypeContext,
) -> @mbtgen.TopLevel raise {
  let variants = Array::new()
  match op.sse_event_union {
    Some(union) => {
      let union_name = union_to_type_string_with_ctx(type_ctx, union)
      let stream_variant : @mbtgen.EnumVariant = {
        name: "Stream",
        payload: Some(@mbtgen.Type::Named(sse_stream_name(union_name))),
        doc: None,
        json_name: None,
      }
      variants.push(stream_variant)
    }
    None =>
      fail("sse operation \{service.name}.\{op.name} missing events union")
  }
  for err in op.sse_error_responses {
    let payload = match err.body {
      Some(t) =>
        Some(
          @mbtgen.Type::Named(type_spec_to_type_string_with_ctx(type_ctx, t)),
        )
      None => None
    }
    let variant : @mbtgen.EnumVariant = {
      name: status_variant_name(err.status_code),
      payload,
      doc: None,
      json_name: None,
    }
    variants.push(variant)
  }
  @mbtgen.TopLevel::Enum(sse_result_name(service, op), variants, [], None)
}

///|
fn emit_handler_trait(
  service : ServerService,
  type_ctx : EncodeTypeContext,
) -> @mbtgen.TopLevel raise {
  let methods = Array::new()
  for op in service.operations {
    let params : Array[@mbtgen.Param] = [
      { name: "self", type_: @mbtgen.Type::Named("Self"), is_optional: None },
      {
        name: "group",
        type_: @mbtgen.Type::Named("@async.TaskGroup[Unit]"),
        is_optional: Some(false),
      },
    ]
    for p in op.params {
      let param : @mbtgen.Param = {
        name: p.var_name,
        type_: @mbtgen.Type::Named(
          type_spec_to_type_string_with_ctx(type_ctx, p.type_),
        ),
        is_optional: None,
      }
      params.push(param)
    }
    let return_type = if op.is_sse {
      @mbtgen.Type::Named(sse_result_name(service, op))
    } else {
      match op.response_body {
        Some(t) =>
          @mbtgen.Type::Named(type_spec_to_type_string_with_ctx(type_ctx, t))
        None => @mbtgen.Type::Unit
      }
    }
    let method_sig : @mbtgen.FunctionSignature = {
      name: op.method_name,
      params,
      return_type,
      is_async: true,
      can_raise: false,
      doc: None,
    }
    methods.push(method_sig)
  }
  @mbtgen.TopLevel::Trait(
    service.trait_name,
    methods,
    Some("Traits for operation handlers"),
  )
}

///|
fn emit_route_match_enum() -> @mbtgen.TopLevel {
  let variants : Array[@mbtgen.EnumVariant] = [
    { name: "Handled", payload: None, doc: None, json_name: None },
    { name: "NotMatched", payload: None, doc: None, json_name: None },
    { name: "MethodNotAllowed", payload: None, doc: None, json_name: None },
  ]
  @mbtgen.TopLevel::Enum(
    "RouteMatch",
    variants,
    [],
    Some("路由匹配结果。"),
  )
}

///|
fn emit_router_type_alias() -> @mbtgen.TopLevel {
  @mbtgen.TopLevel::TypeAlias(
    "Router",
    @mbtgen.Type::Named(
      "async (@http.Request, &@io.Reader, @http.ServerConnection) -> RouteMatch",
    ),
    None,
  )
}

///|
fn emit_route_id_enum(services : Array[ServerService]) -> @mbtgen.TopLevel {
  let variants = Array::new()
  for service in services {
    for op in service.operations {
      let path_params = op.params.filter(fn(p) { p.location == "path" })
      let variant : @mbtgen.EnumVariant = {
        name: op.route_id_ctor,
        payload: if path_params.length() == 0 {
          None
        } else {
          Some(@mbtgen.Type::Array(@mbtgen.Type::String))
        },
        doc: None,
        json_name: None,
      }
      variants.push(variant)
    }
  }
  @mbtgen.TopLevel::Enum(
    "RouteId",
    variants,
    [],
    Some("生成期固定的路由 ID（用于 match_route 的返回值）。"),
  )
}

///|
fn emit_match_route_result_enum() -> @mbtgen.TopLevel {
  let variants : Array[@mbtgen.EnumVariant] = [
    { name: "NotMatched", payload: None, doc: None, json_name: None },
    { name: "MethodNotAllowed", payload: None, doc: None, json_name: None },
    {
      name: "Matched",
      payload: Some(@mbtgen.Type::Named("RouteId")),
      doc: None,
      json_name: None,
    },
  ]
  @mbtgen.TopLevel::Enum(
    "MatchRouteResult",
    variants,
    [],
    Some(
      "路由匹配结果（纯匹配：不读 body、不写响应、不调用 handler）。",
    ),
  )
}

///|
fn emit_match_route_fn(
  services : Array[ServerService],
) -> @mbtgen.TopLevel raise {
  let body = build_match_route_body(services)
  let params : Array[@mbtgen.Param] = [
    {
      name: "meth",
      type_: @mbtgen.Type::Named("@http.RequestMethod"),
      is_optional: None,
    },
    { name: "full_path", type_: @mbtgen.Type::String, is_optional: None },
  ]
  @mbtgen.TopLevel::Function({
    name: "match_route",
    params,
    return_type: @mbtgen.Type::Named("MatchRouteResult"),
    body: [@mbtgen.Stmt::Raw(body)],
    is_async: false,
    is_pub: true,
    can_raise: false,
    doc: Some(
      "匹配 method + path，并返回命中的 RouteId（若命中）。",
    ),
  })
}

///|
fn build_match_route_body(services : Array[ServerService]) -> String raise {
  let routes : Array[RouteSpec] = Array::new()
  for service in services {
    for op in service.operations {
      let normalized_tmpl = normalize_uri_template(op.path)
      let segments = parse_route_segments(normalized_tmpl)
      let tmpl_param_names : Array[String] = Array::new()
      for seg in segments {
        match seg {
          Param(name) => tmpl_param_names.push(name)
          _ => ()
        }
      }
      let tmpl_param_set : Map[String, Unit] = Map::new()
      for name in tmpl_param_names {
        if tmpl_param_set.contains(name) {
          fail("duplicate path parameter name in template: \{normalized_tmpl}")
        }
        tmpl_param_set.set(name, ())
      }
      let op_param_names : Array[String] = Array::new()
      let path_param_vars : Array[String] = Array::new()
      let op_param_set : Map[String, Unit] = Map::new()
      for p in op.params {
        if p.location == "path" {
          op_param_names.push(p.name)
          path_param_vars.push(sanitize_path_param_var(p.name))
          if op_param_set.contains(p.name) {
            fail(
              "duplicate path parameter name in operation parameters: \{normalized_tmpl}",
            )
          }
          op_param_set.set(p.name, ())
        }
      }
      let tmpl_list = join_strings(tmpl_param_names, ", ")
      let op_list = join_strings(op_param_names, ", ")
      for name in op_param_names {
        if !tmpl_param_set.contains(name) {
          fail(
            "path parameters mismatch between template and operation parameters: \{normalized_tmpl} (template=[\{tmpl_list}], op=[\{op_list}])",
          )
        }
      }
      routes.push({
        segments,
        meth_ctor: server_meth_ctor(op.http_method),
        route_id_ctor: op.route_id_ctor,
        path_param_vars,
      })
    }
  }
  let route_tree = into_route_tree(routes)
  let sb = StringBuilder::new(size_hint=2048)
  wln(sb, "let path = @runtime.strip_request_query(full_path)")
  emit_match_route_handler(sb, 0, route_tree)
  sb.to_string()
}

///|
fn emit_create_router_fn(
  services : Array[ServerService],
  type_ctx : EncodeTypeContext,
) -> @mbtgen.TopLevel raise {
  @mbtgen.TopLevel::Function({
    name: build_create_router_name(services),
    params: build_create_router_params(services),
    return_type: @mbtgen.Type::Named("Router"),
    body: [@mbtgen.Stmt::Raw(build_create_router_body(services, type_ctx))],
    is_async: false,
    is_pub: true,
    can_raise: false,
    doc: None,
  })
}

///|
fn build_create_router_name(services : Array[ServerService]) -> String {
  let sb = StringBuilder::new()
  sb.write_string("[")
  for i in 0..<services.length() {
    sb.write_string("H\{i.to_string()} : \{services[i].trait_name}, ")
  }
  sb.write_string("] create_router")
  sb.to_string()
}

///|
fn build_create_router_params(
  services : Array[ServerService],
) -> Array[@mbtgen.Param] {
  let params : Array[@mbtgen.Param] = Array::new()
  for i in 0..<services.length() {
    let param : @mbtgen.Param = {
      name: services[i].handler_var,
      type_: @mbtgen.Type::Named("H\{i.to_string()}"),
      is_optional: Some(false),
    }
    params.push(param)
  }
  let group_param : @mbtgen.Param = {
    name: "group",
    type_: @mbtgen.Type::Named("@async.TaskGroup[Unit]"),
    is_optional: Some(false),
  }
  params.push(group_param)
  params
}

///|
fn build_create_router_body(
  services : Array[ServerService],
  type_ctx : EncodeTypeContext,
) -> String raise {
  let sb = StringBuilder::new(size_hint=4096)
  sb.write_string(
    (
      #|async fn(req : @http.Request, body_stream : &@io.Reader, conn : @http.ServerConnection) -> RouteMatch {
      #|  let full_path = req.path
      #|  match match_route(req.meth, full_path) {
      #|    MatchRouteResult::Matched(route_id) => {
      #|      match route_id {
    ),
  )
  let mut op_counter = 0
  for service in services {
    for op in service.operations {
      op_counter += 1
      let path_params = op.params.filter(fn(p) { p.location == "path" })
      if path_params.length() == 0 {
        wln(sb, "        RouteId::\{op.route_id_ctor} => {")
      } else {
        wln(sb, "        RouteId::\{op.route_id_ctor}(path_params) => {")
        for i in 0..<path_params.length() {
          let var_name = sanitize_identifier(
            @case.snake_case(path_params[i].name),
          )
          wln(sb, "          let \{var_name} = path_params[\{i.to_string()}]")
        }
      }
      let has_body = for param in op.params {
        if param.location == "body" {
          break true
        }
      } nobreak {
        false
      }
      if has_body {
        sb.write_string(
          (
            #|          let body_bytes = body_stream.read_all()
            #|          let body_str = body_bytes.text()
            #|
          ),
        )
      } else {
        wln(sb, "          ignore(body_stream)")
        wln(sb, "")
      }
      let call_arg_exprs : Array[String] = Array::new()
      for param in op.params {
        let pname = sanitize_identifier(@case.snake_case(param.name))
        match param.location {
          "path" => call_arg_exprs.push(pname)
          _ => {
            let var_name = "p_\{op_counter.to_string()}_\{pname}"
            call_arg_exprs.push(var_name)
            match param.location {
              "body" =>
                wln(
                  sb,
                  "          let \{var_name} : \{type_spec_to_type_string_with_ctx(type_ctx, param.type_)} = @json.from_json(@json.parse(body_str))",
                )
              "header" =>
                wln(
                  sb,
                  "          let \{var_name} = @runtime.get_header(req.headers, \"\{param.name}\")",
                )
              "query" =>
                wln(
                  sb,
                  "          let \{var_name} = @runtime.get_query_param(full_path, \"\{param.name}\")",
                )
              _ => fail("unsupported parameter location: \{param.location}")
            }
          }
        }
      }
      if op.is_sse {
        let result_enum = sse_result_name(service, op)
        let sse_union = match op.sse_event_union {
          Some(u) => u
          None =>
            fail(
              "sse operation \{service.name}.\{op.name} missing events union",
            )
        }
        sb.write_string(
          "          let sse_result = \{service.handler_var}.\{op.method_name}(group~, ",
        )
        for arg in call_arg_exprs {
          sb.write_string("\{arg},")
        }
        wln(sb, ")")
        sb.write_string(
          (
            $|          match sse_result {
            $|\{result_enum}::Stream(stream) => {
            $|              let sse = @runtime.EventStreamWriter::start(conn, \{op.status_code.to_string()}, "\{status_reason_phrase(op.status_code)}")
            $|              for {
            $|                match stream.next() {
            $|                  Some(event) => match event {
          ),
        )
        let variant_list = sse_union.variants().to_array()
        let ctor_names = collect_union_ctor_names(sse_union)
        for i in 0..<variant_list.length() {
          let variant = variant_list[i]
          let ctor = ctor_names[i]
          let data_type = type_spec_to_type_string_with_ctx(
            type_ctx,
            variant.type_(),
          )
          let data_expr = if data_type == "String" {
            "payload"
          } else {
            "payload.to_json().stringify()"
          }
          let event_name = StringBuilder::new()
          write_escaped_string_literal(event_name, variant.name())
          wln(
            sb,
            "                    \{ctor}(payload) => sse.write_event(event?=Some(\"\{event_name.to_string()}\"), data=\{data_expr})",
          )
        }
        sb.write_string(
          (
            #|                  }
            #|                  None => break
            #|                }
            #|              }
            #|              sse.close()
            #|            }
            #|
          ),
        )
        for err in op.sse_error_responses {
          let ctor = status_variant_name(err.status_code)
          match err.body {
            Some(_) =>
              sb.write_string(
                (
                  $|\{result_enum}::\{ctor}(resp_body) => {
                  $|              let headers : Map[String, String] = { "content-type": "application/json" }
                  $|              conn.send_response(\{err.status_code.to_string()}, "\{status_reason_phrase(err.status_code)}", extra_headers=headers)
                  $|              conn.write(resp_body.to_json().stringify())
                  $|              conn.end_response()
                  $|            }
                ),
              )
            None =>
              sb.write_string(
                (
                  $|\{result_enum}::\{ctor} => {
                  $|              conn.send_response(\{err.status_code.to_string()}, "\{status_reason_phrase(err.status_code)}")
                  $|              conn.end_response()
                  $|            }
                ),
              )
          }
        }
        sb.write_string(
          (
            #|          }
            #|          RouteMatch::Handled
            #|        }
          ),
        )
        wln(sb, "")
        continue
      }
      match op.response_body {
        Some(_) => {
          sb.write_string(
            "          let resp_body = \{service.handler_var}.\{op.method_name}(group~, ",
          )
          for arg in call_arg_exprs {
            sb.write_string("\{arg},")
          }
          sb.write_string(
            (
              $|)
              $|          let headers : Map[String, String] = { "content-type": "application/json" }
              $|          conn.send_response(\{op.status_code.to_string()}, "\{status_reason_phrase(op.status_code)}", extra_headers=headers)
              $|          conn.write(resp_body.to_json().stringify())
              $|          conn.end_response()
              $|          RouteMatch::Handled
              $|        }
            ),
          )
          wln(sb, "")
        }
        None => {
          sb.write_string(
            "          \{service.handler_var}.\{op.method_name}(group~, ",
          )
          for arg in call_arg_exprs {
            sb.write_string("\{arg},")
          }
          sb.write_string(
            (
              $|)
              $|          conn.send_response(\{op.status_code.to_string()}, "\{status_reason_phrase(op.status_code)}")
              $|          conn.end_response()
              $|          RouteMatch::Handled
              $|        }
            ),
          )
          wln(sb, "")
        }
      }
    }
  }
  sb.write_string(
    (
      #|      }
      #|    }
      #|    MatchRouteResult::MethodNotAllowed => RouteMatch::MethodNotAllowed
      #|    MatchRouteResult::NotMatched => RouteMatch::NotMatched
      #|  }
      #|}
    ),
  )
  sb.to_string()
}

///|
fn emit_create_dispatch_fn() -> @mbtgen.TopLevel {
  let raw_body =
    #|async fn(req : @http.Request, body_stream : &@io.Reader, conn : @http.ServerConnection) {
    #|  let result = router(req, body_stream, conn)
    #|  match result {
    #|    RouteMatch::Handled => ()
    #|    RouteMatch::MethodNotAllowed => {
    #|      conn.send_response(405, "Method Not Allowed")
    #|      conn.end_response()
    #|    }
    #|    RouteMatch::NotMatched => {
    #|      conn.send_response(404, "Not Found")
    #|      conn.write("not found")
    #|      conn.end_response()
    #|    }
    #|  }
    #|}
  let params : Array[@mbtgen.Param] = [
    { name: "router", type_: @mbtgen.Type::Named("Router"), is_optional: None },
  ]
  @mbtgen.TopLevel::Function({
    name: "create_dispatch",
    params,
    return_type: @mbtgen.Type::Named(
      "async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit",
    ),
    body: [@mbtgen.Stmt::Raw(raw_body)],
    is_async: false,
    is_pub: true,
    can_raise: false,
    doc: Some("创建一个带默认 fallback 的 dispatch。"),
  })
}
