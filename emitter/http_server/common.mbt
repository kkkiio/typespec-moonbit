///|
fn wln(sb : StringBuilder, s : String) -> Unit {
  sb.write_string(s)
  sb.write_char('\n')
}

///|
fn write_escaped_string_literal(sb : StringBuilder, s : String) -> Unit {
  let n = s.length()
  let mut i = 0
  while i < n {
    let ch = s.code_unit_at(i)
    if ch == '\\' {
      sb.write_string("\\\\")
    } else if ch == '"' {
      sb.write_string("\\\"")
    } else {
      sb.write_char(ch.to_int().unsafe_to_char())
    }
    i += 1
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
fn join_strings(xs : Array[String], sep : String) -> String {
  let sb = StringBuilder::new()
  for i in 0..<xs.length() {
    if i > 0 {
      sb.write_string(sep)
    }
    sb.write_string(xs[i])
  }
  sb.to_string()
}

///|
pub fn sanitize_identifier(s : String) -> String {
  @mbtgen.sanitize_identifier(s)
}

///|
fn compact_alpha_digit_underscore(s : String) -> String {
  let n = s.length()
  let sb = StringBuilder::new(size_hint=n)
  let mut i = 0
  while i < n {
    let ch = s.code_unit_at(i)
    if ch == '_' && i > 0 && i + 1 < n {
      let prev = s.code_unit_at(i - 1)
      let next = s.code_unit_at(i + 1)
      let prev_is_lower = prev >= 'a' && prev <= 'z'
      let next_is_digit = next >= '0' && next <= '9'
      if prev_is_lower && next_is_digit {
        i += 1
        continue
      }
    }
    sb.write_char(ch.to_int().unsafe_to_char())
    i += 1
  }
  sb.to_string()
}

///|
fn type_spec_to_type_string_with_ctx(
  type_ctx : EncodeTypeContext,
  type_ : @typespec.TypeSpecType,
) -> String raise {
  match type_ {
    @typespec.TypeSpecType::String => "String"
    @typespec.TypeSpecType::Duration => "@runtime.Duration"
    @typespec.TypeSpecType::UtcDateTime => "@runtime.UtcDateTime"
    @typespec.TypeSpecType::OffsetDateTime => "@runtime.OffsetDateTime"
    @typespec.TypeSpecType::PlainDate => "@runtime.PlainDate"
    @typespec.TypeSpecType::PlainTime => "@runtime.PlainTime"
    @typespec.TypeSpecType::Bytes =>
      fail("unsupported bytes type in server codegen")
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
    @typespec.TypeSpecType::Union(union) =>
      union_to_type_string_with_ctx(type_ctx, union)
    @typespec.TypeSpecType::Array(item) =>
      "Array[\{type_spec_to_type_string_with_ctx(type_ctx, item)}]"
    @typespec.TypeSpecType::Unknown => "Json"
  }
}

///|
fn union_to_type_string_with_ctx(
  type_ctx : EncodeTypeContext,
  union : @typespec.Union,
) -> String {
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

///|
fn status_variant_name(code : Int) -> String {
  "Status\{code.to_string()}"
}

///|
fn status_reason_phrase(code : Int) -> String {
  if code == 200 {
    "OK"
  } else if code == 201 {
    "Created"
  } else if code == 202 {
    "Accepted"
  } else if code == 204 {
    "No Content"
  } else if code == 400 {
    "Bad Request"
  } else if code == 401 {
    "Unauthorized"
  } else if code == 403 {
    "Forbidden"
  } else if code == 404 {
    "Not Found"
  } else if code == 405 {
    "Method Not Allowed"
  } else if code == 409 {
    "Conflict"
  } else if code == 500 {
    "Internal Server Error"
  } else {
    "OK"
  }
}

///|
fn normalize_uri_template(template : String) -> String {
  let p1 = template.split("{?").to_array()
  let s = if p1.length() == 0 { template } else { p1[0].to_string() }
  let p2 = s.split("?").to_array()
  if p2.length() == 0 {
    s
  } else {
    p2[0].to_string()
  }
}

///|
fn server_meth_ctor(http_method : String) -> String raise {
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
