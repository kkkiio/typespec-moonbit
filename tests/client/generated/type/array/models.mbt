///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model InnerModel
pub(all) struct InnerModel {
  property : String
  children : Array[InnerModel]?
} derive(Show, ToJson, @json.FromJson)
