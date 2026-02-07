///|
/// 文件 AST。
pub(all) struct File {
  package_name : String?
  imports : Array[String]
  top_levels : Array[TopLevel]
}

///|
/// 结构体字段定义。
pub(all) struct Field {
  name : String
  type_ : Type
  is_optional : Bool
  doc : String?
  json_name : String?
}

///|
/// 枚举变体定义。
pub(all) struct EnumVariant {
  name : String
  payload : Type?
  doc : String?
  json_name : String?
}

///|
/// 函数参数定义。
/// `is_optional = None` 表示位置参数；
/// `Some(false)` 表示 `~` 必填标签参数；
/// `Some(true)` 表示 `?` 可选参数。
pub(all) struct Param {
  name : String
  type_ : Type
  is_optional : Bool?
}

///|
/// 方法签名（用于 trait）。
pub(all) struct FunctionSignature {
  name : String
  params : Array[Param]
  return_type : Type
  is_async : Bool
  can_raise : Bool
  doc : String?
}

///|
/// 函数定义（用于顶层函数和 impl 方法）。
pub(all) struct Function {
  name : String
  params : Array[Param]
  return_type : Type
  body : Array[Stmt]
  is_async : Bool
  is_pub : Bool
  can_raise : Bool
  doc : String?
}

///|
/// 顶层定义 AST。
pub(all) enum TopLevel {
  Struct(String, Array[Field], Array[String], String?)
  Enum(String, Array[EnumVariant], Array[String], String?)
  Function(Function)
  Trait(String, Array[FunctionSignature], String?)
  Impl(String, Type, Array[Function])
  TypeAlias(String, Type, String?)
}
