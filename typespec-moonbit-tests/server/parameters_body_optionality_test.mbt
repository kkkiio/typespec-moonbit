///|
/// Test for parameters/body-optionality
/// Reference: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/parameters/body-optionality/main.test.e2e.ts
async test "parameters/body-optionality" {
  let body_optionality_handler = BodyOptionalityHandlerImpl::{  }
  let optional_explicit_handler = OptionalExplicitHandlerImpl::{  }
  let router = @parameters_body_optionality.create_router(
    body_optionality_handler, optional_explicit_handler,
  )
  @async.with_task_group(fn(group) {
    let base_url = @server.start_server(group, fn(req, body, conn) {
      router.dispatch(req, body, conn)
    })
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
  _self : BodyOptionalityHandlerImpl,
  body : @parameters_body_optionality.BodyModel,
) {
  guard body.name == "foo" else {
    fail("required_explicit: body name mismatch, expected 'foo'")
  }
}

///|
impl @parameters_body_optionality.BodyOptionalityHandler for BodyOptionalityHandlerImpl with required_implicit(
  _self : BodyOptionalityHandlerImpl,
  body : @parameters_body_optionality.AnonymousModel1,
) {
  guard body.name == "foo" else {
    fail("required_implicit: body name mismatch, expected 'foo'")
  }
}

///|
struct OptionalExplicitHandlerImpl {}

///|
impl @parameters_body_optionality.OptionalExplicitHandler for OptionalExplicitHandlerImpl with set(
  _self : OptionalExplicitHandlerImpl,
  body : @parameters_body_optionality.BodyModel,
) {
  guard body.name == "foo" else {
    fail("optional_explicit.set: body name mismatch, expected 'foo'")
  }
}

///|
impl @parameters_body_optionality.OptionalExplicitHandler for OptionalExplicitHandlerImpl with omit(
  _self : OptionalExplicitHandlerImpl,
  _body : @parameters_body_optionality.BodyModel,
) {
  // omit should receive undefined/empty body
  // In TypeScript: assert.isUndefined(options?.body)
  // The body may be empty or have default values in MoonBit
}
