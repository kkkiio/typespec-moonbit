///|
/// 表达式 AST。
pub(all) enum Expr {
  LitString(String)
  LitInt(Int)
  LitBool(Bool)
  Ident(String)
  Call(Expr, Array[Expr])
  MethodCall(Expr, String, Array[Expr])
  Raw(String)
}

///|
/// 语句 AST。
pub(all) enum Stmt {
  Let(String, Type?, Expr)
  Return(Expr?)
  Expr(Expr)
  Assign(Expr, Expr)
  Raw(String)
}
