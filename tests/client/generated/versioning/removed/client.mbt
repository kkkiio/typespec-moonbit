///|

///|
/// RemovedClient HTTP 客户端。
pub(all) struct RemovedClient {
  base_url : String
}

///|

///|
/// 创建 RemovedClient。
pub fn RemovedClient::new(base_url : String) -> RemovedClient {
  { base_url, }
}

///|

///|
/// 调用 post /versioning/removed/api-version:{version}/v1（自动解析响应）。
pub async fn RemovedClient::post_versioning_removed_api_version__version__v1(
  self : RemovedClient,
  version : String,
  body : ModelV1,
) -> ModelV1 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=108)
  sb0.write_string("/versioning/removed/api-version:")
  sb0.write_string(@runtime.expand_string("", "version", false, version))
  sb0.write_string("/v1")
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
    let parsed : ModelV1 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /versioning/removed/api-version:{version}/v2{?param}（自动解析响应）。
pub async fn RemovedClient::post_versioning_removed_api_version__version__v2__param_(
  self : RemovedClient,
  version : String,
  param : String,
  body : ModelV2,
) -> ModelV2 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=116)
  sb0.write_string("/versioning/removed/api-version:")
  sb0.write_string(@runtime.expand_string("", "version", false, version))
  sb0.write_string("/v2")
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
    let parsed : ModelV2 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /versioning/removed/api-version:{version}/v3（自动解析响应）。
pub async fn RemovedClient::post_versioning_removed_api_version__version__v3(
  self : RemovedClient,
  version : String,
  body : ModelV3,
) -> ModelV3 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=108)
  sb0.write_string("/versioning/removed/api-version:")
  sb0.write_string(@runtime.expand_string("", "version", false, version))
  sb0.write_string("/v3")
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
    let parsed : ModelV3 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// InterfaceV1Client HTTP 客户端。
pub(all) struct InterfaceV1Client {
  base_url : String
}

///|

///|
/// 创建 InterfaceV1Client。
pub fn InterfaceV1Client::new(base_url : String) -> InterfaceV1Client {
  { base_url, }
}

///|

///|
/// 调用 post /versioning/removed/api-version:{version}/interface-v1/v1（自动解析响应）。
pub async fn InterfaceV1Client::post_versioning_removed_api_version__version__interface_v1_v1(
  self : InterfaceV1Client,
  version : String,
  body : ModelV1,
) -> ModelV1 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=121)
  sb0.write_string("/versioning/removed/api-version:")
  sb0.write_string(@runtime.expand_string("", "version", false, version))
  sb0.write_string("/interface-v1/v1")
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
    let parsed : ModelV1 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
