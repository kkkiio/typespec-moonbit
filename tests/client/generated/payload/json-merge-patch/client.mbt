///|

///|
/// JsonMergePatchClient HTTP 客户端。
pub(all) struct JsonMergePatchClient {
  base_url : String
}

///|

///|
/// 创建 JsonMergePatchClient。
pub fn JsonMergePatchClient::new(base_url : String) -> JsonMergePatchClient {
  { base_url, }
}

///|

///|
/// 调用 put /json-merge-patch/create/resource（自动解析响应）。
pub async fn JsonMergePatchClient::put_json_merge_patch_create_resource(
  self : JsonMergePatchClient,
  body : Resource,
) -> Resource {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/json-merge-patch/create/resource",
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
    let parsed : Resource = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 patch /json-merge-patch/update/resource（自动解析响应）。
pub async fn JsonMergePatchClient::patch_json_merge_patch_update_resource(
  self : JsonMergePatchClient,
  content_type : String,
  body : ResourcePatch,
) -> Resource {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/json-merge-patch/update/resource",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", content_type)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Resource = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 patch /json-merge-patch/update/resource/optional（自动解析响应）。
pub async fn JsonMergePatchClient::patch_json_merge_patch_update_resource_optional(
  self : JsonMergePatchClient,
  content_type : String,
  body : ResourcePatch?,
) -> Resource {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/json-merge-patch/update/resource/optional",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", content_type)
  let path = sb.to_string()
  if body is Some(body) {
    headers.set("content-type", "application/json")
    client.request(@http.Patch, path, extra_headers=headers)
    client.write(body.to_json())
  } else {
    client.request(@http.Patch, path, extra_headers=headers)
  }
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Resource = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
