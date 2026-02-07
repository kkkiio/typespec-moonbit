///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model Extension
pub(all) struct Extension {
  extension : Array[Extension]?
  level : Int
} derive(Show, ToJson, @json.FromJson)
