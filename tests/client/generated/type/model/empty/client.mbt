///|

///|
/// EmptyClient HTTP 客户端。
pub(all) struct EmptyClient {
  base_url : String
}

///|

///|
/// 创建 EmptyClient。
pub fn EmptyClient::new(base_url : String) -> EmptyClient {
  { base_url, }
}

///|

///|
/// 调用 put /type/model/empty/alone（自动解析响应）。
pub async fn EmptyClient::put_type_model_empty_alone(
  self : EmptyClient,
  body : EmptyInput,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/model/empty/alone")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/model/empty/alone（自动解析响应）。
pub async fn EmptyClient::get_type_model_empty_alone(
  self : EmptyClient,
) -> EmptyOutput {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/model/empty/alone")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : EmptyOutput = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /type/model/empty/round-trip（自动解析响应）。
pub async fn EmptyClient::post_type_model_empty_round_trip(
  self : EmptyClient,
  body : EmptyInputOutput,
) -> EmptyInputOutput {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/model/empty/round-trip")
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
    let parsed : EmptyInputOutput = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
