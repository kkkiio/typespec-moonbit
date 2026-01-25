///|
/// Nullable helper used for `T | null`.
pub(all) struct Nullable[T](T?) derive(Show, Default, Eq, Compare)

///|
pub impl[T : ToJson] ToJson for Nullable[T] with to_json(self : Nullable[T]) -> Json {
  match self.0 {
    Some(v) => v.to_json()
    None => Json::null()
  }
}

///|
pub impl[T : @json.FromJson] @json.FromJson for Nullable[T] with from_json(
  j : Json,
  path : @json.JsonPath,
) -> Nullable[T] raise @json.JsonDecodeError {
  match j {
    Null => Nullable(None)
    _ => Nullable(Some(@json.from_json(j, path~)))
  }
}

///|
/// Model BodyModel
pub(all) struct BodyModel {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model BodyModel0
pub(all) struct BodyModel0 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))
