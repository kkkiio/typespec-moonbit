///|
/// Union UnionV1
pub(all) enum UnionV1 {
  String(String)
  Int32(Int)
} derive(Show)

///|
pub impl ToJson for UnionV1 with to_json(self : UnionV1) -> Json {
  match self {
    String(v) => v.to_json()
    Int32(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for UnionV1 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> UnionV1 raise {
  let try_0 : Result[String, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return String(v)
  }
  let try_1 : Result[Int, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return Int32(v)
  }
  raise @json.JsonDecodeError(
    (path, "cannot deserialize json as union UnionV1"),
  )
}

///|
/// Union UnionV2
pub(all) enum UnionV2 {
  String(String)
  Float32(Double)
  V1Scalar(Json)
} derive(Show)

///|
pub impl ToJson for UnionV2 with to_json(self : UnionV2) -> Json {
  match self {
    String(v) => v.to_json()
    Float32(v) => v.to_json()
    V1Scalar(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for UnionV2 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> UnionV2 raise {
  let try_0 : Result[String, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return String(v)
  }
  let try_1 : Result[Double, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return Float32(v)
  }
  let try_2 : Result[Json, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_2 is Ok(v) {
    return V1Scalar(v)
  }
  raise @json.JsonDecodeError(
    (path, "cannot deserialize json as union UnionV2"),
  )
}

///|
/// Model ModelV1
pub(all) struct ModelV1 {
  prop : String
  enum_prop : Json
  union_prop : UnionV1
} derive (
  Show,
  ToJson(fields(enum_prop(rename="enumProp"), union_prop(rename="unionProp"))),
  @json.FromJson(
    fields(enum_prop(rename="enumProp"), union_prop(rename="unionProp")),
  ),
)

///|
/// Model ModelV2
pub(all) struct ModelV2 {
  prop : String
  removed_prop : String
  enum_prop : Json
  union_prop : UnionV2
} derive (
  Show,
  ToJson(
    fields(
      removed_prop(rename="removedProp"),
      enum_prop(rename="enumProp"),
      union_prop(rename="unionProp"),
    ),
  ),
  @json.FromJson(
    fields(
      removed_prop(rename="removedProp"),
      enum_prop(rename="enumProp"),
      union_prop(rename="unionProp"),
    ),
  ),
)

///|
/// Model ModelV3
pub(all) struct ModelV3 {
  id : String
  enum_prop : Json
} derive (
  Show,
  ToJson(fields(enum_prop(rename="enumProp"))),
  @json.FromJson(fields(enum_prop(rename="enumProp"))),
)
