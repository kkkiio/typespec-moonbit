///|
/// 运行时验证：spector routes。
#cfg(target="native")
async test "runtime routes" {
  // 注意：本测试假设 tsp-spector server 已在本机启动（localhost:3000）。
  // 启动方式对齐 typespec-rust：
  //   npm run spector -- --start
  // 结束后：
  //   npm run spector -- --stop
  wait_server_ready()
  let client = @routes.ROUTESCLIENT::new("http://localhost:3000")
  let response = client.get_routes_fixed()
  assert_eq(response.code, 204)
  let response = client.get_routes_in_interface_fixed()
  assert_eq(response.code, 204)
  let response = client.get_routes_path_template_only__param_("a")
  assert_eq(response.code, 204)
  let response = client.get_routes_path_explicit__param_("a")
  assert_eq(response.code, 204)
  let response = client.get_routes_path_annotation_only__param_("a")
  assert_eq(response.code, 204)

  // 关键：reserved expansion 不应编码 '/'，但应编码空格 -> %20。
  let response = client.get_routes_path_reserved_expansion_template___param_(
    "foo/bar baz",
  )
  assert_eq(response.code, 204)
  let response = client.get_routes_path_reserved_expansion_annotation___param_(
    "foo/bar baz",
  )
  assert_eq(response.code, 204)
}

///|
async fn wait_server_ready() -> Unit {
  let mut last_error = ""
  for _ in 0..<20 {
    let result : Result[Int, Error] = try? probe_status()
    match result {
      Ok(code) if code >= 200 => return
      Ok(code) => last_error = "unexpected code: \{code}"
      Err(err) => last_error = err.to_string()
    }
    @async.sleep(200)
  }
  fail("spector server 未就绪: " + last_error)
}

///|
async fn probe_status() -> Int {
  let client = @routes.ROUTESCLIENT::new("http://localhost:3000")
  let response = client.get_routes_fixed()
  response.code
}
