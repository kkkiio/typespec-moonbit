///|

///|
/// Model User
pub(all) struct User {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model0
pub(all) struct Model0 {
  name : String
} derive(Show, ToJson, @json.FromJson)
