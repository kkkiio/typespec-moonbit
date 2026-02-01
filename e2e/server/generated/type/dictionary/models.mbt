///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|
/// Model InnerModel
pub(all) struct InnerModel {
  property : String
  children : Map[String, InnerModel]?
} derive(Show, Default, ToJson, @json.FromJson)
