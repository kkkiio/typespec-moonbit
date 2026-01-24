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
  { name: "abc", age: 32, smart: true }
}

///|
impl @type_model_inheritance_not_discriminated.NotDiscriminatedHandler for NotDiscriminatedHandlerImpl with post_valid(
  _self : NotDiscriminatedHandlerImpl,
  body : @type_model_inheritance_not_discriminated.Siamese,
) {
  // In TypeScript: assert.deepStrictEqual(input, { name: "abc", age: 32, smart: true })
  guard body.name == "abc" else {
    fail("post_valid: body.name should be 'abc'")
  }
  guard body.age == 32 else { fail("post_valid: body.age should be 32") }
  guard body.smart == true else {
    fail("post_valid: body.smart should be true")
  }
}

///|
impl @type_model_inheritance_not_discriminated.NotDiscriminatedHandler for NotDiscriminatedHandlerImpl with put_valid(
  _self : NotDiscriminatedHandlerImpl,
  body : @type_model_inheritance_not_discriminated.Siamese,
) {
  // In TypeScript: assert.deepStrictEqual(input, { name: "abc", age: 32, smart: true })
  // Should return: { name: "abc", age: 32, smart: true }
  guard body.name == "abc" else { fail("put_valid: body.name should be 'abc'") }
  guard body.age == 32 else { fail("put_valid: body.age should be 32") }
  guard body.smart == true else { fail("put_valid: body.smart should be true") }
  body
}
