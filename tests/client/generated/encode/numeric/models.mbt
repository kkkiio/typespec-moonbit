///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model Uint8AsStringProperty
pub(all) struct Uint8AsStringProperty {
  value : Json
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Uint32AsStringProperty
pub(all) struct Uint32AsStringProperty {
  value : Json?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model SafeintAsStringProperty
pub(all) struct SafeintAsStringProperty {
  value : Json
} derive(Show, ToJson, @json.FromJson)
