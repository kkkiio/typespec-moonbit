///|
/// MoonBit 代码生成器类型系统。
pub(all) enum Type {
  Unit
  Bool
  Int
  Int64
  Double
  String
  Json
  Array(Type)
  Map(Type, Type)
  Option(Type)
  Result(Type, Type)
  Named(String)
}

///|
/// 渲染为 MoonBit 类型签名。
pub fn Type::to_string(self : Type) -> String {
  match self {
    Unit => "Unit"
    Bool => "Bool"
    Int => "Int"
    Int64 => "Int64"
    Double => "Double"
    String => "String"
    Json => "Json"
    Array(item) => "Array[\{item.to_string()}]"
    Map(key, value) => "Map[\{key.to_string()}, \{value.to_string()}]"
    Option(inner) => "Option[\{inner.to_string()}]"
    Result(ok, err) => "Result[\{ok.to_string()}, \{err.to_string()}]"
    Named(name) => name
  }
}
