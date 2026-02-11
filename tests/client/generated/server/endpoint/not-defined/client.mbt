///|
/// NotDefinedClient HTTP 客户端。
pub(all) struct NotDefinedClient {
  base_url : String
}

///|
/// 创建 NotDefinedClient。
pub fn NotDefinedClient::new(base_url : String) -> NotDefinedClient {
  { base_url, }
}

///|
/// 调用 head /server/endpoint/not-defined/valid（自动解析响应）。
pub async fn NotDefinedClient::head_server_endpoint_not_defined_valid(
  self : NotDefinedClient,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/server/endpoint/not-defined/valid",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Head, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
