///|
/// RenamedFromClient HTTP 客户端。
pub(all) struct RenamedFromClient {
  base_url : String
}

///|
/// 创建 RenamedFromClient。
pub fn RenamedFromClient::new(base_url : String) -> RenamedFromClient {
  { base_url, }
}

///|
/// 调用 post /versioning/renamed-from/api-version:{version}/test{?newQuery}（自动解析响应）。
pub async fn RenamedFromClient::post_versioning_renamed_from_api_version__version__test__newquery_(
  self : RenamedFromClient,
  version : String,
  newquery : String,
  body : NewModel,
) -> NewModel {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=126)
  sb0.write_string("/versioning/renamed-from/api-version:")
  sb0.write_string(@runtime.expand_string("", "version", false, version))
  sb0.write_string("/test")
  sb0.write_string(@runtime.expand_string("?", "newQuery", false, newquery))
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : NewModel = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// NewInterfaceClient HTTP 客户端。
pub(all) struct NewInterfaceClient {
  base_url : String
}

///|
/// 创建 NewInterfaceClient。
pub fn NewInterfaceClient::new(base_url : String) -> NewInterfaceClient {
  { base_url, }
}

///|
/// 调用 post /versioning/renamed-from/api-version:{version}/interface/test（自动解析响应）。
pub async fn NewInterfaceClient::post_versioning_renamed_from_api_version__version__interface_test(
  self : NewInterfaceClient,
  version : String,
  body : NewModel,
) -> NewModel {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=125)
  sb0.write_string("/versioning/renamed-from/api-version:")
  sb0.write_string(@runtime.expand_string("", "version", false, version))
  sb0.write_string("/interface/test")
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : NewModel = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
