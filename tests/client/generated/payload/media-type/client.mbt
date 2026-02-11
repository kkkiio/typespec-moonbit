///|
/// StringBodyClient HTTP 客户端。
pub(all) struct StringBodyClient {
  base_url : String
}

///|
/// 创建 StringBodyClient。
pub fn StringBodyClient::new(base_url : String) -> StringBodyClient {
  { base_url, }
}

///|
/// 调用 post /payload/media-type/string-body/sendAsText（自动解析响应）。
pub async fn StringBodyClient::post_payload_media_type_string_body_sendastext(
  self : StringBodyClient,
  body : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/media-type/string-body/sendAsText",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "text/plain")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 200 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /payload/media-type/string-body/getAsText（自动解析响应）。
pub async fn StringBodyClient::get_payload_media_type_string_body_getastext(
  self : StringBodyClient,
) -> String {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/media-type/string-body/getAsText",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
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

///|
/// 调用 post /payload/media-type/string-body/sendAsJson（自动解析响应）。
pub async fn StringBodyClient::post_payload_media_type_string_body_sendasjson(
  self : StringBodyClient,
  body : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/media-type/string-body/sendAsJson",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 200 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /payload/media-type/string-body/getAsJson（自动解析响应）。
pub async fn StringBodyClient::get_payload_media_type_string_body_getasjson(
  self : StringBodyClient,
) -> String {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/media-type/string-body/getAsJson",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
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
