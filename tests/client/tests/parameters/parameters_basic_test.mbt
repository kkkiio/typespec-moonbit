///|

///|
/// 运行时验证：http-specs parameters/basic
async test "runtime parameters/basic" {
  let explicit = @parameters_basic.ExplicitBodyClient::new(
    "http://localhost:3000",
  )
  let body = @parameters_basic.User::{ name: "foo" }
  explicit.put_parameters_basic_explicit_body_simple(body)
  let implicit = @parameters_basic.ImplicitBodyClient::new(
    "http://localhost:3000",
  )
  let body = @parameters_basic.Model0::{ name: "foo" }
  implicit.put_parameters_basic_implicit_body_simple(body)
}
