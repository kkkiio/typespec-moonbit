///|
/// Test for type/enum/extensible
/// Reference: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/enum/extensible/main.test.e2e.ts
async test "type/enum/extensible" {
  let string_handler = ExtensibleStringHandlerImpl::{  }
  @async.with_task_group(fn(group) {
    let router = @type_enum_extensible.create_router(string_handler~, group~)
    let dispatch = @type_enum_extensible.create_dispatch(router)
    let base_url = @server.start_server(group, dispatch)
    let status = @server.run_scenario("type/enum/extensible/**/*", base_url)
    assert_true(status is @server.Status::Pass)
  })
}

///|
struct ExtensibleStringHandlerImpl {}

///|
impl @type_enum_extensible.StringHandler for ExtensibleStringHandlerImpl with get_known_value(
  _self,
  group~,
) {
  ignore(group)
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
  group~,
) {
  ignore(group)
  // Should return:
  // {
  //   contentType: "application/json",
  //   body: "Weekend",
  // }
  ignore(group)
  "Weekend"
}

///|
impl @type_enum_extensible.StringHandler for ExtensibleStringHandlerImpl with put_known_value(
  _self,
  group~,
  _content_type,
  body,
) {
  ignore(group)
  ignore(group)
  // In TypeScript: assert.equal(body, "Monday")
  assert_eq(body, "Monday")
}

///|
impl @type_enum_extensible.StringHandler for ExtensibleStringHandlerImpl with put_unknown_value(
  _self,
  group~,
  _content_type,
  body,
) {
  ignore(group)
  ignore(group)
  // In TypeScript: assert.equal(body, "Weekend")
  assert_eq(body, "Weekend")
}
