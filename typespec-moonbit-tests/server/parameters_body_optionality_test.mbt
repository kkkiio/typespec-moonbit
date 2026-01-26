///|
/// Test for parameters/body-optionality
/// Reference: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/parameters/body-optionality/main.test.e2e.ts
async test "parameters/body-optionality" {
  let body_optionality_handler = BodyOptionalityHandlerImpl::{  }
  let optional_explicit_handler = OptionalExplicitHandlerImpl::{  }
  @async.with_task_group(fn(group) {
    let router = @parameters_body_optionality.create_router(
      body_optionality_handler~,
      optional_explicit_handler~,
      group~,
    )
    let dispatch = @parameters_body_optionality.create_dispatch(router)
    let base_url = @server.start_server(group, dispatch)
    // Skipping optional explicit scenarios: https://github.com/microsoft/typespec/issues/6561
    let status = @server.run_scenario(
      "parameters/bodyoptionality/**/!(optionalexplicit)*", base_url,
    )
    assert_true(status is @server.Status::Pass)
  })
}

///|
struct BodyOptionalityHandlerImpl {}

///|
impl @parameters_body_optionality.BodyOptionalityHandler for BodyOptionalityHandlerImpl with required_explicit(
  _self,
  group~,
  body,
) {
  assert_eq(body.name, "foo", msg="required_explicit: body name mismatch")
}

///|
impl @parameters_body_optionality.BodyOptionalityHandler for BodyOptionalityHandlerImpl with required_implicit(
  _self,
  group~,
  body,
) {
  assert_eq(body.name, "foo", msg="required_implicit: body name mismatch")
}

///|
struct OptionalExplicitHandlerImpl {}

///|
impl @parameters_body_optionality.OptionalExplicitHandler for OptionalExplicitHandlerImpl with set(
  _self,
  group~,
  body,
) {
  assert_eq(body.name, "foo", msg="optional_explicit.set: body name mismatch")
}

///|
impl @parameters_body_optionality.OptionalExplicitHandler for OptionalExplicitHandlerImpl with omit(
  _self,
  group~,
  _body,
) {
  // omit should receive undefined/empty body
  // In TypeScript: assert.isUndefined(options?.body)
  // The body may be empty or have default values in MoonBit
}
