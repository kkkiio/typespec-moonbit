///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model Siamese
pub(all) struct Siamese {
  name : String
  age : Int
  smart : Bool
} derive(Show, ToJson, @json.FromJson)
