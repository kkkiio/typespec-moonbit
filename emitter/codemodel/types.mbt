///|
/// CodeModel 类型引用。
pub(all) enum TypeRef {
  String
  Int32
  Int64
  Float64
  Bool
  Json
  Model(Model)
  Union(Union)
  Array(TypeRef)
  Record(TypeRef)
  Nullable(TypeRef)
}

///|
pub(all) struct ModelField {
  name : String
  type_ : TypeRef
  optional : Bool
}

///|
/// CodeModel 模型。
pub(all) struct Model {
  name : String
  fields : Array[ModelField]
}

///|
pub fn Model::name(self : Model) -> String {
  self.name
}

///|
/// CodeModel 枚举。
#warnings("-struct_never_constructed")
pub struct Enum {
  name : String
}

///|
/// CodeModel 联合类型（仅包含必要信息，便于 codegen 渲染）。
pub(all) struct UnionVariant {
  name : String
  type_ : TypeRef
}

///|
pub(all) struct Union {
  name : String
  variants : Array[UnionVariant]
}
