///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model Dog
pub(all) struct Dog {
  kind : String
  weight : Int
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Snake
pub(all) struct Snake {
  kind : Json
  length : Int
} derive(Show, ToJson, @json.FromJson)
