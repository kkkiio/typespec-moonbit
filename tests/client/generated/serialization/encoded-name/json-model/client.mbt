///|
/// PropertyClient HTTP 客户端。
pub(all) struct PropertyClient {
  base_url : String
}

///|
/// 创建 PropertyClient。
pub fn PropertyClient::new(base_url : String) -> PropertyClient {
  { base_url, }
}

///|
/// 调用 post /serialization/encoded-name/json/property（自动解析响应）。
pub async fn PropertyClient::post_serialization_encoded_name_json_property(
  self : PropertyClient,
  body : JsonEncodedNameModel,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/serialization/encoded-name/json/property",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /serialization/encoded-name/json/property（自动解析响应）。
pub async fn PropertyClient::get_serialization_encoded_name_json_property(
  self : PropertyClient,
) -> JsonEncodedNameModel {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/serialization/encoded-name/json/property",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : JsonEncodedNameModel = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
