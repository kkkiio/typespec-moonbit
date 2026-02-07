///|

///|
/// Model InnerModel
pub(all) struct InnerModel {
  property : String
  children : Array[InnerModel]?
} derive(Show, ToJson, @json.FromJson)
