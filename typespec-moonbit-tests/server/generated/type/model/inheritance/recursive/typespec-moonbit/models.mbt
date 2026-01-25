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
/// Model Extension
pub(all) struct Extension {
  extension : Array[Extension]?
  level : Int
} derive(Show, Default, @json.FromJson(rename_fields="camelCase"))

///|
pub impl ToJson for Extension with to_json(self : Extension) -> Json {
  let m : Map[String, Json] = Map::new()
  match self.extension {
    Some(v) => m.set("extension", v.to_json())
    None => ()
  }
  m.set("level", self.level.to_json())
  Json::object(m)
}
