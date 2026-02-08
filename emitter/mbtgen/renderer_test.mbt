///|
test "type_to_string" {
  inspect(
    Type::Result(Type::Array(Type::Named("User")), Type::String).to_string(),
    content="Result[Array[User], String]",
  )
}

///|
test "render_file" {
  let file : File = {
    package_name: Some("sample/client"),
    imports: ["z/pkg", "a/pkg", "a/pkg"],
    top_levels: [
      TopLevel::Struct(
        "User",
        [
          {
            name: "name",
            type_: Type::String,
            is_optional: false,
            doc: Some("用户名"),
            json_name: Some("user_name"),
          },
          {
            name: "age",
            type_: Type::Int,
            is_optional: true,
            doc: None,
            json_name: None,
          },
        ],
        ["Show"],
        Some("用户模型"),
      ),
      TopLevel::Function({
        name: "greet",
        params: [
          { name: "user", type_: Type::Named("User"), is_optional: None },
        ],
        return_type: Type::String,
        body: [Stmt::Return(Some(Expr::LitString("ok")))],
        is_async: false,
        is_pub: true,
        can_raise: false,
        doc: Some("返回问候"),
      }),
    ],
  }
  inspect(
    render(file),
    content=(
      #|// package: sample/client
      #|
      #|import "a/pkg"
      #|import "z/pkg"
      #|
      #|///|
      #|///|
      #|/// 用户模型
      #|pub(all) struct User {
      #|  ///|
      #|  /// 用户名
      #|  name : String // rename="user_name"
      #|  age : Int?
      #|} derive(Show)
      #|
      #|///|
      #|///|
      #|/// 返回问候
      #|pub fn greet(user : User) -> String {
      #|  return "ok"
      #|}
    ),
  )
}
