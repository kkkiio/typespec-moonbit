///|
/// UnionClient HTTP 客户端。
pub(all) struct UnionClient {
  base_url : String
}

///|
/// 创建 UnionClient。
pub fn UnionClient::new(base_url : String) -> UnionClient {
  { base_url, }
}

///|
/// 调用 get /authentication/union/validkey（自动解析响应）。
pub async fn UnionClient::get_authentication_union_validkey(
  self : UnionClient,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/authentication/union/validkey",
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
/// 调用 get /authentication/union/validtoken（自动解析响应）。
pub async fn UnionClient::get_authentication_union_validtoken(
  self : UnionClient,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/authentication/union/validtoken",
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
