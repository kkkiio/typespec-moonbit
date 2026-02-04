///|
/// e2e/client 测试公共工具。

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
  let client = @routes.RoutesClient::new("http://localhost:3000")
  let response = client.get_routes_fixed()
  response.code
}

///|
fn assert_204(response : @http.Response) -> Unit raise {
  assert_eq(response.code, 204)
}

///|
fn mk_record() -> Map[String, Int] {
  let m = Map::new()
  m["a"] = 1
  m["b"] = 2
  m
}
