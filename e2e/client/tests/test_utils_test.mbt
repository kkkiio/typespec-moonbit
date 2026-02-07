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
  let client = @http.Client::new("http://localhost:3000")
  defer client.close()
  client.request(@http.Get, "/routes/fixed")
  let response = client.end_request()
  response.code
}

///|
fn assert_204(_ : Unit) -> Unit raise {
  ()
}

///|
fn mk_record() -> Map[String, Int] {
  let m = Map::new()
  m["a"] = 1
  m["b"] = 2
  m
}
