///|

///|
/// MultipleClient HTTP 客户端。
pub(all) struct MultipleClient {
  base_url : String
}

///|

///|
/// 创建 MultipleClient。
pub fn MultipleClient::new(base_url : String) -> MultipleClient {
  { base_url, }
}

///|

///|
/// 调用 get /server/path/multiple/{apiVersion}（自动解析响应）。
pub async fn MultipleClient::get_server_path_multiple__apiversion_(
  self : MultipleClient,
  apiversion : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=98)
  sb0.write_string("/server/path/multiple/")
  sb0.write_string(@runtime.expand_string("", "apiVersion", false, apiversion))
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
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
/// 调用 get /server/path/multiple/{apiVersion}/{keyword}（自动解析响应）。
pub async fn MultipleClient::get_server_path_multiple__apiversion___keyword_(
  self : MultipleClient,
  apiversion : String,
  keyword : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=108)
  sb0.write_string("/server/path/multiple/")
  sb0.write_string(@runtime.expand_string("", "apiVersion", false, apiversion))
  sb0.write_string("/")
  sb0.write_string(@runtime.expand_string("", "keyword", false, keyword))
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
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
