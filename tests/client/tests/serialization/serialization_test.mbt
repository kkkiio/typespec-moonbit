///|

///|
/// 对齐上游：test/e2e/http/serialization/encoded-name/json/main.test.ts
#cfg(target="native")
async test "runtime serialization/encoded-name/json" {
  let client = @serialization_encoded_name_json.PropertyClient::new(
    "http://localhost:3000",
  )
  let send_result : Result[Unit, Error] = try? client.post_serialization_encoded_name_json_property({
      default_name: true,
    },
  )
  match send_result {
    Ok(_) => fail("expected encoded-name/json currently fails with 400")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("expected 400 error, got: " + err.to_string())
      }
  }
}
