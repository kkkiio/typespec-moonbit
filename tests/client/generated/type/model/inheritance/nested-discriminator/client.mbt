///|

///|
/// NestedDiscriminatorClient HTTP 客户端。
pub(all) struct NestedDiscriminatorClient {
  base_url : String
}

///|

///|
/// 创建 NestedDiscriminatorClient。
pub fn NestedDiscriminatorClient::new(
  base_url : String,
) -> NestedDiscriminatorClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/model/inheritance/nested-discriminator/model（自动解析响应）。
pub async fn NestedDiscriminatorClient::get_type_model_inheritance_nested_discriminator_model(
  self : NestedDiscriminatorClient,
) -> Fish {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/nested-discriminator/model",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Fish = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/model/inheritance/nested-discriminator/model（自动解析响应）。
pub async fn NestedDiscriminatorClient::put_type_model_inheritance_nested_discriminator_model(
  self : NestedDiscriminatorClient,
  body : Fish,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/nested-discriminator/model",
  )
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
/// 调用 get /type/model/inheritance/nested-discriminator/recursivemodel（自动解析响应）。
pub async fn NestedDiscriminatorClient::get_type_model_inheritance_nested_discriminator_recursivemodel(
  self : NestedDiscriminatorClient,
) -> Fish {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/nested-discriminator/recursivemodel",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Fish = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/model/inheritance/nested-discriminator/recursivemodel（自动解析响应）。
pub async fn NestedDiscriminatorClient::put_type_model_inheritance_nested_discriminator_recursivemodel(
  self : NestedDiscriminatorClient,
  body : Fish,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/nested-discriminator/recursivemodel",
  )
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
/// 调用 get /type/model/inheritance/nested-discriminator/missingdiscriminator（自动解析响应）。
pub async fn NestedDiscriminatorClient::get_type_model_inheritance_nested_discriminator_missingdiscriminator(
  self : NestedDiscriminatorClient,
) -> Fish {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/nested-discriminator/missingdiscriminator",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Fish = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/model/inheritance/nested-discriminator/wrongdiscriminator（自动解析响应）。
pub async fn NestedDiscriminatorClient::get_type_model_inheritance_nested_discriminator_wrongdiscriminator(
  self : NestedDiscriminatorClient,
) -> Fish {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/nested-discriminator/wrongdiscriminator",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Fish = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
