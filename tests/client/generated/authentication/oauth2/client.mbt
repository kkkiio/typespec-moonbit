///|

///|
/// OAuth2Client HTTP 客户端。
pub(all) struct OAuth2Client {
  base_url : String
}

///|

///|
/// 创建 OAuth2Client。
pub fn OAuth2Client::new(base_url : String) -> OAuth2Client {
  { base_url, }
}

///|

///|
/// 调用 get /authentication/oauth2/valid（自动解析响应）。
pub async fn OAuth2Client::get_authentication_oauth2_valid(
  self : OAuth2Client,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/authentication/oauth2/valid")
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
/// 调用 get /authentication/oauth2/invalid（自动解析响应）。
pub async fn OAuth2Client::get_authentication_oauth2_invalid(
  self : OAuth2Client,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/authentication/oauth2/invalid",
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
