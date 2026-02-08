///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model Bird
pub(all) struct Bird {
  kind : String
  wingspan : Int
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Dinosaur
pub(all) struct Dinosaur {
  size : Int
} derive(Show, ToJson, @json.FromJson)
