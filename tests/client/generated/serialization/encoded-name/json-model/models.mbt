///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model JsonEncodedNameModel
pub(all) struct JsonEncodedNameModel {
  default_name : Bool
} derive (
  Show,
  ToJson(fields(default_name(rename="wireName"))),
  @json.FromJson(fields(default_name(rename="wireName"))),
)
