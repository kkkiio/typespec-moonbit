///|
fn type_ref_to_string(type_ : @codemodel.TypeRef) -> String {
  match type_ {
    String => "String"
    Int32 => "Int"
    Int64 => "Int64"
    Float64 => "Double"
    Bool => "Bool"
    Model(m) => @case.pascal_case(m.name)
    Array(t) => "Array[\{type_ref_to_string(t)}]"
  }
}
