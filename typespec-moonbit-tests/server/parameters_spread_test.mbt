///|
/// Test for parameters/spread
/// Reference: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/parameters/spread/main.test.e2e.ts
async test "parameters/spread" {
  let alias_handler = SpreadAliasHandlerImpl::{  }
  let model_handler = SpreadModelHandlerImpl::{  }
  let router = @parameters_spread.create_router(alias_handler, model_handler)
  @async.with_task_group(fn(group) {
    let base_url = @server.start_server(group, fn(req, body, conn) {
      router.dispatch(req, body, conn)
    })
    let status = @server.run_scenario("parameters/spread/**/*", base_url)
    assert_true(status is @server.Status::Pass)
  })
}

///|
struct SpreadAliasHandlerImpl {}

///|
impl @parameters_spread.AliasHandler for SpreadAliasHandlerImpl with spread_as_request_body(
  _self : SpreadAliasHandlerImpl,
  body : @parameters_spread.AnonymousModel1,
) {
  guard body.name == "foo" else {
    fail("alias.spread_as_request_body: name mismatch, expected 'foo'")
  }
}

///|
impl @parameters_spread.AliasHandler for SpreadAliasHandlerImpl with spread_parameter_with_inner_model(
  _self : SpreadAliasHandlerImpl,
  id : String,
  x_ms_test_header : String,
  body : @parameters_spread.AnonymousModel2,
) {
  guard id == "1" else {
    fail("spread_parameter_with_inner_model: id mismatch, expected '1'")
  }
  guard x_ms_test_header == "bar" else {
    fail(
      "spread_parameter_with_inner_model: x_ms_test_header mismatch, expected 'bar'",
    )
  }
  guard body.name == "foo" else {
    fail(
      "spread_parameter_with_inner_model: body.name mismatch, expected 'foo'",
    )
  }
}

///|
impl @parameters_spread.AliasHandler for SpreadAliasHandlerImpl with spread_as_request_parameter(
  _self : SpreadAliasHandlerImpl,
  id : String,
  x_ms_test_header : String,
  body : @parameters_spread.AnonymousModel3,
) {
  guard id == "1" else {
    fail("spread_as_request_parameter: id mismatch, expected '1'")
  }
  guard x_ms_test_header == "bar" else {
    fail(
      "spread_as_request_parameter: x_ms_test_header mismatch, expected 'bar'",
    )
  }
  guard body.name == "foo" else {
    fail("spread_as_request_parameter: body.name mismatch, expected 'foo'")
  }
}

///|
impl @parameters_spread.AliasHandler for SpreadAliasHandlerImpl with spread_with_multiple_parameters(
  _self : SpreadAliasHandlerImpl,
  id : String,
  x_ms_test_header : String,
  body : @parameters_spread.AnonymousModel4,
) {
  guard id == "1" else {
    fail("spread_with_multiple_parameters: id mismatch, expected '1'")
  }
  guard x_ms_test_header == "bar" else {
    fail(
      "spread_with_multiple_parameters: x_ms_test_header mismatch, expected 'bar'",
    )
  }
  guard body.required_string == "foo" else {
    fail(
      "spread_with_multiple_parameters: required_string mismatch, expected 'foo'",
    )
  }
  // TODO: Check requiredIntList == [1, 2]
  // TODO: Check optionalInt == 1
  // TODO: Check optionalStringList == ["foo", "bar"]
}

///|
impl @parameters_spread.AliasHandler for SpreadAliasHandlerImpl with spread_parameter_with_inner_alias(
  _self : SpreadAliasHandlerImpl,
  id : String,
  x_ms_test_header : String,
  body : @parameters_spread.AnonymousModel5,
) {
  guard id == "1" else {
    fail("spread_parameter_with_inner_alias: id mismatch, expected '1'")
  }
  guard x_ms_test_header == "bar" else {
    fail(
      "spread_parameter_with_inner_alias: x_ms_test_header mismatch, expected 'bar'",
    )
  }
  guard body.name == "foo" else {
    fail("spread_parameter_with_inner_alias: name mismatch, expected 'foo'")
  }
  guard body.age == "1" else {
    fail("spread_parameter_with_inner_alias: age mismatch, expected '1'")
  }
}

///|
struct SpreadModelHandlerImpl {}

///|
impl @parameters_spread.ModelHandler for SpreadModelHandlerImpl with spread_as_request_body(
  _self : SpreadModelHandlerImpl,
  body : @parameters_spread.AnonymousModel6,
) {
  guard body.name == "foo" else {
    fail("model.spread_as_request_body: name mismatch, expected 'foo'")
  }
}

///|
impl @parameters_spread.ModelHandler for SpreadModelHandlerImpl with spread_composite_request_only_with_body(
  _self : SpreadModelHandlerImpl,
  body : @parameters_spread.BodyParameter,
) {
  guard body.name == "foo" else {
    fail(
      "spread_composite_request_only_with_body: name mismatch, expected 'foo'",
    )
  }
}

///|
impl @parameters_spread.ModelHandler for SpreadModelHandlerImpl with spread_composite_request_without_body(
  _self : SpreadModelHandlerImpl,
  name : String,
  test_header : String,
) {
  guard name == "foo" else {
    fail("spread_composite_request_without_body: name mismatch, expected 'foo'")
  }
  guard test_header == "bar" else {
    fail(
      "spread_composite_request_without_body: test_header mismatch, expected 'bar'",
    )
  }
}

///|
impl @parameters_spread.ModelHandler for SpreadModelHandlerImpl with spread_composite_request(
  _self : SpreadModelHandlerImpl,
  name : String,
  test_header : String,
  body : @parameters_spread.BodyParameter,
) {
  guard name == "foo" else {
    fail("spread_composite_request: name mismatch, expected 'foo'")
  }
  guard test_header == "bar" else {
    fail("spread_composite_request: test_header mismatch, expected 'bar'")
  }
  guard body.name == "foo" else {
    fail("spread_composite_request: body.name mismatch, expected 'foo'")
  }
}

///|
impl @parameters_spread.ModelHandler for SpreadModelHandlerImpl with spread_composite_request_mix(
  _self : SpreadModelHandlerImpl,
  name : String,
  test_header : String,
  body : @parameters_spread.AnonymousModel7,
) {
  guard name == "foo" else {
    fail("spread_composite_request_mix: name mismatch, expected 'foo'")
  }
  guard test_header == "bar" else {
    fail("spread_composite_request_mix: test_header mismatch, expected 'bar'")
  }
  guard body.prop == "foo" else {
    fail("spread_composite_request_mix: body.prop mismatch, expected 'foo'")
  }
}
