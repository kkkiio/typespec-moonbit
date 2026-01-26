///|
/// Test for parameters/spread
/// Reference: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/parameters/spread/main.test.e2e.ts
async test "parameters/spread" {
  let alias_handler = SpreadAliasHandlerImpl::{  }
  let model_handler = SpreadModelHandlerImpl::{  }
  @async.with_task_group(fn(group) {
    let router = @parameters_spread.create_router(
      alias_handler~,
      model_handler~,
      group~,
    )
    let dispatch = @parameters_spread.create_dispatch(router)
    let base_url = @server.start_server(group, dispatch)
    let status = @server.run_scenario("parameters/spread/**/*", base_url)
    assert_true(status is @server.Status::Pass)
  })
}

///|
struct SpreadAliasHandlerImpl {}

///|
impl @parameters_spread.AliasHandler for SpreadAliasHandlerImpl with spread_as_request_body(
  _self,
  group~,
  body,
) {
  assert_eq(body.name, "foo", msg="alias.spread_as_request_body: name mismatch")
}

///|
impl @parameters_spread.AliasHandler for SpreadAliasHandlerImpl with spread_parameter_with_inner_model(
  _self,
  group~,
  id,
  x_ms_test_header,
  body,
) {
  assert_eq(id, "1", msg="spread_parameter_with_inner_model: id mismatch")
  assert_eq(
    x_ms_test_header,
    "bar",
    msg="spread_parameter_with_inner_model: x_ms_test_header mismatch",
  )
  assert_eq(
    body.name,
    "foo",
    msg="spread_parameter_with_inner_model: body.name mismatch",
  )
}

///|
impl @parameters_spread.AliasHandler for SpreadAliasHandlerImpl with spread_as_request_parameter(
  _self,
  group~,
  id,
  x_ms_test_header,
  body,
) {
  assert_eq(id, "1", msg="spread_as_request_parameter: id mismatch")
  assert_eq(
    x_ms_test_header,
    "bar",
    msg="spread_as_request_parameter: x_ms_test_header mismatch",
  )
  assert_eq(
    body.name,
    "foo",
    msg="spread_as_request_parameter: body.name mismatch",
  )
}

///|
impl @parameters_spread.AliasHandler for SpreadAliasHandlerImpl with spread_with_multiple_parameters(
  _self,
  group~,
  id,
  x_ms_test_header,
  body,
) {
  assert_eq(id, "1", msg="spread_with_multiple_parameters: id mismatch")
  assert_eq(
    x_ms_test_header,
    "bar",
    msg="spread_with_multiple_parameters: x_ms_test_header mismatch",
  )
  assert_eq(
    body.required_string,
    "foo",
    msg="spread_with_multiple_parameters: required_string mismatch",
  )
  // TODO: Check requiredIntList == [1, 2]
  // TODO: Check optionalInt == 1
  // TODO: Check optionalStringList == ["foo", "bar"]
}

///|
impl @parameters_spread.AliasHandler for SpreadAliasHandlerImpl with spread_parameter_with_inner_alias(
  _self,
  group~,
  id,
  x_ms_test_header,
  body,
) {
  assert_eq(id, "1", msg="spread_parameter_with_inner_alias: id mismatch")
  assert_eq(
    x_ms_test_header,
    "bar",
    msg="spread_parameter_with_inner_alias: x_ms_test_header mismatch",
  )
  assert_eq(
    body.name,
    "foo",
    msg="spread_parameter_with_inner_alias: name mismatch",
  )
  assert_eq(body.age, 1, msg="spread_parameter_with_inner_alias: age mismatch")
}

///|
struct SpreadModelHandlerImpl {}

///|
impl @parameters_spread.ModelHandler for SpreadModelHandlerImpl with spread_as_request_body(
  _self,
  group~,
  body,
) {
  assert_eq(body.name, "foo", msg="model.spread_as_request_body: name mismatch")
}

///|
impl @parameters_spread.ModelHandler for SpreadModelHandlerImpl with spread_composite_request_only_with_body(
  _self,
  group~,
  body,
) {
  assert_eq(
    body.name,
    "foo",
    msg="spread_composite_request_only_with_body: name mismatch",
  )
}

///|
impl @parameters_spread.ModelHandler for SpreadModelHandlerImpl with spread_composite_request_without_body(
  _self,
  group~,
  name,
  test_header,
) {
  assert_eq(
    name,
    "foo",
    msg="spread_composite_request_without_body: name mismatch",
  )
  assert_eq(
    test_header,
    "bar",
    msg="spread_composite_request_without_body: test_header mismatch",
  )
}

///|
impl @parameters_spread.ModelHandler for SpreadModelHandlerImpl with spread_composite_request(
  _self,
  group~,
  name,
  test_header,
  body,
) {
  assert_eq(name, "foo", msg="spread_composite_request: name mismatch")
  assert_eq(
    test_header,
    "bar",
    msg="spread_composite_request: test_header mismatch",
  )
  assert_eq(
    body.name,
    "foo",
    msg="spread_composite_request: body.name mismatch",
  )
}

///|
impl @parameters_spread.ModelHandler for SpreadModelHandlerImpl with spread_composite_request_mix(
  _self,
  group~,
  name,
  test_header,
  body,
) {
  assert_eq(name, "foo", msg="spread_composite_request_mix: name mismatch")
  assert_eq(
    test_header,
    "bar",
    msg="spread_composite_request_mix: test_header mismatch",
  )
  assert_eq(
    body.prop,
    "foo",
    msg="spread_composite_request_mix: body.prop mismatch",
  )
}
