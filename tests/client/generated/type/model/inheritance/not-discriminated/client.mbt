///|
/// NotDiscriminatedClient HTTP 客户端。
pub(all) struct NotDiscriminatedClient {
  base_url : String
}

///|
/// 创建 NotDiscriminatedClient。
pub fn NotDiscriminatedClient::new(base_url : String) -> NotDiscriminatedClient {
  { base_url, }
}

///|
/// 调用 post /type/model/inheritance/not-discriminated/valid（自动解析响应）。
pub async fn NotDiscriminatedClient::post_type_model_inheritance_not_discriminated_valid(
  self : NotDiscriminatedClient,
  body : Siamese,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/not-discriminated/valid",
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
/// 调用 get /type/model/inheritance/not-discriminated/valid（自动解析响应）。
pub async fn NotDiscriminatedClient::get_type_model_inheritance_not_discriminated_valid(
  self : NotDiscriminatedClient,
) -> Siamese {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/not-discriminated/valid",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Siamese = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/model/inheritance/not-discriminated/valid（自动解析响应）。
pub async fn NotDiscriminatedClient::put_type_model_inheritance_not_discriminated_valid(
  self : NotDiscriminatedClient,
  body : Siamese,
) -> Siamese {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/not-discriminated/valid",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Siamese = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
