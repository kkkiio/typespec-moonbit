///|
/// Nullable helper used for `T | null`.
pub(all) struct Nullable[T] {
  value : T?
} derive(Show, Default)

///|
pub fn[T] Nullable::some(v : T) -> Nullable[T] {
  { value: Some(v) }
}

///|
pub fn[T] Nullable::none() -> Nullable[T] {
  { value: None }
}

///|
pub impl[T : ToJson] ToJson for Nullable[T] with to_json(self : Nullable[T]) -> Json {
  match self.value {
    Some(v) => v.to_json()
    None => Json::null()
  }
}

///|
pub impl[T : @json.FromJson] @json.FromJson for Nullable[T] with from_json(
  j : Json,
  path : @json.JsonPath,
) -> Nullable[T] raise @json.JsonDecodeError {
  if j == Json::null() {
    { value: None }
  } else {
    { value: Some(@json.from_json(j, path~)) }
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
