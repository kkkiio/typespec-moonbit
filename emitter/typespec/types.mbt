///|
pub enum TypeSpecType {
  Model(Model)
  Union(Union)
  String
  Duration
  UtcDateTime
  OffsetDateTime
  PlainDate
  PlainTime
  Bytes
  Int
  Int64
  Bool
  Float
  Json
  Array(TypeSpecType)
  Record(TypeSpecType)
  Nullable(TypeSpecType)
  Unknown
}

///|
pub struct Model {
  raw : JsValue
}

///|
pub struct Property {
  raw : JsValue
  name_hint : String
  json_name_hint : String
}

///|
pub struct Union {
  raw : JsValue
}

///|
pub fn Model::identity(self : Model) -> String {
  get_js_identity(self.raw)
}

///|
pub fn Model::anon_name_prefix(self : Model) -> String? {
  derive_anon_model_name_prefix(self.raw)
}

///|
pub fn Union::identity(self : Union) -> String {
  get_js_identity(self.raw)
}

///|
pub struct UnionVariant {
  raw : JsValue
}

///|
pub fn Model::name(self : Model) -> String {
  read_name(self.raw)
}

///|
pub fn Model::properties(self : Model) -> Iter[Property] {
  let entries = get_model_properties_with_base_as_array(self.raw)
  let out = Array::new(capacity=entries.length())
  for entry in entries {
    let name_val = get(entry, "name")
    let json_name_val = get(entry, "json_name")
    let prop_val = get(entry, "prop")
    let name_hint = if is_string(name_val) { cast_string(name_val) } else { "" }
    let json_name_hint = if is_string(json_name_val) {
      cast_string(json_name_val)
    } else {
      ""
    }
    out.push({ raw: prop_val, name_hint, json_name_hint })
  }
  out.iter()
}

///|
pub fn Model::doc(self : Model) -> String {
  let doc_val = get(self.raw, "doc")
  if is_string(doc_val) {
    cast_string(doc_val)
  } else {
    ""
  }
}

///|
pub fn Model::is_record(self : Model) -> Bool {
  let indexer_val = get(self.raw, "indexer")
  if is_undefined(indexer_val) || is_null(indexer_val) {
    return false
  }
  let key_val = get(indexer_val, "key")
  if is_undefined(key_val) || is_null(key_val) {
    return false
  }
  let kind_val = get(key_val, "kind")
  let name_val = get(key_val, "name")
  is_string(kind_val) &&
  cast_string(kind_val) == "Scalar" &&
  is_string(name_val) &&
  cast_string(name_val) == "string"
}

///|
pub fn Property::name(self : Property) -> String {
  if self.name_hint != "" {
    return self.name_hint
  }
  read_name(self.raw)
}

///|
pub fn Property::json_name(self : Property) -> String? {
  if self.json_name_hint != "" {
    Some(self.json_name_hint)
  } else {
    None
  }
}

///|
pub fn Property::type_(self : Property) -> TypeSpecType {
  let type_val = get(self.raw, "type")
  resolve_type(type_val)
}

///|
pub fn Property::bytes_encoding(self : Property) -> String? {
  property_try_get_bytes_encoding(self.raw)
}

///|
pub fn Property::encoding(self : Property) -> String? {
  property_try_get_encoding(self.raw)
}

///|
pub fn Property::encoding_wire_type(self : Property) -> String? {
  property_try_get_encoding_wire_type(self.raw)
}

///|
pub fn Property::is_optional(self : Property) -> Bool {
  let opt_val = get(self.raw, "optional")
  if is_bool(opt_val) {
    cast_bool(opt_val)
  } else {
    false
  }
}

///|
pub fn Union::name(self : Union) -> String {
  read_name(self.raw)
}

///|
pub fn Union::variants(self : Union) -> Iter[UnionVariant] {
  let variants_val = get(self.raw, "variants")
  if is_undefined(variants_val) || is_null(variants_val) {
    let empty : Array[UnionVariant] = []
    return empty.iter()
  }
  let variants = get_union_variants_as_array(variants_val)
  let out = Array::new(capacity=variants.length())
  for variant in variants {
    out.push(UnionVariant::{ raw: variant })
  }
  out.iter()
}

///|
pub fn UnionVariant::name(self : UnionVariant) -> String {
  let name_val = get(self.raw, "name")
  if is_string(name_val) {
    cast_string(name_val)
  } else {
    let type_val = get(self.raw, "type")
    read_name(type_val)
  }
}

///|
pub fn UnionVariant::type_(self : UnionVariant) -> TypeSpecType {
  resolve_type(get(self.raw, "type"))
}

///|
pub fn resolve_type(type_ : JsValue) -> TypeSpecType {
  resolve_type_inner(type_, 0)
}

///|
fn resolve_type_inner(type_ : JsValue, depth : Int) -> TypeSpecType {
  if depth >= 32 || is_undefined(type_) || is_null(type_) {
    return Unknown
  }
  let kind_val = get(type_, "kind")
  if is_string(kind_val) {
    let kind = cast_string(kind_val)
    if kind == "Model" {
      let indexer_val = get(type_, "indexer")
      if !(is_undefined(indexer_val) || is_null(indexer_val)) {
        let key_val = get(indexer_val, "key")
        let key_kind_val = get(key_val, "kind")
        let key_name_val = get(key_val, "name")
        if is_string(key_kind_val) &&
          cast_string(key_kind_val) == "Scalar" &&
          is_string(key_name_val) {
          let key_name = cast_string(key_name_val)
          let value_val = get(indexer_val, "value")
          let value_type = pick_type_node(value_val)
          if !(is_undefined(value_type) || is_null(value_type)) {
            if key_name == "integer" ||
              key_name == "int32" ||
              key_name == "int16" ||
              key_name == "int8" {
              return Array(resolve_type_inner(value_type, depth + 1))
            }
            if key_name == "string" {
              return Record(resolve_type_inner(value_type, depth + 1))
            }
          }
        }
      }
      return Model({ raw: type_ })
    }
    if kind == "Union" {
      let variants_val = get(type_, "variants")
      if !(is_undefined(variants_val) || is_null(variants_val)) {
        let variants = get_union_variants_as_array(variants_val)
        let mut saw_null = false
        let non_null_types = Array::new()
        for v in variants {
          let t = get(v, "type")
          if is_undefined(t) || is_null(t) {
            continue
          }
          let tk = get(t, "kind")
          if is_string(tk) && cast_string(tk) == "Intrinsic" {
            let tn = get(t, "name")
            if is_string(tn) && cast_string(tn) == "null" {
              saw_null = true
              continue
            }
          }
          non_null_types.push(t)
        }
        if saw_null && non_null_types.length() == 1 {
          return Nullable(resolve_type_inner(non_null_types[0], depth + 1))
        }
        if non_null_types.length() > 0 {
          let first = resolve_type_inner(non_null_types[0], depth + 1)
          if is_collapsible_primitive(first) {
            let mut all_same = true
            for i in 1..<non_null_types.length() {
              let t = resolve_type_inner(non_null_types[i], depth + 1)
              if !same_primitive_kind(first, t) {
                all_same = false
                break
              }
            }
            if all_same {
              return first
            }
          }
        }
      }
      return Union({ raw: type_ })
    }
    if kind == "String" {
      return String
    }
    if kind == "Number" {
      return Float
    }
    if kind == "Boolean" {
      return Bool
    }
    if kind == "Scalar" {
      let name_val = get(type_, "name")
      if is_string(name_val) {
        let name = cast_string(name_val)
        if name == "string" {
          return String
        }
        if name == "duration" {
          return Duration
        }
        if name == "utcDateTime" {
          return UtcDateTime
        }
        if name == "offsetDateTime" {
          return OffsetDateTime
        }
        if name == "plainDate" {
          return PlainDate
        }
        if name == "plainTime" {
          return PlainTime
        }
        if name == "url" {
          return String
        }
        if name == "boolean" {
          return Bool
        }
        if name == "bytes" {
          return Bytes
        }
        if name == "integer" ||
          name == "int32" ||
          name == "int16" ||
          name == "int8" {
          return Int
        }
        if name == "int64" {
          return Int64
        }
        if name == "float64" ||
          name == "float32" ||
          name == "decimal" ||
          name == "decimal128" {
          return Float
        }
        if is_bytes_scalar_like(type_) {
          return Bytes
        }
        if is_duration_scalar_like(type_) {
          return Duration
        }
        if is_utc_datetime_scalar_like(type_) {
          return UtcDateTime
        }
        if is_offset_datetime_scalar_like(type_) {
          return OffsetDateTime
        }
        if is_plain_date_scalar_like(type_) {
          return PlainDate
        }
        if is_plain_time_scalar_like(type_) {
          return PlainTime
        }
        if is_string_scalar_like(type_) {
          return String
        }
      }
    }
    if kind == "Intrinsic" {
      let name_val = get(type_, "name")
      if is_string(name_val) {
        let name = cast_string(name_val)
        if name == "unknown" {
          return Json
        }
        if name == "null" {
          return Nullable(Unknown)
        }
        if name == "string" {
          return String
        }
        if name == "boolean" {
          return Bool
        }
      }
    }
  }
  let nested = get(type_, "type")
  if !(is_undefined(nested) || is_null(nested)) {
    return resolve_type_inner(nested, depth + 1)
  }
  Unknown
}

///|
fn is_collapsible_primitive(type_ : TypeSpecType) -> Bool {
  match type_ {
    String | Int | Int64 | Float | Bool | Json => true
    _ => false
  }
}

///|
fn same_primitive_kind(a : TypeSpecType, b : TypeSpecType) -> Bool {
  match (a, b) {
    (String, String) => true
    (Int, Int) => true
    (Int64, Int64) => true
    (Float, Float) => true
    (Bool, Bool) => true
    (Json, Json) => true
    _ => false
  }
}

///|
fn pick_type_node(value : JsValue) -> JsValue {
  let kind_val = get(value, "kind")
  if is_string(kind_val) {
    return value
  }
  get(value, "type")
}

///|
fn property_try_get_bytes_encoding(p : JsValue) -> String? {
  property_try_get_bytes_encoding_ffi(p)
}

///|
fn property_try_get_encoding(p : JsValue) -> String? {
  property_try_get_encoding_ffi(p)
}

///|
fn property_try_get_encoding_wire_type(p : JsValue) -> String? {
  property_try_get_encoding_wire_type_ffi(p)
}

///|
extern "js" fn property_try_get_bytes_encoding_ffi(p : JsValue) -> String? =
  #| (p) => {
  #|   const decs = p?.decorators;
  #|   if (!Array.isArray(decs)) return undefined;
  #|   const enc = decs.find((d) => d?.decorator?.name === "$encode");
  #|   const v = enc?.args?.[0]?.value;
  #|   const member = v?.value?.symbol?.name ?? v?.value?.name ?? v?.value?.enumMember?.name;
  #|   return typeof member === "string" ? member : undefined;
  #| }

///|
extern "js" fn property_try_get_encoding_ffi(p : JsValue) -> String? =
  #| (p) => {
  #|   const read = (node) => {
  #|     const decs = node?.decorators;
  #|     if (!Array.isArray(decs)) return undefined;
  #|     const enc = decs.find((d) => d?.decorator?.name === "$encode");
  #|     const v = enc?.args?.[0]?.value;
  #|     const member = v?.value?.symbol?.name ?? v?.value?.name ?? v?.value?.enumMember?.name;
  #|     return typeof member === "string" ? member : undefined;
  #|   };
  #|   const direct = read(p);
  #|   if (typeof direct === "string") return direct;
  #|   let cur = p?.type;
  #|   let steps = 0;
  #|   while (cur && steps < 32) {
  #|     const got = read(cur);
  #|     if (typeof got === "string") return got;
  #|     cur = cur.baseScalar;
  #|     steps++;
  #|   }
  #|   return undefined;
  #| }

///|
extern "js" fn property_try_get_encoding_wire_type_ffi(p : JsValue) -> String? =
  #| (p) => {
  #|   const read = (node) => {
  #|     const decs = node?.decorators;
  #|     if (!Array.isArray(decs)) return undefined;
  #|     const enc = decs.find((d) => d?.decorator?.name === "$encode");
  #|     const arg = enc?.args?.[1]?.value;
  #|     const name = arg?.name ?? arg?.value?.name ?? arg?.scalar?.name;
  #|     return typeof name === "string" ? name : undefined;
  #|   };
  #|   const direct = read(p);
  #|   if (typeof direct === "string") return direct;
  #|   let cur = p?.type;
  #|   let steps = 0;
  #|   while (cur && steps < 32) {
  #|     const got = read(cur);
  #|     if (typeof got === "string") return got;
  #|     cur = cur.baseScalar;
  #|     steps++;
  #|   }
  #|   return undefined;
  #| }

///|
extern "js" fn is_bytes_scalar_like(type_ : JsValue) -> Bool =
  #| (type_) => {
  #|   let cur = type_;
  #|   let steps = 0;
  #|   while (cur && steps < 32) {
  #|     const kind = cur.kind;
  #|     const name = cur.name;
  #|     if (kind === "Scalar" && name === "bytes") return true;
  #|     cur = cur.baseScalar;
  #|     steps++;
  #|   }
  #|   return false;
  #| }

///|
extern "js" fn is_duration_scalar_like(type_ : JsValue) -> Bool =
  #| (type_) => {
  #|   let cur = type_;
  #|   let steps = 0;
  #|   while (cur && steps < 32) {
  #|     if (cur.kind === "Scalar" && cur.name === "duration") return true;
  #|     cur = cur.baseScalar;
  #|     steps++;
  #|   }
  #|   return false;
  #| }

///|
extern "js" fn is_utc_datetime_scalar_like(type_ : JsValue) -> Bool =
  #| (type_) => {
  #|   let cur = type_;
  #|   let steps = 0;
  #|   while (cur && steps < 32) {
  #|     if (cur.kind === "Scalar" && cur.name === "utcDateTime") return true;
  #|     cur = cur.baseScalar;
  #|     steps++;
  #|   }
  #|   return false;
  #| }

///|
extern "js" fn is_offset_datetime_scalar_like(type_ : JsValue) -> Bool =
  #| (type_) => {
  #|   let cur = type_;
  #|   let steps = 0;
  #|   while (cur && steps < 32) {
  #|     if (cur.kind === "Scalar" && cur.name === "offsetDateTime") return true;
  #|     cur = cur.baseScalar;
  #|     steps++;
  #|   }
  #|   return false;
  #| }

///|
extern "js" fn is_plain_date_scalar_like(type_ : JsValue) -> Bool =
  #| (type_) => {
  #|   let cur = type_;
  #|   let steps = 0;
  #|   while (cur && steps < 32) {
  #|     if (cur.kind === "Scalar" && cur.name === "plainDate") return true;
  #|     cur = cur.baseScalar;
  #|     steps++;
  #|   }
  #|   return false;
  #| }

///|
extern "js" fn is_plain_time_scalar_like(type_ : JsValue) -> Bool =
  #| (type_) => {
  #|   let cur = type_;
  #|   let steps = 0;
  #|   while (cur && steps < 32) {
  #|     if (cur.kind === "Scalar" && cur.name === "plainTime") return true;
  #|     cur = cur.baseScalar;
  #|     steps++;
  #|   }
  #|   return false;
  #| }

///|
extern "js" fn is_string_scalar_like(type_ : JsValue) -> Bool =
  #| (type_) => {
  #|   const names = new Set([
  #|     "string",
  #|     "url",
  #|   ]);
  #|   let cur = type_;
  #|   let steps = 0;
  #|   while (cur && steps < 32) {
  #|     if (cur.kind === "Scalar" && names.has(cur.name)) return true;
  #|     cur = cur.baseScalar;
  #|     steps++;
  #|   }
  #|   return false;
  #| }

///|
fn read_name(value : JsValue) -> String {
  let name_val = get(value, "name")
  if is_string(name_val) {
    cast_string(name_val)
  } else {
    ""
  }
}

///|
extern "js" fn get_model_properties_with_base_as_array(
  model : JsValue,
) -> Array[JsValue] =
  #| (model) => {
  #|   function getJsonEncodedName(prop) {
  #|     const decs = prop?.decorators;
  #|     if (!Array.isArray(decs)) return undefined;
  #|     for (const d of decs) {
  #|       if (d?.decorator?.name !== "$encodedName") continue;
  #|       const mimeArg = d?.args?.[0]?.value;
  #|       const nameArg = d?.args?.[1]?.value;
  #|       const mime = typeof mimeArg?.value === "string" ? mimeArg.value : mimeArg;
  #|       const encoded = typeof nameArg?.value === "string" ? nameArg.value : nameArg;
  #|       if (
  #|         typeof mime === "string" &&
  #|         mime.toLowerCase() === "application/json" &&
  #|         typeof encoded === "string" &&
  #|         encoded.length > 0
  #|       ) {
  #|         return encoded;
  #|       }
  #|     }
  #|     return undefined;
  #|   }
  #|
  #|   const order = [];
  #|   const index = new Map();
  #|   function visit(m) {
  #|     if (!m || typeof m !== "object") return;
  #|     visit(m.baseModel);
  #|     const props = m.properties;
  #|     if (!props) return;
  #|     const entries = typeof props.entries === "function"
  #|       ? props.entries()
  #|       : Object.entries(props);
  #|     for (const [name, prop] of entries) {
  #|       const json_name = getJsonEncodedName(prop);
  #|       if (!index.has(name)) {
  #|         index.set(name, order.length);
  #|         order.push({ name, prop, json_name });
  #|       } else {
  #|         const i = index.get(name);
  #|         order[i] = { name, prop, json_name };
  #|       }
  #|     }
  #|   }
  #|   visit(model);
  #|   return order;
  #| }

///|
extern "js" fn get_union_variants_as_array(
  variants : JsValue,
) -> Array[JsValue] =
  #| (variants) => {
  #|   if (!variants) return [];
  #|   if (typeof variants.values === "function") return [...variants.values()];
  #|   if (Array.isArray(variants)) return variants;
  #|   return [];
  #| }

///|
extern "js" fn get_js_identity(v : JsValue) -> String =
  #| (() => {
  #|   const ids = new WeakMap();
  #|   let nextId = 0;
  #|   return (v) => {
  #|     if (v === null || typeof v !== "object") return "primitive";
  #|     let id = ids.get(v);
  #|     if (id === undefined) {
  #|       id = String(nextId++);
  #|       ids.set(v, id);
  #|     }
  #|     return id;
  #|   };
  #| })()

///|
extern "js" fn derive_anon_model_name_prefix(model : JsValue) -> String? =
  #| (model) => {
  #|   const smName = model?.sourceModel?.name;
  #|   if (typeof smName === "string" && smName.length > 0) return smName;
  #|   const sourceModels = model?.sourceModels;
  #|   if (!Array.isArray(sourceModels)) return undefined;
  #|   const names = [];
  #|   for (const item of sourceModels) {
  #|     const n = item?.model?.name;
  #|     if (typeof n === "string" && n.length > 0) names.push(n);
  #|   }
  #|   return names.length > 0 ? names.join("") : undefined;
  #| }
