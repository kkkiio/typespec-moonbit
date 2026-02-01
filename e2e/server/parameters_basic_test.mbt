///|
async test "parameters/basic" {
  let explicit = ParamBasicExplicit::{  }
  let implicit = ParamBasicImplicit::{  }
  @async.with_task_group(fn(group) {
    let router = @parameters_basic.create_router(
      explicit_body_handler=explicit,
      implicit_body_handler=implicit,
      group~,
    )
    let dispatch = @parameters_basic.create_dispatch(router)
    let base_url = @server.start_server(group, dispatch)
    let status = @server.run_scenario("parameters/basic/**/*", base_url)
    assert_true(status is @server.Status::Pass)
  })
}

///|
struct ParamBasicImplicit {}

///|
impl @parameters_basic.ImplicitBodyHandler for ParamBasicImplicit with simple(
  _self,
  group~,
  body,
) {
  assert_eq(body.name, "foo")
}

///|
/// parameters/basic
struct ParamBasicExplicit {}

///|
impl @parameters_basic.ExplicitBodyHandler for ParamBasicExplicit with simple(
  _self,
  group~,
  body,
) {
  assert_eq(body.name, "foo")
}
