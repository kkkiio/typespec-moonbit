///|

///|
/// SingleClient HTTP 客户端。
pub(all) struct SingleClient {
  base_url : String
}

///|

///|
/// 创建 SingleClient。
pub fn SingleClient::new(base_url : String) -> SingleClient {
  { base_url, }
}

///|

///|
/// 调用 head /server/path/single/myOp（自动解析响应）。
pub async fn SingleClient::head_server_path_single_myop(
  self : SingleClient,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/server/path/single/myOp")
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
