///|

///|
/// 对齐上游：test/e2e/http/serialization/encoded-name/json/main.test.ts
#cfg(target="native")
async test "runtime serialization/encoded-name/json send" {
  let client = @serialization_encoded_name_json.PropertyClient::new(
    "http://localhost:3000",
  )
  let send_result : Result[Unit, Error] = try? client.post_serialization_encoded_name_json_property({
      default_name: true,
    },
  )
  assert_true(send_result is Ok(_))
}

///|
/// 对齐上游：test/e2e/http/serialization/encoded-name/json/main.test.ts
#cfg(target="native")
async test "runtime serialization/encoded-name/json get" {
  let client = @serialization_encoded_name_json.PropertyClient::new(
    "http://localhost:3000",
  )
  let get_result : Result[
    @serialization_encoded_name_json.JsonEncodedNameModel,
    Error,
  ] = try? client.get_serialization_encoded_name_json_property()
  match get_result {
    Ok(model) => assert_eq(model.default_name, true)
    Err(err) => fail("expected get success, got: " + err.to_string())
  }
}
