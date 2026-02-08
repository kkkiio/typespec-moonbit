///|
/// HTTP Client emitter 入口：由 JS shim 以 `$onEmit` 调用（本函数名为 `on_emit`）。
pub fn on_emit(context : @ffi.EmitContext) -> @js.Promise {
  @js.Promise::unsafe_new(async fn() { on_emit_async(context) })
}

///|
/// HTTP Client emitter 实现
pub async fn on_emit_async(context : @ffi.EmitContext) -> Unit {
  let options = @config.EmitterOptions::from_context(context)
  let program = @ffi.program(context)
  let services = @typespec.get_all_http_services_async(program)
  let files = emit_http_client_files(services, options)
  let out_dir = @ffi.emitter_output_dir(context)
  @fs.create_dir(out_dir)
  for file in files {
    let rel_path = file.path()
    let full_path = join_path(out_dir, rel_path)
    if @fs.path_exists(full_path) && !should_overwrite(rel_path, options) {
      @config.report_file_already_exists(context, full_path)
    } else {
      @fs.write_string_to_file(full_path, file.content())
    }
  }
  @ffi.exec_moon_fmt(out_dir)
}

///|
priv struct GeneratedFile {
  path : String
  content : String
}

///|
fn GeneratedFile::new(path : String, content : String) -> GeneratedFile {
  { path, content }
}

///|
fn GeneratedFile::path(self : GeneratedFile) -> String {
  self.path
}

///|
fn GeneratedFile::content(self : GeneratedFile) -> String {
  self.content
}

///|
fn should_overwrite(path : String, options : @config.EmitterOptions) -> Bool {
  if path == "moon.pkg" {
    options.overwrite_moon_pkg()
  } else {
    true
  }
}

///|
fn join_path(base : String, rel : String) -> String {
  if base.has_suffix("/") {
    base + rel
  } else {
    base + "/" + rel
  }
}

///|
fn emit_http_client_files(
  services : Array[@typespec.HttpService],
  options : @config.EmitterOptions,
) -> Array[GeneratedFile] raise {
  let pkg_name = options.package_name()
  guard pkg_name.length() > 0 else { fail("package-name cannot be empty") }
  let all_ops = collect_all_operations(services)
  let type_ctx = build_encode_type_context(all_ops)
  let models = emit_models_file(type_ctx)
  let client = emit_client_file(services, type_ctx)
  [
    GeneratedFile::new("moon.pkg", emit_client_moon_pkg(pkg_name)),
    GeneratedFile::new("models.mbt", models),
    GeneratedFile::new("client.mbt", client),
  ]
}

///|
fn collect_all_operations(
  services : Array[@typespec.HttpService],
) -> Array[@typespec.HttpOperation] {
  let out = Array::new()
  for service in services {
    for op in service.operations() {
      out.push(op)
    }
  }
  out
}

///|
fn emit_client_moon_pkg(package_name : String) -> String {
  ignore(package_name)
  (
    #|import {
    #|  "moonbitlang/async/http" as @http,
    #|  "moonbitlang/core/encoding/utf8" as @encoding/utf8,
    #|  "moonbitlang/core/json",
    #|  "kkkiio/typespec-client-runtime" as @runtime,
    #|}
  )
}

///|
priv struct EncodeTypeContext {
  model_types : Map[String, @typespec.Model]
  union_types : Map[String, @typespec.Union]
  model_names : Map[String, String]
  union_names : Map[String, String]
}

///|
priv struct ModelFieldInfo {
  field_name : String
  wire_name : String
  type_ : @typespec.TypeSpecType
  optional : Bool
  bytes_encoding : String?
}

///|
fn emit_models_file(type_ctx : EncodeTypeContext) -> String raise {
  let top_levels = Array::new()
  let union_entries = Array::new()
  for item in type_ctx.union_names.to_array() {
    union_entries.push((item.1, item.0))
  }
  union_entries.sort_by_key(fn(x) { x.0 })
  for entry in union_entries {
    let union_name = entry.0
    let union = type_ctx.union_types.get(entry.1).unwrap()
    top_levels.push(emit_union_enum(type_ctx, union_name, union))
    top_levels.push(emit_union_to_json_impl(union_name, union))
    top_levels.push(emit_union_from_json_impl(type_ctx, union_name, union))
  }
  let model_entries = Array::new()
  for item in type_ctx.model_names.to_array() {
    model_entries.push((item.1, item.0))
  }
  model_entries.sort_by_key(fn(x) { x.0 })
  for entry in model_entries {
    let model_name = entry.0
    let model = type_ctx.model_types.get(entry.1).unwrap()
    let (struct_top, field_infos) = emit_model_struct(
      type_ctx, model_name, model,
    )
    top_levels.push(struct_top)
    if model_has_bytes_fields(field_infos) {
      top_levels.push(emit_model_to_json_impl(model_name, field_infos))
      top_levels.push(
        emit_model_from_json_impl(type_ctx, model_name, field_infos),
      )
    }
  }
  let rendered = @mbtgen.render({ package_name: None, imports: [], top_levels })
  let prefix =
    #|///|
    #|#warnings("-unused_type_declaration")
    #|pub using @runtime {type Nullable}
    #|
  prefix + rendered
}

///|
fn build_encode_type_context(
  ops : Array[@typespec.HttpOperation],
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
  ordered_ops.sort_by_key(fn(op) { op.path() + "#" + op.name() })
  for op in ordered_ops {
    for param in op.parameters() {
      collect(param.type_())
    }
    let success = collect_success_responses(op)
    for r in success {
      match r.body {
        Some(type_) => collect(type_)
        None => ()
      }
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
  a_name : String,
  b_name : String,
) -> Unit {
  let a_id = find_model_id_by_name(model_names, a_name)
  let b_id = find_model_id_by_name(model_names, b_name)
  match (a_id, b_id) {
    (Some(a), Some(b)) => {
      model_names.set(a, b_name)
      model_names.set(b, a_name)
    }
    _ => ()
  }
}

///|
fn rename_model_name(
  model_names : Map[String, String],
  from_name : String,
  to_name : String,
) -> Unit {
  if model_name_exists(model_names, to_name) {
    return
  }
  let target_id = find_model_id_by_name(model_names, from_name)
  match target_id {
    Some(id) => model_names.set(id, to_name)
    None => ()
  }
}

///|
fn model_name_exists(model_names : Map[String, String], name : String) -> Bool {
  for item in model_names.to_array() {
    if item.1 == name {
      return true
    }
  }
  false
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
) -> (@mbtgen.TopLevel, Array[ModelFieldInfo]) raise {
  let fields = Array::new()
  let field_infos = Array::new()
  let seen_field_names : Map[String, String] = Map::new()
  let rename_entries : Array[(String, String)] = Array::new()
  for prop in model.properties() {
    let wire_name = prop.name()
    let field_name = sanitize_identifier(@case.snake_case(wire_name))
    if seen_field_names.contains(field_name) {
      let prev = seen_field_names.get(field_name).unwrap()
      if prev != wire_name {
        fail(
          "model field name collision after snake_case: \{model_name}.\{prev} and \{model_name}.\{wire_name} both map to \{field_name}",
        )
      }
    } else {
      seen_field_names.set(field_name, wire_name)
    }
    let field : @mbtgen.Field = {
      name: field_name,
      type_: @mbtgen.Type::Named(
        model_property_type_string(type_ctx, prop.type_()),
      ),
      is_optional: prop.is_optional(),
      doc: None,
      json_name: None,
    }
    fields.push(field)
    field_infos.push({
      field_name,
      wire_name,
      type_: prop.type_(),
      optional: prop.is_optional(),
      bytes_encoding: prop.bytes_encoding(),
    })
    if field_name != wire_name {
      rename_entries.push((field_name, wire_name))
    }
  }
  let derives = make_model_derives(
    rename_entries,
    model_has_bytes_fields(field_infos),
  )
  let struct_top = @mbtgen.TopLevel::Struct(
    model_name,
    fields,
    derives,
    Some("Model \{model_name}"),
  )
  (struct_top, field_infos)
}

///|
fn make_model_derives(
  rename_entries : Array[(String, String)],
  has_bytes_fields : Bool,
) -> Array[String] {
  if has_bytes_fields {
    ignore(rename_entries)
    ["Show"]
  } else if rename_entries.length() == 0 {
    ["Show", "ToJson", "@json.FromJson"]
  } else {
    let fields = render_rename_fields(rename_entries)
    ["Show", "ToJson(fields(\{fields}))", "@json.FromJson(fields(\{fields}))"]
  }
}

///|
fn model_has_bytes_fields(field_infos : Array[ModelFieldInfo]) -> Bool {
  for info in field_infos {
    match info.type_ {
      @typespec.TypeSpecType::Bytes => return true
      @typespec.TypeSpecType::Array(@typespec.TypeSpecType::Bytes) =>
        return true
      _ => ()
    }
  }
  false
}

///|
fn model_property_type_string(
  type_ctx : EncodeTypeContext,
  type_ : @typespec.TypeSpecType,
) -> String raise {
  match type_ {
    @typespec.TypeSpecType::Bytes => "Bytes"
    @typespec.TypeSpecType::Array(@typespec.TypeSpecType::Bytes) =>
      "Array[Bytes]"
    _ => type_spec_to_type_string_with_ctx(type_ctx, type_)
  }
}

///|
fn resolve_model_field_bytes_encoding(raw : String?) -> String raise {
  let lower = match raw {
    Some(v) => v.to_lower()
    None => "base64"
  }
  match lower {
    "base64" => "base64"
    "base64url" => "base64url"
    _ => fail("unsupported bytes encoding for model property: " + lower)
  }
}

///|
fn bytes_encoding_runtime_expr(encoding : String) -> String raise {
  match encoding {
    "base64" => "@runtime.BytesEncoding::Base64"
    "base64url" => "@runtime.BytesEncoding::Base64Url"
    _ => fail("unsupported bytes encoding: " + encoding)
  }
}

///|
fn emit_model_from_json_impl(
  type_ctx : EncodeTypeContext,
  model_name : String,
  field_infos : Array[ModelFieldInfo],
) -> @mbtgen.TopLevel raise {
  let sb = StringBuilder::new(size_hint=256)
  sb.write_string(
    "let obj : Map[String, Json] = @json.from_json(json, path=path)\n",
  )
  for info in field_infos {
    let raw_name = "__raw_\{info.field_name}"
    sb.write_string(
      "let \{raw_name} = obj.get(\"\{info.wire_name}\").unwrap_or(Json::null())\n",
    )
    let var_name = "__\{info.field_name}"
    match info.type_ {
      @typespec.TypeSpecType::Bytes => {
        let encoding = resolve_model_field_bytes_encoding(info.bytes_encoding)
        let encoding_expr = bytes_encoding_runtime_expr(encoding)
        if info.optional {
          sb.write_string(
            "let \{var_name} : Bytes? = if Json::equal(\{raw_name}, Json::null()) { None } else { Some(try! @runtime.decode_bytes(@json.from_json(\{raw_name}, path=path), \{encoding_expr})) }\n",
          )
        } else {
          sb.write_string(
            "let \{var_name} : Bytes = try! @runtime.decode_bytes(@json.from_json(\{raw_name}, path=path), \{encoding_expr})\n",
          )
        }
      }
      @typespec.TypeSpecType::Array(@typespec.TypeSpecType::Bytes) => {
        let encoding = resolve_model_field_bytes_encoding(info.bytes_encoding)
        let encoding_expr = bytes_encoding_runtime_expr(encoding)
        if info.optional {
          sb.write_string(
            "let \{var_name} : Array[Bytes]? = if Json::equal(\{raw_name}, Json::null()) {\n",
          )
          sb.write_string("  None\n")
          sb.write_string("} else {\n")
          sb.write_string(
            "  let encoded : Array[String] = @json.from_json(\{raw_name}, path=path)\n",
          )
          sb.write_string(
            "  Some(encoded.map(fn(s) { try! @runtime.decode_bytes(s, \{encoding_expr}) }))\n",
          )
          sb.write_string("}\n")
        } else {
          sb.write_string(
            "let \{var_name}_encoded : Array[String] = @json.from_json(\{raw_name}, path=path)\n",
          )
          sb.write_string(
            "let \{var_name} : Array[Bytes] = \{var_name}_encoded.map(fn(s) { try! @runtime.decode_bytes(s, \{encoding_expr}) })\n",
          )
        }
      }
      _ => {
        let tstr = model_property_type_string(type_ctx, info.type_)
        if info.optional {
          sb.write_string(
            "let \{var_name} : \{tstr}? = if Json::equal(\{raw_name}, Json::null()) { None } else { Some(@json.from_json(\{raw_name}, path=path)) }\n",
          )
        } else {
          sb.write_string(
            "let \{var_name} : \{tstr} = @json.from_json(\{raw_name}, path=path)\n",
          )
        }
      }
    }
  }
  sb.write_string("{\n")
  for info in field_infos {
    sb.write_string("  \{info.field_name}: __\{info.field_name},\n")
  }
  sb.write_string("}")
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
    return_type: @mbtgen.Type::Named(model_name),
    body: [@mbtgen.Stmt::Raw(sb.to_string())],
    is_async: false,
    is_pub: true,
    can_raise: true,
    doc: None,
  }
  @mbtgen.TopLevel::Impl("@json.FromJson", @mbtgen.Type::Named(model_name), [
    impl_fn,
  ])
}

///|
fn emit_model_to_json_impl(
  model_name : String,
  field_infos : Array[ModelFieldInfo],
) -> @mbtgen.TopLevel raise {
  let sb = StringBuilder::new(size_hint=128)
  sb.write_string("let obj : Map[String, Json] = {}\n")
  for info in field_infos {
    let field_ref = "self.\{info.field_name}"
    let value_expr = match info.type_ {
      @typespec.TypeSpecType::Bytes => {
        let encoding = resolve_model_field_bytes_encoding(info.bytes_encoding)
        let encoding_expr = bytes_encoding_runtime_expr(encoding)
        if info.optional {
          "match \{field_ref} { Some(v) => Json::string(try! @runtime.encode_bytes(v, \{encoding_expr})), None => Json::null() }"
        } else {
          "Json::string(try! @runtime.encode_bytes(\{field_ref}, \{encoding_expr}))"
        }
      }
      @typespec.TypeSpecType::Array(@typespec.TypeSpecType::Bytes) => {
        let encoding = resolve_model_field_bytes_encoding(info.bytes_encoding)
        let encoding_expr = bytes_encoding_runtime_expr(encoding)
        if info.optional {
          "match \{field_ref} { Some(v) => (try! @runtime.encode_bytes_list(v, \{encoding_expr})).to_json(), None => Json::null() }"
        } else {
          "(try! @runtime.encode_bytes_list(\{field_ref}, \{encoding_expr})).to_json()"
        }
      }
      _ => "\{field_ref}.to_json()"
    }
    sb.write_string("obj.set(\"\{info.wire_name}\", \{value_expr})\n")
  }
  sb.write_string("Json::object(obj)")
  let impl_fn : @mbtgen.Function = {
    name: "to_json",
    params: [
      {
        name: "self",
        type_: @mbtgen.Type::Named(model_name),
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
  @mbtgen.TopLevel::Impl("ToJson", @mbtgen.Type::Named(model_name), [impl_fn])
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
fn emit_union_to_json_impl(
  union_name : String,
  union : @typespec.Union,
) -> @mbtgen.TopLevel {
  let enum_name = union_name
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
      { name: "self", type_: @mbtgen.Type::Named(enum_name), is_optional: None },
    ],
    return_type: @mbtgen.Type::Json,
    body: [@mbtgen.Stmt::Raw(sb.to_string())],
    is_async: false,
    is_pub: true,
    can_raise: false,
    doc: None,
  }
  @mbtgen.TopLevel::Impl("ToJson", @mbtgen.Type::Named(enum_name), [impl_fn])
}

///|
fn emit_union_from_json_impl(
  type_ctx : EncodeTypeContext,
  union_name : String,
  union : @typespec.Union,
) -> @mbtgen.TopLevel raise {
  let enum_name = union_name
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
    "raise @json.JsonDecodeError((path, \"cannot deserialize json as union \{enum_name}\"))",
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
    return_type: @mbtgen.Type::Named(enum_name),
    body: [@mbtgen.Stmt::Raw(sb.to_string())],
    is_async: false,
    is_pub: true,
    can_raise: true,
    doc: None,
  }
  @mbtgen.TopLevel::Impl("@json.FromJson", @mbtgen.Type::Named(enum_name), [
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
    let ctor = if next_idx == 1 {
      base
    } else {
      "\{base}\{next_idx.to_string()}"
    }
    ctor_names.push(ctor)
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

///|
fn emit_client_file(
  services : Array[@typespec.HttpService],
  type_ctx : EncodeTypeContext,
) -> String raise {
  let top_levels = Array::new()
  for service in services {
    let grouped_ops : Map[String, Array[@typespec.HttpOperation]] = Map::new()
    let client_order = Array::new()
    for op in service.operations() {
      let client_name = resolve_client_name_for_operation(service, op)
      if !grouped_ops.contains(client_name) {
        grouped_ops.set(client_name, [])
        client_order.push(client_name)
      }
      grouped_ops.get(client_name).unwrap().push(op)
    }
    for client_name in client_order {
      let ops = grouped_ops.get(client_name).unwrap()
      top_levels.push(emit_client_struct(client_name))
      top_levels.push(emit_client_new(client_name))
      let used_method_names : Map[String, Int] = Map::new()
      for op in ops {
        let base_name = if should_use_operation_name_for_method(ops, op) {
          make_method_name_from_operation_name(op.name())
        } else {
          make_method_name(op.verb(), op.path(), op.name())
        }
        let next_idx = used_method_names.get(base_name).unwrap_or(0) + 1
        used_method_names.set(base_name, next_idx)
        let fn_name = if next_idx == 1 {
          base_name
        } else {
          "\{base_name}_\{next_idx.to_string()}"
        }
        let method_result = emit_client_method(
          type_ctx, client_name, fn_name, op,
        )
        top_levels.push(method_result.generated_method)
        match method_result.result_enum {
          Some(result_enum) => top_levels.push(result_enum)
          None => ()
        }
      }
    }
  }
  @mbtgen.render({ package_name: None, imports: [], top_levels })
}

///|
fn resolve_client_name_for_operation(
  service : @typespec.HttpService,
  op : @typespec.HttpOperation,
) -> String {
  let service_name = service.namespace_()
  let container_name = op.container_name()
  if container_name == "" || container_name == service_name {
    make_client_type_name(service_name)
  } else {
    make_client_type_name(container_name)
  }
}

///|
fn operation_has_literal_header(op : @typespec.HttpOperation) -> Bool {
  for p in op.parameters() {
    match p.kind() {
      @typespec.HttpParamKind::Header =>
        if p.string_literal() is Some(_) {
          return true
        }
      _ => ()
    }
  }
  false
}

///|
fn should_use_operation_name_for_method(
  ops : Array[@typespec.HttpOperation],
  op : @typespec.HttpOperation,
) -> Bool {
  if !operation_has_literal_header(op) {
    return false
  }
  let verb = op.verb()
  let path = op.path()
  let mut same_route_count = 0
  for other in ops {
    if other.verb() == verb && other.path() == path {
      same_route_count += 1
      if same_route_count > 1 {
        return true
      }
    }
  }
  false
}

///|
fn emit_client_struct(client_name : String) -> @mbtgen.TopLevel {
  @mbtgen.TopLevel::Struct(
    client_name,
    [
      (
        {
          name: "base_url",
          type_: @mbtgen.Type::String,
          is_optional: false,
          doc: None,
          json_name: None,
        } : @mbtgen.Field),
    ],
    [],
    Some("\{client_name} HTTP 客户端。"),
  )
}

///|
fn emit_client_new(client_name : String) -> @mbtgen.TopLevel {
  let body = [@mbtgen.Stmt::Raw("{ base_url, }")]
  @mbtgen.TopLevel::Function({
    name: "\{client_name}::new",
    params: [
      (
        { name: "base_url", type_: @mbtgen.Type::String, is_optional: None } :
        @mbtgen.Param),
    ],
    return_type: @mbtgen.Type::Named(client_name),
    body,
    is_async: false,
    is_pub: true,
    can_raise: false,
    doc: Some("创建 \{client_name}。"),
  })
}

///|
priv struct MethodEmitResult {
  generated_method : @mbtgen.TopLevel
  result_enum : @mbtgen.TopLevel?
}

///|
priv struct SuccessResponse {
  code : Int
  body : @typespec.TypeSpecType?
  bytes_encoding : String?
  has_json_body : Bool
}

///|
priv struct OpParam {
  name : String
  var_name : String
  location : String
  type_ : @typespec.TypeSpecType
  optional : Bool
  explode : Bool
  array_encoding : String?
  bytes_encoding : String?
  string_literal : String?
}

///|
priv struct TemplateVarInfo {
  op : String
  name : String
  explode : Bool
  param_name : String
}

///|
fn emit_client_method(
  type_ctx : EncodeTypeContext,
  client_name : String,
  fn_name : String,
  op : @typespec.HttpOperation,
) -> MethodEmitResult raise {
  let path = op.path()
  let template = parse_uri_template(path)
  let method_ctor = client_meth_ctor(op.verb())
  let success_responses = collect_success_responses(op)
  let has_multi_success = success_responses.length() > 1
  let result_type_name = make_operation_result_type_name(client_name, fn_name)
  let return_type = if has_multi_success {
    result_type_name
  } else {
    let first = success_responses[0]
    match first.body {
      Some(t) => response_type_string(type_ctx, t)
      None => "Unit"
    }
  }
  let params = collect_op_params(op)
  let kept_template_var_type : Map[String, String] = Map::new()
  let kept_template_var_kind : Map[String, String] = Map::new()
  let kept_template_var_stringify : Map[String, Bool] = Map::new()
  let kept_template_var_bytes_encoding : Map[String, String] = Map::new()
  let skipped_template_params : Map[String, Bool] = Map::new()
  let kept_template_vars = Array::new()
  for v in template.vars {
    let is_query = v.op == "?" || v.op == "&"
    let loc = if is_query { "query" } else { "path" }
    let matched_strict = find_param_by_name(params, v.name, loc)
    let matched = match matched_strict {
      Some(p) => Some(p)
      None => find_param_by_name_any_location(params, v.name)
    }
    let mut skip = false
    match matched {
      None => ()
      Some(p) =>
        if is_query {
          match p.array_encoding {
            Some("spaceDelimited") | Some("pipeDelimited") => skip = true
            _ => ()
          }
        }
    }
    if skip {
      skipped_template_params.set(v.param_name, true)
      continue
    }
    let mut kind = "string"
    let mut ty = "String"
    match matched {
      None => ()
      Some(p) =>
        match p.type_ {
          @typespec.TypeSpecType::String => {
            kind = "string"
            ty = "String"
            kept_template_var_stringify.set(v.param_name, false)
          }
          @typespec.TypeSpecType::Int => {
            kind = "string"
            ty = "Int"
            kept_template_var_stringify.set(v.param_name, true)
          }
          @typespec.TypeSpecType::Float => {
            kind = "string"
            ty = "Double"
            kept_template_var_stringify.set(v.param_name, true)
          }
          @typespec.TypeSpecType::Bool => {
            kind = "string"
            ty = "Bool"
            kept_template_var_stringify.set(v.param_name, true)
          }
          @typespec.TypeSpecType::Array(@typespec.TypeSpecType::String) => {
            kind = "array"
            ty = "Array[String]"
            kept_template_var_stringify.set(v.param_name, false)
          }
          @typespec.TypeSpecType::Array(@typespec.TypeSpecType::Bytes) => {
            kind = "array"
            ty = "Array[Bytes]"
            kept_template_var_stringify.set(v.param_name, false)
            let encoding = resolve_template_var_bytes_encoding(
              p.bytes_encoding,
              is_query,
            )
            kept_template_var_bytes_encoding.set(v.param_name, encoding)
          }
          @typespec.TypeSpecType::Array(_) => {
            kind = "array"
            ty = "Array[String]"
            kept_template_var_stringify.set(v.param_name, false)
          }
          @typespec.TypeSpecType::Bytes => {
            kind = "string"
            ty = "Bytes"
            kept_template_var_stringify.set(v.param_name, false)
            let encoding = resolve_template_var_bytes_encoding(
              p.bytes_encoding,
              is_query,
            )
            kept_template_var_bytes_encoding.set(v.param_name, encoding)
          }
          @typespec.TypeSpecType::Model(model) =>
            if model.is_record() {
              kind = "record"
              ty = "Map[String, Int]"
              kept_template_var_stringify.set(v.param_name, false)
            } else {
              kind = "string"
              ty = "String"
              kept_template_var_stringify.set(v.param_name, true)
            }
          @typespec.TypeSpecType::Record(_) => {
            kind = "record"
            ty = "Map[String, Int]"
            kept_template_var_stringify.set(v.param_name, false)
          }
          @typespec.TypeSpecType::Unknown => {
            kind = "string"
            ty = "String"
            kept_template_var_stringify.set(v.param_name, false)
          }
          _ =>
            fail(
              "unsupported uri template parameter type in client codegen: \{p.name}",
            )
        }
    }
    kept_template_vars.push(v)
    kept_template_var_type.set(v.param_name, ty)
    kept_template_var_kind.set(v.param_name, kind)
  }
  let used_vars : Map[String, Bool] = Map::new()
  for v in kept_template_vars {
    used_vars.set(v.param_name, true)
  }
  let extra_params = Array::new()
  for p in params {
    let key = sanitize_identifier(p.name.to_lower())
    if kept_template_var_type.contains(key) &&
      !skipped_template_params.contains(key) {
      continue
    }
    let base = sanitize_identifier(@case.snake_case(p.name))
    let var_name = alloc_param_var(used_vars, base)
    extra_params.push({
      name: p.name,
      var_name,
      location: p.location,
      type_: p.type_,
      optional: p.optional,
      explode: p.explode,
      array_encoding: p.array_encoding,
      bytes_encoding: p.bytes_encoding,
      string_literal: p.string_literal,
    })
  }
  let fn_params = Array::new()
  let self_param : @mbtgen.Param = {
    name: "self",
    type_: @mbtgen.Type::Named(client_name),
    is_optional: None,
  }
  fn_params.push(self_param)
  for v in kept_template_vars {
    let ty = kept_template_var_type.get(v.param_name).unwrap_or("String")
    let param : @mbtgen.Param = {
      name: v.param_name,
      type_: @mbtgen.Type::Named(ty),
      is_optional: None,
    }
    fn_params.push(param)
  }
  for p in extra_params {
    if p.location == "header" && p.string_literal is Some(_) {
      continue
    }
    let mut type_text = op_param_type_string(type_ctx, p)
    if p.optional {
      type_text = "\{type_text}?"
    }
    let param : @mbtgen.Param = {
      name: p.var_name,
      type_: @mbtgen.Type::Named(type_text),
      is_optional: None,
    }
    fn_params.push(param)
  }
  let body = build_method_body(
    type_ctx, path, template, method_ctor, kept_template_var_kind, kept_template_var_stringify,
    kept_template_var_bytes_encoding, skipped_template_params, extra_params, success_responses,
    has_multi_success, result_type_name,
  )
  let generated_method = @mbtgen.TopLevel::Function({
    name: "\{client_name}::\{fn_name}",
    params: fn_params,
    return_type: @mbtgen.Type::Named(return_type),
    body: [@mbtgen.Stmt::Raw(body)],
    is_async: true,
    is_pub: true,
    can_raise: true,
    doc: Some("调用 \{op.verb()} \{path}（自动解析响应）。"),
  })
  let result_enum = if has_multi_success {
    Some(emit_result_enum(type_ctx, result_type_name, success_responses))
  } else {
    None
  }
  { generated_method, result_enum }
}

///|
fn emit_result_enum(
  type_ctx : EncodeTypeContext,
  result_type_name : String,
  success_responses : Array[SuccessResponse],
) -> @mbtgen.TopLevel raise {
  let variants = Array::new()
  for r in success_responses {
    let ctor = status_variant_name(r.code)
    let payload = match r.body {
      Some(t) => {
        if type_spec_is_union(t) {
          fail("unsupported response body union in client codegen")
        }
        Some(@mbtgen.Type::Named(response_type_string(type_ctx, t)))
      }
      None => None
    }
    let enum_variant : @mbtgen.EnumVariant = {
      name: ctor,
      payload,
      doc: None,
      json_name: None,
    }
    variants.push(enum_variant)
  }
  @mbtgen.TopLevel::Enum(result_type_name, variants, ["Show"], None)
}

///|
fn collect_success_responses(
  op : @typespec.HttpOperation,
) -> Array[SuccessResponse] {
  let out = Array::new()
  for r in op.responses() {
    let codes = r.status_codes()
    let body = r.body_type()
    for code in codes {
      if code >= 200 && code < 400 {
        out.push({
          code,
          body,
          bytes_encoding: r.bytes_encoding(),
          has_json_body: r.has_json_content_type(),
        })
      }
    }
  }
  if out.length() > 0 {
    return dedup_success_responses(out)
  }
  let fallback_code = infer_default_status_code(op)
  let fallback_body = infer_default_response_body(op)
  [
    {
      code: fallback_code,
      body: fallback_body,
      bytes_encoding: None,
      has_json_body: true,
    },
  ]
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

///|
fn collect_op_params(op : @typespec.HttpOperation) -> Array[OpParam] {
  let out = Array::new()
  for p in op.parameters() {
    out.push({
      name: p.name(),
      var_name: "",
      location: param_kind_to_location(p.kind()),
      type_: p.type_(),
      optional: p.is_optional(),
      explode: p.explode(),
      array_encoding: p.array_encoding(),
      bytes_encoding: p.bytes_encoding(),
      string_literal: p.string_literal(),
    })
  }
  out
}

///|
fn find_param_by_name(
  params : Array[OpParam],
  name : String,
  location : String,
) -> OpParam? {
  for p in params {
    if sanitize_identifier(p.name.to_lower()) ==
      sanitize_identifier(name.to_lower()) &&
      p.location == location {
      return Some(p)
    }
  }
  None
}

///|
fn find_param_by_name_any_location(
  params : Array[OpParam],
  name : String,
) -> OpParam? {
  for p in params {
    if sanitize_identifier(p.name.to_lower()) ==
      sanitize_identifier(name.to_lower()) {
      return Some(p)
    }
  }
  None
}

///|
fn alloc_param_var(used : Map[String, Bool], base : String) -> String {
  let mut candidate = base
  let mut i = 1
  while used.contains(candidate) {
    candidate = "\{base}_\{i.to_string()}"
    i += 1
  }
  used.set(candidate, true)
  candidate
}

///|
fn build_method_body(
  type_ctx : EncodeTypeContext,
  path : String,
  template : UriTemplate,
  method_ctor : String,
  kept_template_var_kind : Map[String, String],
  kept_template_var_stringify : Map[String, Bool],
  kept_template_var_bytes_encoding : Map[String, String],
  skipped_template_params : Map[String, Bool],
  extra_params : Array[OpParam],
  success_responses : Array[SuccessResponse],
  has_multi_success : Bool,
  result_type_name : String,
) -> String raise {
  let buf = StringBuilder::new(size_hint=2048)
  wln(buf, "let client = @http.Client::new(self.base_url)")
  wln(buf, "defer client.close()")
  wln(buf, "let headers : Map[String, String] = {}")
  if template.vars.length() == 0 {
    wln(
      buf,
      "let base_path = @runtime.encode_request_target(\"\{escape_string(path)}\")",
    )
  } else {
    wln(
      buf,
      "let sb0 = StringBuilder::new(size_hint=\{(path.length() + 64).to_string()})",
    )
    let mut vi = 0
    for part in template.parts {
      if part != "" {
        wln(buf, "sb0.write_string(\"\{escape_string(part)}\")")
      } else {
        let v = template.vars[vi]
        vi += 1
        if skipped_template_params.contains(v.param_name) {
          continue
        }
        let kind = kept_template_var_kind.get(v.param_name).unwrap_or("string")
        let expand_fn = if kind == "array" {
          "@runtime.expand_array"
        } else if kind == "record" {
          "@runtime.expand_record"
        } else {
          "@runtime.expand_string"
        }
        let value = if kind == "string" &&
          kept_template_var_stringify.get(v.param_name).unwrap_or(false) {
          "\{v.param_name}.to_string()"
        } else {
          v.param_name
        }
        let value = if kept_template_var_bytes_encoding.contains(v.param_name) {
          let encoding = kept_template_var_bytes_encoding
            .get(v.param_name)
            .unwrap()
          let encoding_expr = bytes_encoding_runtime_expr(encoding)
          if kind == "array" {
            "@runtime.encode_bytes_list(\{v.param_name}, \{encoding_expr})"
          } else {
            "@runtime.encode_bytes(\{v.param_name}, \{encoding_expr})"
          }
        } else {
          value
        }
        let explode_text = if v.explode { "true" } else { "false" }
        wln(
          buf,
          "sb0.write_string(\{expand_fn}(\"\{v.op}\", \"\{v.name}\", \{explode_text}, \{value}))",
        )
      }
    }
    wln(buf, "let base_path = sb0.to_string()")
    wln(buf, "let base_path = @runtime.encode_request_target(base_path)")
  }
  wln(buf, "let sb = StringBuilder::new(size_hint=base_path.length() + 128)")
  wln(buf, "sb.write_string(base_path)")
  let mut has_query_params = false
  for p in extra_params {
    if p.location == "query" {
      has_query_params = true
      break
    }
  }
  if has_query_params {
    wln(buf, "let mut first_query = !base_path.contains(\"?\")")
  }
  for p in extra_params {
    if p.location == "header" {
      write_header_param(buf, p)
    } else if p.location == "query" {
      write_query_param(buf, p)
    }
  }
  wln(buf, "let path = sb.to_string()")
  write_request_send(buf, method_ctor, extra_params)
  wln(buf, "let response = client.end_request()")
  for r in success_responses {
    wln(buf, "if response.code == \{r.code.to_string()} {")
    match r.body {
      Some(t) =>
        match t {
          @typespec.TypeSpecType::Bytes => {
            if r.has_json_body {
              let encoding = resolve_response_bytes_encoding(r)
              let encoding_expr = bytes_encoding_runtime_expr(encoding)
              wln(buf, "  @runtime.expect_json_content_type(response)")
              wln(buf, "  let response_body = client.read_all().text()")
              wln(
                buf, "  let encoded : String = @json.from_json(@json.parse(response_body))",
              )
              wln(
                buf,
                "  let parsed = @runtime.decode_bytes(encoded, \{encoding_expr})",
              )
            } else {
              wln(buf, "  let parsed = client.read_all().binary()")
            }
            if has_multi_success {
              wln(
                buf,
                "  \{result_type_name}::\{status_variant_name(r.code)}(parsed)",
              )
            } else {
              wln(buf, "  parsed")
            }
          }
          _ => {
            wln(buf, "  @runtime.expect_json_content_type(response)")
            wln(buf, "  let response_body = client.read_all().text()")
            let tstr = type_spec_to_type_string_with_ctx(type_ctx, t)
            wln(
              buf,
              "  let parsed : \{tstr} = @json.from_json(@json.parse(response_body))",
            )
            if has_multi_success {
              wln(
                buf,
                "  \{result_type_name}::\{status_variant_name(r.code)}(parsed)",
              )
            } else {
              wln(buf, "  parsed")
            }
          }
        }
      None =>
        if has_multi_success {
          wln(buf, "  \{result_type_name}::\{status_variant_name(r.code)}")
        } else {
          wln(buf, "  ()")
        }
    }
    wln(buf, "} else")
  }
  wln(buf, "{")
  wln(buf, "  fail(\"unexpected status code: \" + response.code.to_string())")
  wln(buf, "}")
  buf.to_string()
}

///|
fn write_header_param(buf : StringBuilder, p : OpParam) -> Unit raise {
  let header_key = escape_string(p.name)
  match p.string_literal {
    Some(value) => {
      wln(buf, "headers.set(\"\{header_key}\", \"\{escape_string(value)}\")")
      return
    }
    None => ()
  }
  if p.optional {
    wln(buf, "if \{p.var_name} is Some(v) {")
    match p.type_ {
      @typespec.TypeSpecType::Bytes => {
        let encoding = resolve_param_bytes_encoding(p, "base64")
        let encoding_expr = bytes_encoding_runtime_expr(encoding)
        wln(
          buf,
          "  headers.set(\"\{header_key}\", @runtime.encode_bytes(v, \{encoding_expr}))",
        )
      }
      @typespec.TypeSpecType::Array(@typespec.TypeSpecType::Bytes) => {
        let encoding = resolve_param_bytes_encoding(p, "base64")
        let encoding_expr = bytes_encoding_runtime_expr(encoding)
        wln(
          buf,
          "  headers.set(\"\{header_key}\", @runtime.encode_bytes_array(v, \{encoding_expr}, \",\"))",
        )
      }
      @typespec.TypeSpecType::Array(@typespec.TypeSpecType::String)
      | @typespec.TypeSpecType::Array(_) =>
        wln(buf, "  headers.set(\"\{header_key}\", @runtime.join(v, \",\"))")
      @typespec.TypeSpecType::String | @typespec.TypeSpecType::Unknown =>
        wln(buf, "  headers.set(\"\{header_key}\", v)")
      @typespec.TypeSpecType::Int
      | @typespec.TypeSpecType::Float
      | @typespec.TypeSpecType::Bool =>
        wln(buf, "  headers.set(\"\{header_key}\", v.to_string())")
      _ =>
        fail("unsupported header parameter type in client codegen: \{p.name}")
    }
    wln(buf, "}")
  } else {
    match p.type_ {
      @typespec.TypeSpecType::Bytes => {
        let encoding = resolve_param_bytes_encoding(p, "base64")
        let encoding_expr = bytes_encoding_runtime_expr(encoding)
        wln(
          buf,
          "headers.set(\"\{header_key}\", @runtime.encode_bytes(\{p.var_name}, \{encoding_expr}))",
        )
      }
      @typespec.TypeSpecType::Array(@typespec.TypeSpecType::Bytes) => {
        let encoding = resolve_param_bytes_encoding(p, "base64")
        let encoding_expr = bytes_encoding_runtime_expr(encoding)
        wln(
          buf,
          "headers.set(\"\{header_key}\", @runtime.encode_bytes_array(\{p.var_name}, \{encoding_expr}, \",\"))",
        )
      }
      @typespec.TypeSpecType::Array(@typespec.TypeSpecType::String)
      | @typespec.TypeSpecType::Array(_) =>
        wln(
          buf,
          "headers.set(\"\{header_key}\", @runtime.join(\{p.var_name}, \",\"))",
        )
      @typespec.TypeSpecType::String | @typespec.TypeSpecType::Unknown =>
        wln(buf, "headers.set(\"\{header_key}\", \{p.var_name})")
      @typespec.TypeSpecType::Int
      | @typespec.TypeSpecType::Float
      | @typespec.TypeSpecType::Bool =>
        wln(buf, "headers.set(\"\{header_key}\", \{p.var_name}.to_string())")
      _ =>
        fail("unsupported header parameter type in client codegen: \{p.name}")
    }
  }
}

///|
fn write_query_pair(
  buf : StringBuilder,
  key : String,
  value_expr : String,
) -> Unit {
  wln(buf, "if first_query {")
  wln(buf, "  sb.write_char('?')")
  wln(buf, "  first_query = false")
  wln(buf, "} else {")
  wln(buf, "  sb.write_char('&')")
  wln(buf, "}")
  wln(buf, "sb.write_string(\"\{key}=\")")
  wln(buf, "sb.write_string(@runtime.encode_query_component(\{value_expr}))")
}

///|
fn write_query_param(buf : StringBuilder, p : OpParam) -> Unit raise {
  let query_key = escape_string(p.name)
  let delimiter = match p.array_encoding {
    Some("spaceDelimited") => " "
    Some("pipeDelimited") => "|"
    _ => ","
  }
  if p.optional {
    wln(buf, "if \{p.var_name} is Some(v) {")
    match p.type_ {
      @typespec.TypeSpecType::Bytes => {
        let bytes_encoding = resolve_param_bytes_encoding(p, "base64url")
        let encoding_expr = bytes_encoding_runtime_expr(bytes_encoding)
        write_query_pair(
          buf,
          query_key,
          "@runtime.encode_bytes(v, \{encoding_expr})",
        )
      }
      @typespec.TypeSpecType::Array(@typespec.TypeSpecType::Bytes) => {
        let bytes_encoding = resolve_param_bytes_encoding(p, "base64url")
        let encoding_expr = bytes_encoding_runtime_expr(bytes_encoding)
        if p.explode {
          wln(buf, "  for x in v {")
          write_query_pair(
            buf,
            query_key,
            "@runtime.encode_bytes(x, \{encoding_expr})",
          )
          wln(buf, "  }")
        } else {
          write_query_pair(
            buf,
            query_key,
            "@runtime.encode_bytes_array(v, \{encoding_expr}, \"\{delimiter}\")",
          )
        }
      }
      @typespec.TypeSpecType::Array(@typespec.TypeSpecType::String)
      | @typespec.TypeSpecType::Array(_) =>
        if p.explode {
          wln(buf, "  for x in v {")
          write_query_pair(buf, query_key, "x")
          wln(buf, "  }")
        } else {
          write_query_pair(buf, query_key, "@runtime.join(v, \"\{delimiter}\")")
        }
      @typespec.TypeSpecType::String | @typespec.TypeSpecType::Unknown =>
        write_query_pair(buf, query_key, "v")
      @typespec.TypeSpecType::Int
      | @typespec.TypeSpecType::Float
      | @typespec.TypeSpecType::Bool =>
        write_query_pair(buf, query_key, "v.to_string()")
      _ => fail("unsupported query parameter type in client codegen: \{p.name}")
    }
    wln(buf, "}")
  } else {
    match p.type_ {
      @typespec.TypeSpecType::Bytes => {
        let bytes_encoding = resolve_param_bytes_encoding(p, "base64url")
        let encoding_expr = bytes_encoding_runtime_expr(bytes_encoding)
        write_query_pair(
          buf,
          query_key,
          "@runtime.encode_bytes(\{p.var_name}, \{encoding_expr})",
        )
      }
      @typespec.TypeSpecType::Array(@typespec.TypeSpecType::Bytes) => {
        let bytes_encoding = resolve_param_bytes_encoding(p, "base64url")
        let encoding_expr = bytes_encoding_runtime_expr(bytes_encoding)
        if p.explode {
          wln(buf, "for x in \{p.var_name} {")
          write_query_pair(
            buf,
            query_key,
            "@runtime.encode_bytes(x, \{encoding_expr})",
          )
          wln(buf, "}")
        } else {
          write_query_pair(
            buf,
            query_key,
            "@runtime.encode_bytes_array(\{p.var_name}, \{encoding_expr}, \"\{delimiter}\")",
          )
        }
      }
      @typespec.TypeSpecType::Array(@typespec.TypeSpecType::String)
      | @typespec.TypeSpecType::Array(_) =>
        if p.explode {
          wln(buf, "for x in \{p.var_name} {")
          write_query_pair(buf, query_key, "x")
          wln(buf, "}")
        } else {
          write_query_pair(
            buf,
            query_key,
            "@runtime.join(\{p.var_name}, \"\{delimiter}\")",
          )
        }
      @typespec.TypeSpecType::String | @typespec.TypeSpecType::Unknown =>
        write_query_pair(buf, query_key, p.var_name)
      @typespec.TypeSpecType::Int
      | @typespec.TypeSpecType::Float
      | @typespec.TypeSpecType::Bool =>
        write_query_pair(buf, query_key, "\{p.var_name}.to_string()")
      _ => fail("unsupported query parameter type in client codegen: \{p.name}")
    }
  }
}

///|
fn resolve_param_bytes_encoding(
  p : OpParam,
  default_encoding : String,
) -> String raise {
  let raw = match p.bytes_encoding {
    Some(v) => v.to_lower()
    None => default_encoding
  }
  match raw {
    "base64" => "base64"
    "base64url" => "base64url"
    _ => fail("unsupported bytes encoding for parameter \{p.name}: \{raw}")
  }
}

///|
fn resolve_template_var_bytes_encoding(
  raw_encoding : String?,
  is_query : Bool,
) -> String raise {
  let default_encoding = if is_query { "base64url" } else { "base64url" }
  let raw = match raw_encoding {
    Some(v) => v.to_lower()
    None => default_encoding
  }
  match raw {
    "base64" => "base64"
    "base64url" => "base64url"
    _ => fail("unsupported bytes encoding for uri template variable: " + raw)
  }
}

///|
fn resolve_response_bytes_encoding(r : SuccessResponse) -> String raise {
  let raw = match r.bytes_encoding {
    Some(v) => v.to_lower()
    None => "base64"
  }
  match raw {
    "base64" => "base64"
    "base64url" => "base64url"
    _ =>
      fail(
        "unsupported bytes encoding for response status \{r.code.to_string()}: \{raw}",
      )
  }
}

///|
fn resolve_body_bytes_encoding(p : OpParam) -> String? raise {
  match p.bytes_encoding {
    None => None
    Some(v) => {
      let raw = v.to_lower()
      match raw {
        "base64" => Some("base64")
        "base64url" => Some("base64url")
        "none" => None
        _ =>
          fail(
            "unsupported bytes encoding for body parameter \{p.name}: \{raw}",
          )
      }
    }
  }
}

///|
fn write_request_send(
  buf : StringBuilder,
  method_ctor : String,
  extra_params : Array[OpParam],
) -> Unit raise {
  let mut body_param : OpParam? = None
  let mut has_content_type_header_param = false
  for p in extra_params {
    if p.location == "body" {
      body_param = Some(p)
    } else if p.location == "header" && p.name.to_lower() == "content-type" {
      has_content_type_header_param = true
    }
  }
  match body_param {
    None =>
      wln(buf, "client.request(\{method_ctor}, path, extra_headers=headers)")
    Some(p) =>
      if p.optional {
        wln(buf, "if \{p.var_name} is Some(body) {")
        match p.type_ {
          @typespec.TypeSpecType::Bytes => {
            let bytes_encoding = resolve_body_bytes_encoding(p)
            match bytes_encoding {
              Some(encoding) => {
                let encoding_expr = bytes_encoding_runtime_expr(encoding)
                wln(
                  buf,
                  "  client.request(\{method_ctor}, path, extra_headers=headers)",
                )
                wln(
                  buf,
                  "  let encoded = try! @runtime.encode_bytes(body, \{encoding_expr})",
                )
                wln(buf, "  client.write(encoded.to_json())")
              }
              None => {
                if !has_content_type_header_param {
                  wln(
                    buf, "  headers.set(\"Content-Type\", \"application/octet-stream\")",
                  )
                }
                wln(
                  buf,
                  "  client.request(\{method_ctor}, path, extra_headers=headers)",
                )
                wln(buf, "  client.write(body)")
              }
            }
          }
          _ => {
            wln(buf, "  headers.set(\"content-type\", \"application/json\")")
            wln(
              buf,
              "  client.request(\{method_ctor}, path, extra_headers=headers)",
            )
            wln(buf, "  client.write(body.to_json())")
          }
        }
        wln(buf, "} else {")
        wln(
          buf,
          "  client.request(\{method_ctor}, path, extra_headers=headers)",
        )
        wln(buf, "}")
      } else {
        match p.type_ {
          @typespec.TypeSpecType::Bytes => {
            let bytes_encoding = resolve_body_bytes_encoding(p)
            match bytes_encoding {
              Some(encoding) => {
                let encoding_expr = bytes_encoding_runtime_expr(encoding)
                wln(
                  buf,
                  "client.request(\{method_ctor}, path, extra_headers=headers)",
                )
                wln(
                  buf,
                  "let encoded = try! @runtime.encode_bytes(\{p.var_name}, \{encoding_expr})",
                )
                wln(buf, "client.write(encoded.to_json())")
              }
              None => {
                if !has_content_type_header_param {
                  wln(
                    buf, "headers.set(\"Content-Type\", \"application/octet-stream\")",
                  )
                }
                wln(
                  buf,
                  "client.request(\{method_ctor}, path, extra_headers=headers)",
                )
                wln(buf, "client.write(\{p.var_name})")
              }
            }
          }
          _ => {
            wln(buf, "headers.set(\"content-type\", \"application/json\")")
            wln(
              buf,
              "client.request(\{method_ctor}, path, extra_headers=headers)",
            )
            wln(buf, "client.write(\{p.var_name}.to_json())")
          }
        }
      }
  }
}

///|
fn op_param_type_string(
  type_ctx : EncodeTypeContext,
  p : OpParam,
) -> String raise {
  match p.type_ {
    @typespec.TypeSpecType::Bytes => "Bytes"
    @typespec.TypeSpecType::Array(@typespec.TypeSpecType::Bytes) =>
      "Array[Bytes]"
    _ => type_spec_to_type_string_with_ctx(type_ctx, p.type_)
  }
}

///|
fn response_type_string(
  type_ctx : EncodeTypeContext,
  t : @typespec.TypeSpecType,
) -> String raise {
  match t {
    @typespec.TypeSpecType::Bytes => "Bytes"
    _ => type_spec_to_type_string_with_ctx(type_ctx, t)
  }
}

///|
fn type_spec_to_type_string_with_ctx(
  type_ctx : EncodeTypeContext,
  type_ : @typespec.TypeSpecType,
) -> String raise {
  match type_ {
    @typespec.TypeSpecType::String => "String"
    @typespec.TypeSpecType::Bytes => "String"
    @typespec.TypeSpecType::Int => "Int"
    @typespec.TypeSpecType::Int64 => "Int64"
    @typespec.TypeSpecType::Bool => "Bool"
    @typespec.TypeSpecType::Float => "Double"
    @typespec.TypeSpecType::Json => "Json"
    @typespec.TypeSpecType::Model(model) => {
      let id = model.identity()
      if type_ctx.model_names.contains(id) {
        type_ctx.model_names.get(id).unwrap()
      } else {
        let name = model.name()
        if name.length() == 0 {
          "Json"
        } else {
          @case.pascal_case(name)
        }
      }
    }
    @typespec.TypeSpecType::Record(value_type) =>
      "Map[String, \{type_spec_to_type_string_with_ctx(type_ctx, value_type)}]"
    @typespec.TypeSpecType::Nullable(inner) =>
      "@runtime.Nullable[\{type_spec_to_type_string_with_ctx(type_ctx, inner)}]"
    @typespec.TypeSpecType::Union(union) => {
      let id = union.identity()
      if type_ctx.union_names.contains(id) {
        type_ctx.union_names.get(id).unwrap()
      } else {
        let name = union.name()
        if name.length() == 0 {
          "Json"
        } else {
          @case.pascal_case(name)
        }
      }
    }
    @typespec.TypeSpecType::Array(item) =>
      "Array[\{type_spec_to_type_string_with_ctx(type_ctx, item)}]"
    @typespec.TypeSpecType::Unknown => "Json"
  }
}

///|
fn type_spec_is_union(type_ : @typespec.TypeSpecType) -> Bool {
  match type_ {
    @typespec.TypeSpecType::Union(_) => true
    _ => false
  }
}

///|
fn make_client_type_name(raw : String) -> String {
  let cleaned = sanitize_identifier(raw)
  let base0 = @case.pascal_case(cleaned)
  let base = if base0 == "" { "Client" } else { base0 }
  if base.has_suffix("Client") {
    base
  } else {
    base + "Client"
  }
}

///|
fn make_method_name(
  http_method : String,
  path : String,
  raw_name : String,
) -> String {
  let prefix = sanitize_identifier(http_method.to_lower())
  let path_part = trim_leading_underscores(sanitize_identifier(path.to_lower()))
  let name_part = sanitize_identifier(raw_name.to_lower())
  let base = if path_part.length() > 0 {
    path_part
  } else if name_part.length() > 0 {
    name_part
  } else {
    "call"
  }
  prefix + "_" + base
}

///|
fn make_method_name_from_operation_name(raw_name : String) -> String {
  let name_part = trim_leading_underscores(
    sanitize_identifier(@case.snake_case(raw_name)),
  )
  if name_part.length() > 0 {
    name_part
  } else {
    "call"
  }
}

///|
fn make_operation_result_type_name(
  client_name : String,
  fn_name : String,
) -> String {
  @case.pascal_case(client_name + "_" + fn_name + "_result")
}

///|
fn status_variant_name(code : Int) -> String {
  "Status\{code.to_string()}"
}

///|
fn client_meth_ctor(http_method : String) -> String raise {
  match http_method.to_upper() {
    "GET" => "@http.Get"
    "HEAD" => "@http.Head"
    "POST" => "@http.Post"
    "PUT" => "@http.Put"
    "DELETE" => "@http.Delete"
    "PATCH" => "@http.Patch"
    "OPTIONS" => "@http.Options"
    "TRACE" => "@http.Trace"
    "CONNECT" => "@http.Connect"
    _ => fail("unsupported http method: \{http_method}")
  }
}

///|
fn param_kind_to_location(kind : @typespec.HttpParamKind) -> String {
  match kind {
    @typespec.HttpParamKind::Query => "query"
    @typespec.HttpParamKind::Header => "header"
    @typespec.HttpParamKind::Path => "path"
    @typespec.HttpParamKind::Body => "body"
    @typespec.HttpParamKind::Unknown(name) => name
  }
}

///|
fn wln(sb : StringBuilder, s : String) -> Unit {
  sb.write_string(s)
  sb.write_char('\n')
}

///|
fn escape_string(s : String) -> String {
  s.replace_all(old="\\", new="\\\\").replace_all(old="\"", new="\\\"")
}

///|
pub fn sanitize_identifier(s : String) -> String {
  let sb = StringBuilder::new()
  let mut first = true
  for c in s.to_array() {
    if (c >= 'a' && c <= 'z') ||
      (c >= 'A' && c <= 'Z') ||
      (c >= '0' && c <= '9') ||
      c == '_' {
      if first && c >= '0' && c <= '9' {
        sb.write_char('_')
      }
      sb.write_char(c)
      first = false
    } else {
      sb.write_char('_')
      first = false
    }
  }
  let res = sb.to_string()
  let normalized = if res == "" { "_" } else { res }
  if is_reserved_identifier(normalized) {
    normalized + "_"
  } else {
    normalized
  }
}

///|
fn is_reserved_identifier(s : String) -> Bool {
  match s {
    "and"
    | "as"
    | "assert"
    | "async"
    | "await"
    | "break"
    | "class"
    | "const"
    | "constructor"
    | "continue"
    | "def"
    | "defer"
    | "del"
    | "elif"
    | "else"
    | "except"
    | "exec"
    | "false"
    | "finally"
    | "fn"
    | "for"
    | "from"
    | "global"
    | "if"
    | "import"
    | "in"
    | "is"
    | "lambda"
    | "let"
    | "match"
    | "mut"
    | "not"
    | "or"
    | "pass"
    | "pub"
    | "raise"
    | "return"
    | "self"
    | "struct"
    | "test"
    | "trait"
    | "true"
    | "try"
    | "type"
    | "using"
    | "while"
    | "with"
    | "yield" => true
    _ => false
  }
}

///|
priv struct UriTemplate {
  parts : Array[String]
  vars : Array[TemplateVarInfo]
}

///|
fn parse_uri_template(path : String) -> UriTemplate {
  let parts = Array::new()
  let vars = Array::new()
  let chars = path.to_array()
  let mut i = 0
  while i < chars.length() {
    match find_char(chars, '{', i) {
      None => {
        parts.push(chars_to_string(chars, i, chars.length()))
        break
      }
      Some(open_idx) => {
        parts.push(chars_to_string(chars, i, open_idx))
        match find_char(chars, '}', open_idx + 1) {
          None => {
            parts.push(chars_to_string(chars, open_idx, chars.length()))
            break
          }
          Some(close_idx) => {
            let inner = chars_to_string(chars, open_idx + 1, close_idx)
            let (op, rest) = parse_uri_template_operator(inner)
            let (name, explode) = parse_uri_template_varspec(rest)
            if name.length() > 0 {
              let param_name = sanitize_identifier(name.to_lower())
              vars.push({ op, name, explode, param_name })
              parts.push("")
            } else {
              parts.push("{" + inner + "}")
            }
            i = close_idx + 1
          }
        }
      }
    }
  }
  { parts, vars }
}

///|
fn parse_uri_template_operator(inner : String) -> (String, String) {
  let chars = inner.to_array()
  if chars.length() == 0 {
    ("", "")
  } else {
    let first = chars[0]
    match first {
      '+' | '/' | '.' | ';' | '?' | '&' =>
        (first.to_string(), chars_to_string(chars, 1, chars.length()))
      _ => ("", inner)
    }
  }
}

///|
fn parse_uri_template_varspec(rest : String) -> (String, Bool) {
  let trimmed = rest.trim()
  let chars = trimmed.to_array()
  if chars.length() == 0 {
    ("", false)
  } else {
    let mut explode = false
    let mut end = chars.length()
    if chars[chars.length() - 1] == '*' {
      explode = true
      end -= 1
    }
    let comma = find_char(chars, ',', 0).unwrap_or(end)
    let final_end = if comma < end { comma } else { end }
    (chars_to_string(chars, 0, final_end), explode)
  }
}

///|
fn find_char(chars : Array[Char], target : Char, from : Int) -> Int? {
  for i in from..<chars.length() {
    if chars[i] == target {
      return Some(i)
    }
  }
  None
}

///|
fn chars_to_string(chars : Array[Char], start : Int, end : Int) -> String {
  let sb = StringBuilder::new(size_hint=end - start)
  for i in start..<end {
    sb.write_char(chars[i])
  }
  sb.to_string()
}

///|
fn trim_leading_underscores(raw : String) -> String {
  let chars = raw.to_array()
  let mut start = 0
  for ch in chars {
    if ch != '_' {
      break
    }
    start += 1
  }
  if start == 0 {
    raw
  } else if start >= chars.length() {
    ""
  } else {
    let sb = StringBuilder::new(size_hint=chars.length() - start)
    for i in start..<chars.length() {
      sb.write_char(chars[i])
    }
    sb.to_string()
  }
}
