///|
/// SameBodyClient HTTP 客户端。
pub(all) struct SameBodyClient {
  base_url : String
}

///|
/// 创建 SameBodyClient。
pub fn SameBodyClient::new(base_url : String) -> SameBodyClient {
  { base_url, }
}

///|
/// 调用 get /content-negotiation/same-body（自动解析响应）。
pub async fn SameBodyClient::get_avatar_as_png(self : SameBodyClient) -> Bytes {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/content-negotiation/same-body",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("accept", "image/png")
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    let parsed = client.read_all().binary()
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /content-negotiation/same-body（自动解析响应）。
pub async fn SameBodyClient::get_avatar_as_jpeg(self : SameBodyClient) -> Bytes {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/content-negotiation/same-body",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("accept", "image/jpeg")
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    let parsed = client.read_all().binary()
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// DifferentBodyClient HTTP 客户端。
pub(all) struct DifferentBodyClient {
  base_url : String
}

///|
/// 创建 DifferentBodyClient。
pub fn DifferentBodyClient::new(base_url : String) -> DifferentBodyClient {
  { base_url, }
}

///|
/// 调用 get /content-negotiation/different-body（自动解析响应）。
pub async fn DifferentBodyClient::get_avatar_as_png(
  self : DifferentBodyClient,
) -> Bytes {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/content-negotiation/different-body",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("accept", "image/png")
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    let parsed = client.read_all().binary()
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /content-negotiation/different-body（自动解析响应）。
pub async fn DifferentBodyClient::get_avatar_as_json(
  self : DifferentBodyClient,
) -> PngImageAsJson {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/content-negotiation/different-body",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("accept", "application/json")
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : PngImageAsJson = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
