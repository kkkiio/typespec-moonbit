///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model Fish
pub(all) struct Fish {
  age : Int
} derive(Show, ToJson, @json.FromJson)
