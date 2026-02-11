///|
/// Model User
pub(all) struct User {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|
/// Model Model
pub(all) struct Model {
  name : String
} derive(Show, ToJson, @json.FromJson)
