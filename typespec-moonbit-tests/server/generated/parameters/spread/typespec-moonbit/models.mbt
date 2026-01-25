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
/// Model Model0
pub(all) struct Model0 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model Model1
pub(all) struct Model1 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model Model2
pub(all) struct Model2 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model Model3
pub(all) struct Model3 {
  required_string : String
  optional_int : Int?
  required_int_list : Array[Int]
  optional_string_list : Array[String]?
} derive(Show, Default, @json.FromJson(rename_fields="camelCase"))

///|
pub impl ToJson for Model3 with to_json(self : Model3) -> Json {
  let m : Map[String, Json] = Map::new()
  m.set("requiredString", self.required_string.to_json())
  match self.optional_int {
    Some(v) => m.set("optionalInt", v.to_json())
    None => ()
  }
  m.set("requiredIntList", self.required_int_list.to_json())
  match self.optional_string_list {
    Some(v) => m.set("optionalStringList", v.to_json())
    None => ()
  }
  Json::object(m)
}

///|
/// Model Model4
pub(all) struct Model4 {
  name : String
  age : Int
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model Model6
pub(all) struct Model6 {
  prop : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model BodyParameter
pub(all) struct BodyParameter {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))

///|
/// Model BodyParameter5
pub(all) struct BodyParameter5 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson(rename_fields="camelCase"))
