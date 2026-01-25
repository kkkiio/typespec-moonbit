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
