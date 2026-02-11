///|
/// AddedClient HTTP 客户端。
pub(all) struct AddedClient {
  base_url : String
}

///|
/// 创建 AddedClient。
pub fn AddedClient::new(base_url : String) -> AddedClient {
  { base_url, }
}

///|
/// 调用 post /versioning/added/api-version:{version}/v1（自动解析响应）。
pub async fn AddedClient::post_versioning_added_api_version__version__v1(
  self : AddedClient,
  version : String,
  header_v_2 : String,
  body : ModelV1,
) -> ModelV1 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=106)
  sb0.write_string("/versioning/added/api-version:")
  sb0.write_string(@runtime.expand_string("", "version", false, version))
  sb0.write_string("/v1")
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("header-v2", header_v_2)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ModelV1 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 post /versioning/added/api-version:{version}/v2（自动解析响应）。
pub async fn AddedClient::post_versioning_added_api_version__version__v2(
  self : AddedClient,
  version : String,
  body : ModelV2,
) -> ModelV2 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=106)
  sb0.write_string("/versioning/added/api-version:")
  sb0.write_string(@runtime.expand_string("", "version", false, version))
  sb0.write_string("/v2")
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
    let parsed : ModelV2 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// InterfaceV2Client HTTP 客户端。
pub(all) struct InterfaceV2Client {
  base_url : String
}

///|
/// 创建 InterfaceV2Client。
pub fn InterfaceV2Client::new(base_url : String) -> InterfaceV2Client {
  { base_url, }
}

///|
/// 调用 post /versioning/added/api-version:{version}/interface-v2/v2（自动解析响应）。
pub async fn InterfaceV2Client::post_versioning_added_api_version__version__interface_v2_v2(
  self : InterfaceV2Client,
  version : String,
  body : ModelV2,
) -> ModelV2 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=119)
  sb0.write_string("/versioning/added/api-version:")
  sb0.write_string(@runtime.expand_string("", "version", false, version))
  sb0.write_string("/interface-v2/v2")
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
    let parsed : ModelV2 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
