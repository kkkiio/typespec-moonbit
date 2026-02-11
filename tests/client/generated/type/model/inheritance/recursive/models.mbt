///|
/// Model Extension
pub(all) struct Extension {
  extension : Array[Extension]?
  level : Int
} derive(Show, ToJson, @json.FromJson)
