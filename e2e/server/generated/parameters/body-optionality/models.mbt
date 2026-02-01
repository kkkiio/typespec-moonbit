///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|
/// Model BodyModel
pub(all) struct BodyModel {
  name : String
} derive(Show, Default, ToJson, @json.FromJson)

///|
/// Model BodyModel0
pub(all) struct BodyModel0 {
  name : String
} derive(Show, Default, ToJson, @json.FromJson)
