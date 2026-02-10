///|
/// Test for type/model/inheritance/not-discriminated
/// Reference: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/model/inheritance/not-discriminated/main.test.e2e.ts
async test "type/model/inheritance/not-discriminated" {
  let handler = NotDiscriminatedHandlerImpl::{  }
  @async.with_task_group(group => {
    let router = @type_model_inheritance_not_discriminated.create_router(
      not_discriminated_handler=handler,
      group~,
    )
    let dispatch = @type_model_inheritance_not_discriminated.create_dispatch(
      router,
    )
    let base_url = @server.start_server(group, dispatch)
    let status = @server.run_scenario(
      "type/model/inheritance/notdiscriminated/**/*", base_url,
    )
    assert_true(status is @server.Status::Pass)
  })
}

///|
struct NotDiscriminatedHandlerImpl {}

///|
impl @type_model_inheritance_not_discriminated.NotDiscriminatedHandler for NotDiscriminatedHandlerImpl with get_valid(
  _self,
  group~,
) {
  ignore(group)
  // Should return: { name: "abc", age: 32, smart: true }
  { name: "abc", age: 32, smart: true }
}

///|
impl @type_model_inheritance_not_discriminated.NotDiscriminatedHandler for NotDiscriminatedHandlerImpl with post_valid(
  _self,
  group~,
  body,
) {
  ignore(group)
  // In TypeScript: assert.deepStrictEqual(input, { name: "abc", age: 32, smart: true })
  assert_eq(body.name, "abc")
  assert_eq(body.age, 32)
  assert_eq(body.smart, true)
}

///|
impl @type_model_inheritance_not_discriminated.NotDiscriminatedHandler for NotDiscriminatedHandlerImpl with put_valid(
  _self,
  group~,
  body,
) {
  ignore(group)
  // In TypeScript: assert.deepStrictEqual(input, { name: "abc", age: 32, smart: true })
  // Should return: { name: "abc", age: 32, smart: true }
  assert_eq(body.name, "abc")
  assert_eq(body.age, 32)
  assert_eq(body.smart, true)
  body
}
