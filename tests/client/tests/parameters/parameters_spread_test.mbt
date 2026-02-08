///|
/// 运行时验证：http-specs parameters/spread
#cfg(target="native")
async test "runtime parameters/spread: model" {
  let client = @parameters_spread.ModelClient::new("http://localhost:3000")
  let body = @parameters_spread.BodyParameter5::{ name: "foo" }
  client.put_parameters_spread_model_request_body(body)
  let body = @parameters_spread.BodyParameter::{ name: "foo" }
  client.put_parameters_spread_model_composite_request_only_with_body(body)
  client.put_parameters_spread_model_composite_request_without_body__name_(
    "foo", "bar",
  )
  let body = @parameters_spread.BodyParameter::{ name: "foo" }
  client.put_parameters_spread_model_composite_request__name_(
    "foo", "bar", body,
  )
  let body = @parameters_spread.Model6::{ prop: "foo" }
  client.put_parameters_spread_model_composite_request_mix__name_(
    "foo", "bar", body,
  )
}

///|
#cfg(target="native")
async test "runtime parameters/spread: alias" {
  let client = @parameters_spread.AliasClient::new("http://localhost:3000")
  let body = @parameters_spread.Model0::{ name: "foo" }
  client.put_parameters_spread_alias_request_body(body)
  let body = @parameters_spread.Model1::{ name: "foo" }
  client.post_parameters_spread_alias_inner_model_parameter__id_(
    "1", "bar", body,
  )
  let body = @parameters_spread.Model2::{ name: "foo" }
  client.put_parameters_spread_alias_request_parameter__id_("1", "bar", body)
  let body = @parameters_spread.Model3::{
    required_string: "foo",
    optional_int: Some(1),
    required_int_list: [1, 2],
    optional_string_list: Some(["foo", "bar"]),
  }
  client.put_parameters_spread_alias_multiple_parameters__id_("1", "bar", body)
  let body = @parameters_spread.Model4::{ name: "foo", age: 1 }
  client.post_parameters_spread_alias_inner_alias_parameter__id_(
    "1", "bar", body,
  )
}
