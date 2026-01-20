///|
async test "parameters/basic" {
  let explicit = ParamBasicExplicit::{  }
  let implicit = ParamBasicImplicit::{  }
  let router = @parameters_basic.create_router(explicit, implicit)
  @async.with_task_group(fn(group) {
    let base_url = @server.start_server(group, fn(req, body, conn) {
      router.dispatch(req, body, conn)
    })
    let status = @server.run_scenario("parameters/basic/**/*", base_url)
    assert_true(status is @server.Status::Pass)
  })
}

///|
struct ParamBasicImplicit {}

///|
impl @parameters_basic.ImplicitBodyHandler for ParamBasicImplicit with simple(
  _self : ParamBasicImplicit,
  body : @parameters_basic.AnonymousModel1,
) {
  guard body.name == "foo" else { fail("implicit body name mismatch") }
}

///|
/// parameters/basic
struct ParamBasicExplicit {}

///|
impl @parameters_basic.ExplicitBodyHandler for ParamBasicExplicit with simple(
  _self : ParamBasicExplicit,
  body : @parameters_basic.User,
) {
  guard body.name == "foo" else { fail("explicit body name mismatch") }
}
