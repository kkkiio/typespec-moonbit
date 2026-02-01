///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

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
