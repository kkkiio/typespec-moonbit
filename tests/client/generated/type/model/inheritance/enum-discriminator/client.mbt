///|
/// EnumDiscriminatorClient HTTP 客户端。
pub(all) struct EnumDiscriminatorClient {
  base_url : String
}

///|
/// 创建 EnumDiscriminatorClient。
pub fn EnumDiscriminatorClient::new(
  base_url : String,
) -> EnumDiscriminatorClient {
  { base_url, }
}

///|
/// 调用 get /type/model/inheritance/enum-discriminator/extensible-enum（自动解析响应）。
pub async fn EnumDiscriminatorClient::get_type_model_inheritance_enum_discriminator_extensible_enum(
  self : EnumDiscriminatorClient,
) -> Dog {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/enum-discriminator/extensible-enum",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Dog = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/model/inheritance/enum-discriminator/extensible-enum（自动解析响应）。
pub async fn EnumDiscriminatorClient::put_type_model_inheritance_enum_discriminator_extensible_enum(
  self : EnumDiscriminatorClient,
  body : Dog,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/enum-discriminator/extensible-enum",
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
/// 调用 get /type/model/inheritance/enum-discriminator/extensible-enum/missingdiscriminator（自动解析响应）。
pub async fn EnumDiscriminatorClient::get_type_model_inheritance_enum_discriminator_extensible_enum_missingdiscriminator(
  self : EnumDiscriminatorClient,
) -> Dog {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/enum-discriminator/extensible-enum/missingdiscriminator",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Dog = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /type/model/inheritance/enum-discriminator/extensible-enum/wrongdiscriminator（自动解析响应）。
pub async fn EnumDiscriminatorClient::get_type_model_inheritance_enum_discriminator_extensible_enum_wrongdiscriminator(
  self : EnumDiscriminatorClient,
) -> Dog {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/enum-discriminator/extensible-enum/wrongdiscriminator",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Dog = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /type/model/inheritance/enum-discriminator/fixed-enum（自动解析响应）。
pub async fn EnumDiscriminatorClient::get_type_model_inheritance_enum_discriminator_fixed_enum(
  self : EnumDiscriminatorClient,
) -> Snake {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/enum-discriminator/fixed-enum",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Snake = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/model/inheritance/enum-discriminator/fixed-enum（自动解析响应）。
pub async fn EnumDiscriminatorClient::put_type_model_inheritance_enum_discriminator_fixed_enum(
  self : EnumDiscriminatorClient,
  body : Snake,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/enum-discriminator/fixed-enum",
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
/// 调用 get /type/model/inheritance/enum-discriminator/fixed-enum/missingdiscriminator（自动解析响应）。
pub async fn EnumDiscriminatorClient::get_type_model_inheritance_enum_discriminator_fixed_enum_missingdiscriminator(
  self : EnumDiscriminatorClient,
) -> Snake {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/enum-discriminator/fixed-enum/missingdiscriminator",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Snake = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /type/model/inheritance/enum-discriminator/fixed-enum/wrongdiscriminator（自动解析响应）。
pub async fn EnumDiscriminatorClient::get_type_model_inheritance_enum_discriminator_fixed_enum_wrongdiscriminator(
  self : EnumDiscriminatorClient,
) -> Snake {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/inheritance/enum-discriminator/fixed-enum/wrongdiscriminator",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Snake = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
