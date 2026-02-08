///|
/// Test for type/model/inheritance/recursive
/// Reference: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/model/inheritance/recursive/main.test.e2e.ts
async test "type/model/inheritance/recursive" {
  let handler = RecursiveHandlerImpl::{  }
  @async.with_task_group(fn(group) {
    let router = @type_model_inheritance_recursive.create_router(
      recursive_handler=handler,
      group~,
    )
    let dispatch = @type_model_inheritance_recursive.create_dispatch(router)
    let base_url = @server.start_server(group, dispatch)
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
  _self,
  group~,
) {
  ignore(group)
  let leaf : @type_model_inheritance_recursive.Extension = {
    level: 2,
    extension: None,
  }
  let inner = Array::new(capacity=1)
  inner.push(leaf)
  let child0 : @type_model_inheritance_recursive.Extension = {
    level: 1,
    extension: Some(inner),
  }
  let child1 : @type_model_inheritance_recursive.Extension = {
    level: 1,
    extension: None,
  }
  let top = Array::new(capacity=2)
  top.push(child0)
  top.push(child1)
  { level: 0, extension: Some(top) }
}

///|
impl @type_model_inheritance_recursive.RecursiveHandler for RecursiveHandlerImpl with put(
  _self,
  group~,
  body,
) {
  ignore(group)
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
  match body.extension {
    None => fail("put: body.extension should exist")
    Some(top) => {
      guard top.length() == 2 else {
        fail("put: body.extension length should be 2")
      }
      let c0 = top[0]
      let c1 = top[1]
      guard c0.level == 1 else { fail("put: child0.level should be 1") }
      guard c1.level == 1 else { fail("put: child1.level should be 1") }
      match c0.extension {
        None => fail("put: child0.extension should exist")
        Some(inner) => {
          guard inner.length() == 1 else {
            fail("put: child0.extension length should be 1")
          }
          let leaf = inner[0]
          guard leaf.level == 2 else { fail("put: leaf.level should be 2") }
          guard leaf.extension is None else {
            fail("put: leaf.extension should be missing")
          }
        }
      }
      guard c1.extension is None else {
        fail("put: child1.extension should be missing")
      }
    }
  }
}
