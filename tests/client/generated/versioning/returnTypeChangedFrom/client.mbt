///|
/// ReturnTypeChangedFromClient HTTP 客户端。
pub(all) struct ReturnTypeChangedFromClient {
  base_url : String
}

///|
/// 创建 ReturnTypeChangedFromClient。
pub fn ReturnTypeChangedFromClient::new(
  base_url : String,
) -> ReturnTypeChangedFromClient {
  { base_url, }
}

///|
/// 调用 post /versioning/return-type-changed-from/api-version:{version}/test（自动解析响应）。
pub async fn ReturnTypeChangedFromClient::post_versioning_return_type_changed_from_api_version__version__test(
  self : ReturnTypeChangedFromClient,
  version : String,
  body : String,
) -> String {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=127)
  sb0.write_string("/versioning/return-type-changed-from/api-version:")
  sb0.write_string(@runtime.expand_string("", "version", false, version))
  sb0.write_string("/test")
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : String = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
