///|
/// 运行时验证：http-specs parameters/body-optionality
#cfg(target="native")
async test "runtime parameters/body-optionality" {
  let client = @parameters_body_optionality.BodyOptionalityClient::new(
    "http://localhost:3000",
  )
  let body = @parameters_body_optionality.BodyModel::{ name: "foo" }
  client.post_parameters_body_optionality_required_explicit(body)
  let body = @parameters_body_optionality.BodyModel1::{ name: "foo" }
  client.post_parameters_body_optionality_required_implicit(body)
  let optional = @parameters_body_optionality.OptionalExplicitClient::new(
    "http://localhost:3000",
  )
  let body = @parameters_body_optionality.BodyModel::{ name: "foo" }
  optional.post_parameters_body_optionality_optional_explicit_set(Some(body))
  optional.post_parameters_body_optionality_optional_explicit_omit(None)
}
