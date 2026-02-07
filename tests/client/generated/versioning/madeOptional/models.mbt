///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model TestModel
pub(all) struct TestModel {
  prop : String
  changed_prop : String?
} derive (
  Show,
  ToJson(fields(changed_prop(rename="changedProp"))),
  @json.FromJson(fields(changed_prop(rename="changedProp"))),
)
