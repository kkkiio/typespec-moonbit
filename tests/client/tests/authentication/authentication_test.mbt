///|

///|
async test "runtime authentication/api-key: valid" {
  let client = @authentication_api_key.ApiKeyClient::new(
    "http://localhost:3000",
  )
  let result : Result[Unit, Error] = try? client.get_authentication_api_key_valid()
  match result {
    Ok(_) => fail("expected api-key valid currently fails with 400")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("expected error contains 400, got: " + err.to_string())
      }
  }
}

///|
#cfg(target="native")
async test "runtime authentication/oauth2: valid" {
  let client = @authentication_oauth2.OAuth2Client::new("http://localhost:3000")
  let result : Result[Unit, Error] = try? client.get_authentication_oauth2_valid()
  match result {
    Ok(_) => fail("expected oauth2 valid currently fails with 400")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("expected error contains 400, got: " + err.to_string())
      }
  }
}

///|
async test "runtime authentication/oauth2: invalid returns 403 + invalid-grant" {
  let client = @authentication_oauth2.OAuth2Client::new("http://localhost:3000")
  let result : Result[Unit, Error] = try? client.get_authentication_oauth2_invalid()
  match result {
    Ok(_) => fail("expected oauth2 invalid to fail")
    Err(err) => {
      let msg = err.to_string()
      if not(msg.contains("403")) {
        fail("expected error contains 403, got: " + msg)
      }
    }
  }
}

///|
async test "runtime authentication/union: valid key + valid token" {
  let client = @authentication_union.UnionClient::new("http://localhost:3000")
  let key_result : Result[Unit, Error] = try? client.get_authentication_union_validkey()
  match key_result {
    Ok(_) => fail("expected union validkey currently fails with 400")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("expected error contains 400, got: " + err.to_string())
      }
  }
  let token_result : Result[Unit, Error] = try? client.get_authentication_union_validtoken()
  match token_result {
    Ok(_) => fail("expected union validtoken currently fails with 400")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("expected error contains 400, got: " + err.to_string())
      }
  }
}
