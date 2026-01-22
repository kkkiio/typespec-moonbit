///|
/// Test for type/model/inheritance/not-discriminated
/// Reference: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/model/inheritance/not-discriminated/main.test.e2e.ts
async test "type/model/inheritance/not-discriminated" {
  let handler = NotDiscriminatedHandlerImpl::{  }
  let router = @type_model_inheritance_not_discriminated.create_router(handler)
  @async.with_task_group(fn(group) {
    let base_url = @server.start_server(group, router)
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
  _self : NotDiscriminatedHandlerImpl,
) {
  // Should return: { name: "abc", age: 32, smart: true }
  // TODO: implement response body
}

///|
impl @type_model_inheritance_not_discriminated.NotDiscriminatedHandler for NotDiscriminatedHandlerImpl with post_valid(
  _self : NotDiscriminatedHandlerImpl,
  body : @type_model_inheritance_not_discriminated.Siamese,
) {
  // In TypeScript: assert.deepStrictEqual(input, { name: "abc", age: 32, smart: true })
  // Note: The generated Siamese struct only has 'smart' field
  // The parent fields (name, age) should be inherited but may not be in generated code yet
  guard body.smart == "true" else {
    fail("post_valid: body.smart should be 'true'")
  }
}

///|
impl @type_model_inheritance_not_discriminated.NotDiscriminatedHandler for NotDiscriminatedHandlerImpl with put_valid(
  _self : NotDiscriminatedHandlerImpl,
  body : @type_model_inheritance_not_discriminated.Siamese,
) {
  // In TypeScript: assert.deepStrictEqual(input, { name: "abc", age: 32, smart: true })
  // Should return: { name: "abc", age: 32, smart: true }
  guard body.smart == "true" else {
    fail("put_valid: body.smart should be 'true'")
  }
  // TODO: implement response body
}
