///|

///|
/// PropertyClient HTTP 客户端。
pub(all) struct PropertyClient {
  base_url : String
}

///|

///|
/// 创建 PropertyClient。
pub fn PropertyClient::new(base_url : String) -> PropertyClient {
  { base_url, }
}

///|

///|
/// 调用 post /encode/numeric/property/safeint（自动解析响应）。
pub async fn PropertyClient::post_encode_numeric_property_safeint(
  self : PropertyClient,
  body : SafeintAsStringProperty,
) -> SafeintAsStringProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/numeric/property/safeint",
  )
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
    let parsed : SafeintAsStringProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/numeric/property/uint32（自动解析响应）。
pub async fn PropertyClient::post_encode_numeric_property_uint32(
  self : PropertyClient,
  body : Uint32AsStringProperty,
) -> Uint32AsStringProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/numeric/property/uint32",
  )
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
    let parsed : Uint32AsStringProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/numeric/property/uint8（自动解析响应）。
pub async fn PropertyClient::post_encode_numeric_property_uint8(
  self : PropertyClient,
  body : Uint8AsStringProperty,
) -> Uint8AsStringProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/numeric/property/uint8",
  )
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
    let parsed : Uint8AsStringProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
