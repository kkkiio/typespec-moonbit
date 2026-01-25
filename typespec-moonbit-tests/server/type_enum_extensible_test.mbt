///|
/// Test for type/enum/extensible
/// Reference: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/enum/extensible/main.test.e2e.ts
async test "type/enum/extensible" {
  let string_handler = ExtensibleStringHandlerImpl::{  }
  let router = @type_enum_extensible.create_router(string_handler~)
  @async.with_task_group(fn(group) {
    let base_url = @server.start_server(group, router)
    let status = @server.run_scenario("type/enum/extensible/**/*", base_url)
    assert_true(status is @server.Status::Pass)
  })
}

///|
struct ExtensibleStringHandlerImpl {}

///|
impl @type_enum_extensible.StringHandler for ExtensibleStringHandlerImpl with get_known_value(
  _self,
) {
  // Should return:
  // {
  //   contentType: "application/json",
  //   body: "Monday",
  // }
  "Monday"
}

///|
impl @type_enum_extensible.StringHandler for ExtensibleStringHandlerImpl with get_unknown_value(
  _self,
) {
  // Should return:
  // {
  //   contentType: "application/json",
  //   body: "Weekend",
  // }
  "Weekend"
}

///|
impl @type_enum_extensible.StringHandler for ExtensibleStringHandlerImpl with put_known_value(
  _self,
  _content_type,
  body,
) {
  // In TypeScript: assert.equal(body, "Monday")
  // The body is parsed as JSON string, so we need to check the value
  guard body.contains("Monday") else {
    fail("put_known_value: body should be 'Monday'")
  }
}

///|
impl @type_enum_extensible.StringHandler for ExtensibleStringHandlerImpl with put_unknown_value(
  _self,
  _content_type,
  body,
) {
  // In TypeScript: assert.equal(body, "Weekend")
  guard body.contains("Weekend") else {
    fail("put_unknown_value: body should be 'Weekend'")
  }
}
