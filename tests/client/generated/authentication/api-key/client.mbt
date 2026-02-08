///|

///|
/// ApiKeyClient HTTP 客户端。
pub(all) struct ApiKeyClient {
  base_url : String
}

///|

///|
/// 创建 ApiKeyClient。
pub fn ApiKeyClient::new(base_url : String) -> ApiKeyClient {
  { base_url, }
}

///|

///|
/// 调用 get /authentication/api-key/valid（自动解析响应）。
pub async fn ApiKeyClient::get_authentication_api_key_valid(
  self : ApiKeyClient,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/authentication/api-key/valid",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /authentication/api-key/invalid（自动解析响应）。
pub async fn ApiKeyClient::get_authentication_api_key_invalid(
  self : ApiKeyClient,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/authentication/api-key/invalid",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
