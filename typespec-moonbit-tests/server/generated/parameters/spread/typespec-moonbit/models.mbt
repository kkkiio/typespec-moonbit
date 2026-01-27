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
/// Model Model0
pub(all) struct Model0 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson)

///|
/// Model Model1
pub(all) struct Model1 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson)

///|
/// Model Model2
pub(all) struct Model2 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson)

///|
/// Model Model3
pub(all) struct Model3 {
  required_string : String
  optional_int : Int?
  required_int_list : Array[Int]
  optional_string_list : Array[String]?
} derive (
  Show,
  Default,
  ToJson(
    fields(
      required_string(rename="requiredString"),
      optional_int(rename="optionalInt"),
      required_int_list(rename="requiredIntList"),
      optional_string_list(rename="optionalStringList"),
    ),
  ),
  @json.FromJson(
    fields(
      required_string(rename="requiredString"),
      optional_int(rename="optionalInt"),
      required_int_list(rename="requiredIntList"),
      optional_string_list(rename="optionalStringList"),
    ),
  ),
)

///|
/// Model Model4
pub(all) struct Model4 {
  name : String
  age : Int
} derive(Show, Default, ToJson, @json.FromJson)

///|
/// Model Model6
pub(all) struct Model6 {
  prop : String
} derive(Show, Default, ToJson, @json.FromJson)

///|
/// Model BodyParameter
pub(all) struct BodyParameter {
  name : String
} derive(Show, Default, ToJson, @json.FromJson)

///|
/// Model BodyParameter5
pub(all) struct BodyParameter5 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson)
