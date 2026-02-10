///|
/// Test for type/model/empty
/// Reference: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/model/empty/main.test.e2e.ts
async test "type/model/empty" {
  let empty_handler = EmptyHandlerImpl::{  }
  @async.with_task_group(group => {
    let router = @type_model_empty.create_router(empty_handler~, group~)
    let dispatch = @type_model_empty.create_dispatch(router)
    let base_url = @server.start_server(group, dispatch)
    let status = @server.run_scenario("type/model/empty/**/*", base_url)
    assert_true(status is @server.Status::Pass)
  })
}

///|
struct EmptyHandlerImpl {}

///|
impl @type_model_empty.EmptyHandler for EmptyHandlerImpl with put_empty(
  _self,
  group~,
  _body,
) {
  ignore(group)
  // In TypeScript: deepStrictEqual(input, {})
  // EmptyInput is an empty struct, so nothing to verify
}

///|
impl @type_model_empty.EmptyHandler for EmptyHandlerImpl with get_empty(
  _self,
  group~,
) {
  ignore(group)
  ignore(group)
  @type_model_empty.EmptyOutput::{  }
}

///|
impl @type_model_empty.EmptyHandler for EmptyHandlerImpl with post_round_trip_empty(
  _self,
  group~,
  body,
) {
  ignore(group)
  ignore(group)
  // Should return: { body }
  // EmptyInputOutput is an empty struct, round-trip the same empty object
  body
}
