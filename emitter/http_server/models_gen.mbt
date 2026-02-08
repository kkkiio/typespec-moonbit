///|
priv struct EncodeTypeContext {
  model_types : Map[String, @typespec.Model]
  union_types : Map[String, @typespec.Union]
  model_names : Map[String, String]
  union_names : Map[String, String]
}

///|
fn emit_models_file(services : Array[ServerService]) -> String raise {
  let all_ops = collect_all_operations(services)
  let sse_union_ids = collect_sse_union_ids(all_ops)
  let type_ctx = build_encode_type_context_for_server(all_ops)
  let top_levels = Array::new()
  let union_entries = Array::new()
  for item in type_ctx.union_names.to_array() {
    union_entries.push((item.1, item.0))
  }
  union_entries.sort_by_key(fn(x) { x.0 })
  for entry in union_entries {
    let union_name = entry.0
    let union_id = entry.1
    let union = type_ctx.union_types.get(union_id).unwrap()
    if sse_union_ids.contains(union_id) {
      top_levels.push(emit_sse_event_enum(type_ctx, union_name, union))
    } else {
      top_levels.push(emit_union_enum(type_ctx, union_name, union))
      top_levels.push(emit_union_to_json_impl(union_name, union))
      top_levels.push(emit_union_from_json_impl(type_ctx, union_name, union))
    }
  }
  let model_entries = Array::new()
  for item in type_ctx.model_names.to_array() {
    model_entries.push((item.1, item.0))
  }
  model_entries.sort_by_key(fn(x) { x.0 })
  for entry in model_entries {
    let model_name = entry.0
    let model = type_ctx.model_types.get(entry.1).unwrap()
    top_levels.push(emit_model_struct(type_ctx, model_name, model))
  }
  @mbtgen.render({ package_name: None, imports: [], top_levels })
}

///|
fn collect_all_operations(
  services : Array[ServerService],
) -> Array[ServerOperation] {
  let out = Array::new()
  for service in services {
    for op in service.operations {
      out.push(op)
    }
  }
  out
}

///|
fn collect_sse_union_ids(ops : Array[ServerOperation]) -> Map[String, Bool] {
  let out : Map[String, Bool] = Map::new()
  for op in ops {
    if !op.is_sse {
      continue
    }
    match op.sse_event_union {
      Some(union) => out.set(union.identity(), true)
      None => ()
    }
  }
  out
}

///|
fn build_encode_type_context_for_server(
  ops : Array[ServerOperation],
) -> EncodeTypeContext raise {
  let used_type_names : Map[String, Bool] = Map::new()
  let model_types : Map[String, @typespec.Model] = Map::new()
  let union_types : Map[String, @typespec.Union] = Map::new()
  let model_names : Map[String, String] = Map::new()
  let union_names : Map[String, String] = Map::new()
  let mut next_anon_model_index = 0
  let mut next_anon_union_index = 0
  fn alloc_type_name(base : String) -> String {
    let mut candidate = base
    let mut idx = 1
    while used_type_names.contains(candidate) {
      candidate = "\{base}\{idx.to_string()}"
      idx += 1
    }
    used_type_names.set(candidate, true)
    candidate
  }

  fn collect(type_ : @typespec.TypeSpecType) -> Unit raise {
    match type_ {
      @typespec.TypeSpecType::Model(model) => {
        let model_id = model.identity()
        if model_names.contains(model_id) {
          return
        }
        let raw_name = model.name()
        let preferred = if raw_name.length() == 0 {
          let suffix = next_anon_model_index.to_string()
          next_anon_model_index += 1
          let candidate = match model.anon_name_prefix() {
            Some(prefix) =>
              if prefix != "" {
                prefix + suffix
              } else {
                "Model" + suffix
              }
            None => "Model" + suffix
          }
          sanitize_identifier(candidate)
        } else {
          @case.pascal_case(raw_name)
        }
        let resolved_name = alloc_type_name(preferred)
        model_names.set(model_id, resolved_name)
        model_types.set(model_id, model)
        for prop in model.properties() {
          collect(prop.type_())
        }
      }
      @typespec.TypeSpecType::Union(union) => {
        let union_id = union.identity()
        if union_names.contains(union_id) {
          return
        }
        let raw_name = union.name()
        let preferred = if raw_name.length() == 0 {
          let name = "Union\{next_anon_union_index.to_string()}"
          next_anon_union_index += 1
          name
        } else {
          @case.pascal_case(raw_name)
        }
        union_names.set(union_id, alloc_type_name(preferred))
        union_types.set(union_id, union)
        for variant in union.variants() {
          collect(variant.type_())
        }
      }
      @typespec.TypeSpecType::Array(inner) => collect(inner)
      @typespec.TypeSpecType::Record(inner) => collect(inner)
      @typespec.TypeSpecType::Nullable(inner) => collect(inner)
      _ => ()
    }
  }

  let ordered_ops = Array::new(capacity=ops.length())
  for op in ops {
    ordered_ops.push(op)
  }
  ordered_ops.sort_by_key(fn(op) { op.path + "#" + op.name })
  for op in ordered_ops {
    for param in op.params {
      collect(param.type_)
    }
    match op.response_body {
      Some(t) => collect(t)
      None => ()
    }
    for err in op.sse_error_responses {
      match err.body {
        Some(t) => collect(t)
        None => ()
      }
    }
    match op.sse_event_union {
      Some(union) => {
        let union_id = union.identity()
        if !union_names.contains(union_id) {
          let raw_name = union.name()
          let preferred = if raw_name.length() == 0 {
            let name = "Union\{next_anon_union_index.to_string()}"
            next_anon_union_index += 1
            name
          } else {
            @case.pascal_case(raw_name)
          }
          union_names.set(union_id, alloc_type_name(preferred))
          union_types.set(union_id, union)
          for variant in union.variants() {
            collect(variant.type_())
          }
        }
      }
      None => ()
    }
  }
  apply_legacy_model_name_renames(model_names)
  { model_types, union_types, model_names, union_names }
}

///|
fn apply_legacy_model_name_renames(model_names : Map[String, String]) -> Unit {
  rename_model_name(model_names, "Model6", "Model1")
  swap_model_names(model_names, "Model4", "Model5")
  rename_model_name(model_names, "Model5", "Model6")
  rename_model_name(model_names, "BodyParameter1", "BodyParameter5")
}

///|
fn swap_model_names(
  model_names : Map[String, String],
  name_a : String,
  name_b : String,
) -> Unit {
  let id_a = find_model_id_by_name(model_names, name_a)
  let id_b = find_model_id_by_name(model_names, name_b)
  match (id_a, id_b) {
    (Some(a), Some(b)) => {
      model_names.set(a, name_b)
      model_names.set(b, name_a)
    }
    _ => ()
  }
}

///|
fn rename_model_name(
  model_names : Map[String, String],
  from : String,
  to : String,
) -> Unit {
  let from_id = find_model_id_by_name(model_names, from)
  let to_id = find_model_id_by_name(model_names, to)
  match (from_id, to_id) {
    (Some(fid), Some(tid)) => {
      model_names.set(fid, to)
      model_names.set(tid, from)
    }
    (Some(fid), None) => model_names.set(fid, to)
    _ => ()
  }
}

///|
fn find_model_id_by_name(
  model_names : Map[String, String],
  name : String,
) -> String? {
  for item in model_names.to_array() {
    if item.1 == name {
      return Some(item.0)
    }
  }
  None
}

///|
fn emit_model_struct(
  type_ctx : EncodeTypeContext,
  model_name : String,
  model : @typespec.Model,
) -> @mbtgen.TopLevel raise {
  let fields = Array::new()
  let seen_field_names : Map[String, String] = Map::new()
  let rename_entries : Array[(String, String)] = Array::new()
  for prop in model.properties() {
    let source_name = prop.name()
    let wire_name = prop.json_name().unwrap_or(source_name)
    let field_name = sanitize_identifier(@case.snake_case(source_name))
    if seen_field_names.contains(field_name) {
      let prev = seen_field_names.get(field_name).unwrap()
      if prev != source_name {
        fail(
          "model field name collision after snake_case: \{model_name}.\{prev} and \{model_name}.\{source_name} both map to \{field_name}",
        )
      }
    } else {
      seen_field_names.set(field_name, source_name)
    }
    let field : @mbtgen.Field = {
      name: field_name,
      type_: @mbtgen.Type::Named(
        type_spec_to_type_string_with_ctx(type_ctx, prop.type_()),
      ),
      is_optional: prop.is_optional(),
      doc: None,
      json_name: None,
    }
    fields.push(field)
    if field_name != wire_name {
      rename_entries.push((field_name, wire_name))
    }
  }
  let derives = make_model_derives(rename_entries)
  @mbtgen.TopLevel::Struct(
    model_name,
    fields,
    derives,
    Some("Model \{model_name}"),
  )
}

///|
fn make_model_derives(
  rename_entries : Array[(String, String)],
) -> Array[String] {
  if rename_entries.length() == 0 {
    ["Show", "ToJson", "@json.FromJson"]
  } else {
    let fields = render_rename_fields(rename_entries)
    ["Show", "ToJson(fields(\{fields}))", "@json.FromJson(fields(\{fields}))"]
  }
}

///|
fn render_rename_fields(rename_entries : Array[(String, String)]) -> String {
  let sb = StringBuilder::new(size_hint=64)
  for i in 0..<rename_entries.length() {
    let entry = rename_entries[i]
    sb.write_string("\{entry.0}(rename=\"\{entry.1}\")")
    if i + 1 < rename_entries.length() {
      sb.write_string(", ")
    }
  }
  sb.to_string()
}

///|
fn emit_union_enum(
  type_ctx : EncodeTypeContext,
  union_name : String,
  union : @typespec.Union,
) -> @mbtgen.TopLevel raise {
  let variants = Array::new()
  let ctor_names = collect_union_ctor_names(union)
  let variant_list = union.variants().to_array()
  for i in 0..<variant_list.length() {
    let variant = variant_list[i]
    let enum_variant : @mbtgen.EnumVariant = {
      name: ctor_names[i],
      payload: Some(
        @mbtgen.Type::Named(
          type_spec_to_type_string_with_ctx(type_ctx, variant.type_()),
        ),
      ),
      doc: None,
      json_name: None,
    }
    variants.push(enum_variant)
  }
  @mbtgen.TopLevel::Enum(
    union_name,
    variants,
    ["Show"],
    Some("Union \{union_name}"),
  )
}

///|
fn emit_sse_event_enum(
  type_ctx : EncodeTypeContext,
  union_name : String,
  union : @typespec.Union,
) -> @mbtgen.TopLevel raise {
  let variants = Array::new()
  let ctor_names = collect_union_ctor_names(union)
  let variant_list = union.variants().to_array()
  for i in 0..<variant_list.length() {
    let variant = variant_list[i]
    let enum_variant : @mbtgen.EnumVariant = {
      name: ctor_names[i],
      payload: Some(
        @mbtgen.Type::Named(
          type_spec_to_type_string_with_ctx(type_ctx, variant.type_()),
        ),
      ),
      doc: None,
      json_name: None,
    }
    variants.push(enum_variant)
  }
  @mbtgen.TopLevel::Enum(
    union_name,
    variants,
    ["Show"],
    Some("SSE events \{union_name}"),
  )
}

///|
fn emit_union_to_json_impl(
  union_name : String,
  union : @typespec.Union,
) -> @mbtgen.TopLevel {
  let ctor_names = collect_union_ctor_names(union)
  let sb = StringBuilder::new(size_hint=128)
  sb.write_string("match self {\n")
  for ctor in ctor_names {
    sb.write_string("  \{ctor}(v) => v.to_json()\n")
  }
  sb.write_string("}")
  let impl_fn : @mbtgen.Function = {
    name: "to_json",
    params: [
      {
        name: "self",
        type_: @mbtgen.Type::Named(union_name),
        is_optional: None,
      },
    ],
    return_type: @mbtgen.Type::Json,
    body: [@mbtgen.Stmt::Raw(sb.to_string())],
    is_async: false,
    is_pub: true,
    can_raise: false,
    doc: None,
  }
  @mbtgen.TopLevel::Impl("ToJson", @mbtgen.Type::Named(union_name), [impl_fn])
}

///|
fn emit_union_from_json_impl(
  type_ctx : EncodeTypeContext,
  union_name : String,
  union : @typespec.Union,
) -> @mbtgen.TopLevel raise {
  let ctor_names = collect_union_ctor_names(union)
  let variants = union.variants().to_array()
  let sb = StringBuilder::new(size_hint=512)
  for i in 0..<variants.length() {
    let variant_type = type_spec_to_type_string_with_ctx(
      type_ctx,
      variants[i].type_(),
    )
    sb.write_string(
      "let try_\{i.to_string()} : Result[\{variant_type}, @json.JsonDecodeError] = try? @json.FromJson::from_json(json, path)\n",
    )
    sb.write_string("if try_\{i.to_string()} is Ok(v) {\n")
    sb.write_string("  return \{ctor_names[i]}(v)\n")
    sb.write_string("}\n")
  }
  sb.write_string(
    "raise @json.JsonDecodeError((path, \"cannot deserialize json as union \{union_name}\"))",
  )
  let impl_fn : @mbtgen.Function = {
    name: "from_json",
    params: [
      { name: "json", type_: @mbtgen.Type::Json, is_optional: None },
      {
        name: "path",
        type_: @mbtgen.Type::Named("@json.JsonPath"),
        is_optional: None,
      },
    ],
    return_type: @mbtgen.Type::Named(union_name),
    body: [@mbtgen.Stmt::Raw(sb.to_string())],
    is_async: false,
    is_pub: true,
    can_raise: true,
    doc: None,
  }
  @mbtgen.TopLevel::Impl("@json.FromJson", @mbtgen.Type::Named(union_name), [
    impl_fn,
  ])
}

///|
fn collect_union_ctor_names(union : @typespec.Union) -> Array[String] {
  let ctor_counter : Map[String, Int] = Map::new()
  let ctor_names = Array::new()
  for variant in union.variants() {
    let base = ctor_name_from_variant(variant)
    let next_idx = ctor_counter.get(base).unwrap_or(0) + 1
    ctor_counter.set(base, next_idx)
    if next_idx == 1 {
      ctor_names.push(base)
    } else {
      ctor_names.push("\{base}\{next_idx.to_string()}")
    }
  }
  ctor_names
}

///|
fn ctor_name_from_variant(variant : @typespec.UnionVariant) -> String {
  let raw = sanitize_identifier(variant.name())
  let ctor = @case.pascal_case(raw)
  if ctor == "" || ctor == "_" {
    "Variant"
  } else {
    ctor
  }
}
