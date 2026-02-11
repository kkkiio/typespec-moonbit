///|

///|
/// Model ReadOnlyModel
pub(all) struct ReadOnlyModel {
  optional_nullable_int_list : @runtime.Nullable[Array[Int]]?
  optional_string_record : Map[String, String]?
} derive (
  Show,
  ToJson(
    fields(
      optional_nullable_int_list(rename="optionalNullableIntList"),
      optional_string_record(rename="optionalStringRecord"),
    ),
  ),
  @json.FromJson(
    fields(
      optional_nullable_int_list(rename="optionalNullableIntList"),
      optional_string_record(rename="optionalStringRecord"),
    ),
  ),
)

///|

///|
/// Model VisibilityModel
pub(all) struct VisibilityModel {
  read_prop : String
  query_prop : Int
  create_prop : Array[String]
  update_prop : Array[Int]
  delete_prop : Bool
  none_prop : String
} derive (
  Show,
  ToJson(
    fields(
      read_prop(rename="readProp"),
      query_prop(rename="queryProp"),
      create_prop(rename="createProp"),
      update_prop(rename="updateProp"),
      delete_prop(rename="deleteProp"),
      none_prop(rename="noneProp"),
    ),
  ),
  @json.FromJson(
    fields(
      read_prop(rename="readProp"),
      query_prop(rename="queryProp"),
      create_prop(rename="createProp"),
      update_prop(rename="updateProp"),
      delete_prop(rename="deleteProp"),
      none_prop(rename="noneProp"),
    ),
  ),
)
