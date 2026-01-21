///|
/// CodeModel 类型引用。
pub(all) enum TypeRef {
  String
  Int32
  Int64
  Float64
  Bool
  Model(Model)
  Array(TypeRef)
  Unknown
}

///|
pub(all) struct ModelField {
  name : String
  type_ : TypeRef
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
pub struct Enum {
  name : String
}

///|
/// CodeModel 联合类型。
pub struct Union {
  name : String
}
