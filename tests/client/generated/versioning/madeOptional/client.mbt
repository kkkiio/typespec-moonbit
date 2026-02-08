///|

///|
/// MadeOptionalClient HTTP 客户端。
pub(all) struct MadeOptionalClient {
  base_url : String
}

///|

///|
/// 创建 MadeOptionalClient。
pub fn MadeOptionalClient::new(base_url : String) -> MadeOptionalClient {
  { base_url, }
}

///|

///|
/// 调用 post /versioning/made-optional/api-version:{version}/test{?param}（自动解析响应）。
pub async fn MadeOptionalClient::post_versioning_made_optional_api_version__version__test__param_(
  self : MadeOptionalClient,
  version : String,
  param : String,
  body : TestModel,
) -> TestModel {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=124)
  sb0.write_string("/versioning/made-optional/api-version:")
  sb0.write_string(@runtime.expand_string("", "version", false, version))
  sb0.write_string("/test")
  sb0.write_string(@runtime.expand_string("?", "param", false, param))
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
    let parsed : TestModel = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
