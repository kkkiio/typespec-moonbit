///|
/// Union NewUnion
pub(all) enum NewUnion {
  String(String)
  NewUnionVariant(Json)
} derive(Show)

///|
pub impl ToJson for NewUnion with to_json(self : NewUnion) -> Json {
  match self {
    String(v) => v.to_json()
    NewUnionVariant(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for NewUnion with from_json(
  json : Json,
  path : @json.JsonPath,
) -> NewUnion raise {
  let try_0 : Result[String, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return String(v)
  }
  let try_1 : Result[Json, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return NewUnionVariant(v)
  }
  raise @json.JsonDecodeError(
    (path, "cannot deserialize json as union NewUnion"),
  )
}

///|
/// Model NewModel
pub(all) struct NewModel {
  new_prop : String
  enum_prop : Json
  union_prop : NewUnion
} derive (
  Show,
  ToJson(
    fields(
      new_prop(rename="newProp"),
      enum_prop(rename="enumProp"),
      union_prop(rename="unionProp"),
    ),
  ),
  @json.FromJson(
    fields(
      new_prop(rename="newProp"),
      enum_prop(rename="enumProp"),
      union_prop(rename="unionProp"),
    ),
  ),
)
