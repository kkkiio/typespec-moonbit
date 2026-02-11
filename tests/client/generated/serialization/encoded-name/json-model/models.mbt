///|
/// Model JsonEncodedNameModel
pub(all) struct JsonEncodedNameModel {
  default_name : Bool
} derive (
  Show,
  ToJson(fields(default_name(rename="wireName"))),
  @json.FromJson(fields(default_name(rename="wireName"))),
)
