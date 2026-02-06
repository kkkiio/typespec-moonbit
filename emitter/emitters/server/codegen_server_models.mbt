///|
fn write_union(sb : StringBuilder, u : @codemodel.Union) -> Unit raise {
  let enum_name = @case.pascal_case(u.name)
  sb.write_string(
    (
      $|///|
      $|/// Union \{u.name}
      $|pub(all) enum \{enum_name} {
    ),
  )
  sb.write_char('\n')
  let n = u.variants.length()
  guard n > 0 else { fail("union \{u.name} has no variants") }
  for i in 0..<n {
    let v = u.variants[i]
    let ctor = @case.pascal_case(@codegen.sanitize_identifier(v.name))
    wln(sb, "  \{ctor}(\{type_ref_to_string(v.type_)})")
  }
  sb.write_string(
    (
      $|} derive(Show)
      $|
      $|///|
      $|pub impl Default for \{enum_name} with default() {
    ),
  )
  sb.write_char('\n')
  let default_variant = u.variants[0]
  let default_ctor = @case.pascal_case(
    @codegen.sanitize_identifier(default_variant.name),
  )
  wln(
    sb,
    "  \{default_ctor}(\{type_ref_to_string(default_variant.type_)}::default())",
  )
  sb.write_string(
    (
      $|}
      $|
      $|///|
      $|pub impl ToJson for \{enum_name} with to_json(self : \{enum_name}) -> Json {
      $|  match self {
    ),
  )
  sb.write_char('\n')
  for i in 0..<n {
    let v = u.variants[i]
    let ctor = @case.pascal_case(@codegen.sanitize_identifier(v.name))
    wln(sb, "    \{ctor}(v) => v.to_json()")
  }
  sb.write_string(
    (
      #|  }
      #|}
      #|
    ),
  )
  sb.write_char('\n')
}

///|
fn write_model(
  sb : StringBuilder,
  m : @codemodel.Model,
  derive_fromjson : Bool,
) -> Unit raise {
  let struct_name = @case.pascal_case(m.name)
  sb.write_string(
    (
      $|///|
      $|/// Model \{m.name}
      $|pub(all) struct \{struct_name} {
    ),
  )
  sb.write_char('\n')

  // NOTE: 不考虑 @encodedName；wire name 直接用 TypeSpec property.name。
  // 为避免歧义，若两个字段映射到同一个 snake_case 标识符，直接报错。
  let seen_field_names : Map[String, String] = Map::new() // field_name -> wire_name
  let rename_entries : Array[(String, String)] = Array::new()
  for f in m.fields {
    let field_name = @codegen.sanitize_identifier(@case.snake_case(f.name))
    if seen_field_names.contains(field_name) {
      let prev = seen_field_names.get(field_name).unwrap()
      if prev != f.name {
        fail(
          "model field name collision after snake_case: \{m.name}.\{prev} and \{m.name}.\{f.name} both map to \{field_name}",
        )
      }
    } else {
      seen_field_names.set(field_name, f.name)
    }
    let mut line = "  \{field_name} : \{type_ref_to_string(f.type_)}"
    if f.optional {
      line = line + "?"
    }
    wln(sb, line)
    if field_name != f.name {
      rename_entries.push((field_name, f.name))
    }
  }
  sb.write_string("} derive(Show, Default, ")
  let has_renames = rename_entries.length() > 0
  if !has_renames {
    sb.write_string("ToJson")
  } else {
    sb.write_string("ToJson(fields(")
    let n = rename_entries.length()
    for i in 0..<n {
      let entry = rename_entries[i]
      sb.write_string("\{entry.0}(rename=\"\{entry.1}\")")
      if i != n - 1 {
        sb.write_string(", ")
      }
    }
    sb.write_string("))")
  }
  if derive_fromjson {
    sb.write_string(", ")
    if !has_renames {
      sb.write_string("@json.FromJson")
    } else {
      sb.write_string("@json.FromJson(fields(")
      let n = rename_entries.length()
      for i in 0..<n {
        let entry = rename_entries[i]
        sb.write_string("\{entry.0}(rename=\"\{entry.1}\")")
        if i != n - 1 {
          sb.write_string(", ")
        }
      }
      sb.write_string("))")
    }
  }
  wln(sb, ")")
  wln(sb, "")
}

///|
fn collect_decode_models_from_crate(
  crate : @codemodel.Crate,
) -> Map[String, @codemodel.Model] raise {
  let models = Map::new()
  fn collect_decode_models(type_ : @codemodel.TypeRef) -> Unit raise {
    match type_ {
      Union(u) =>
        fail(
          "Not supported: request-side untagged union \{u.name} in server code generation",
        )
      Model(m) =>
        if !models.contains(m.name) {
          models.set(m.name, m)
          for field in m.fields {
            collect_decode_models(field.type_)
          }
        }
      Array(t) => collect_decode_models(t)
      Record(t) => collect_decode_models(t)
      Nullable(t) => collect_decode_models(t)
      _ => ()
    }
  }

  for client in crate.clients {
    for op in client.methods {
      for param in op.parameters {
        collect_decode_models(param.type_)
      }
    }
  }
  models
}

///|
fn collect_encode_types_from_crate(
  crate : @codemodel.Crate,
) -> (Map[String, @codemodel.Model], Map[String, @codemodel.Union]) {
  let models = Map::new()
  let unions = Map::new()
  for client in crate.clients {
    for op in client.methods {
      match op.response_body {
        Some(t) => collect_encode_types(t, models, unions)
        None => ()
      }
      for err in op.sse_error_responses {
        match err.body {
          Some(t) => collect_encode_types(t, models, unions)
          None => ()
        }
      }
    }
  }
  (models, unions)
}

///|
fn write_sse_event_enum(sb : StringBuilder, u : @codemodel.Union) -> Unit raise {
  let enum_name = @case.pascal_case(u.name)
  sb.write_string(
    (
      $|///|
      $|/// SSE events \{u.name}
      $|pub(all) enum \{enum_name} {
    ),
  )
  let n = u.variants.length()
  guard n > 0 else { fail("union \{u.name} has no variants") }
  for i in 0..<n {
    let v = u.variants[i]
    let ctor = @case.pascal_case(@codegen.sanitize_identifier(v.name))
    wln(sb, "  \{ctor}(\{type_ref_to_string(v.type_)})")
  }
  sb.write_string(
    (
      #|} derive(Show)
      #|
    ),
  )
}

///|
fn collect_encode_types(
  type_ : @codemodel.TypeRef,
  models : Map[String, @codemodel.Model],
  unions : Map[String, @codemodel.Union],
) -> Unit {
  match type_ {
    Model(m) =>
      if !models.contains(m.name) {
        models.set(m.name, m)
        for field in m.fields {
          collect_encode_types(field.type_, models, unions)
        }
      }
    Union(u) =>
      if !unions.contains(u.name) {
        unions.set(u.name, u)
        for v in u.variants {
          collect_encode_types(v.type_, models, unions)
        }
      }
    Array(t) => collect_encode_types(t, models, unions)
    Record(t) => collect_encode_types(t, models, unions)
    Nullable(t) => collect_encode_types(t, models, unions)
    _ => ()
  }
}

///|
fn emit_server_models(crate : @codemodel.Crate) -> String raise {
  let buf = StringBuilder::new(size_hint=8192)

  // Nullable helper (for `T | null`) is provided by runtime.
  buf.write_string(
    "///|\n#warnings(\"-unused_type_declaration\")\npub using @runtime {type Nullable}\n\n",
  )
  let decode_models = collect_decode_models_from_crate(crate)
  let (encode_models, encode_unions) = collect_encode_types_from_crate(crate)
  let sse_unions = collect_sse_unions(crate)
  for _, u in sse_unions {
    for v in u.variants {
      collect_encode_types(v.type_, encode_models, encode_unions)
    }
  }
  let models = encode_models.merge(decode_models)

  // SSE Event Enums (no Default/ToJson)
  let sse_union_list = sse_unions.to_array()
  sse_union_list.sort_by_key(fn(u) { u.0 })
  for item in sse_union_list {
    write_sse_event_enum(buf, item.1)
  }

  // Union Enums (ToJson only)
  let union_list = encode_unions.to_array()
  union_list.sort_by_key(fn(u) { u.0 })
  for item in union_list {
    write_union(buf, item.1)
  }

  // Model Structs
  let model_list = models.to_array()
  model_list.sort_by_key(fn(m) { m.0 })
  for item in model_list {
    let m = item.1
    write_model(buf, m, decode_models.contains(m.name))
  }
  buf.to_string()
}
