///|
/// Test for type/model/inheritance/recursive
/// Reference: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/model/inheritance/recursive/main.test.e2e.ts
async test "type/model/inheritance/recursive" {
  let handler = RecursiveHandlerImpl::{  }
  let router = @type_model_inheritance_recursive.create_router(handler)
  @async.with_task_group(fn(group) {
    let base_url = @server.start_server(group, router)
    let status = @server.run_scenario(
      "type/model/inheritance/recursive/**/*", base_url,
    )
    assert_true(status is @server.Status::Pass)
  })
}

///|
struct RecursiveHandlerImpl {}

///|
impl @type_model_inheritance_recursive.RecursiveHandler for RecursiveHandlerImpl with get(
  _self : RecursiveHandlerImpl,
) {
  // Should return:
  // {
  //   level: 0,
  //   extension: [
  //     {
  //       level: 1,
  //       extension: [
  //         {
  //           level: 2,
  //         },
  //       ],
  //     },
  //     {
  //       level: 1,
  //     },
  //   ],
  // }
  { level: 0, extension: @type_model_inheritance_recursive.Array::{  } }
}

///|
impl @type_model_inheritance_recursive.RecursiveHandler for RecursiveHandlerImpl with put(
  _self : RecursiveHandlerImpl,
  body : @type_model_inheritance_recursive.Extension,
) {
  // In TypeScript:
  // assert.deepStrictEqual(input, {
  //   level: 0,
  //   extension: [
  //     {
  //       level: 1,
  //       extension: [
  //         {
  //           level: 2,
  //         },
  //       ],
  //     },
  //     {
  //       level: 1,
  //     },
  //   ],
  // })
  guard body.level == 0 else { fail("put: body.level should be 0") }
}
