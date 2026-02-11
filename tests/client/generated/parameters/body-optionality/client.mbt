///|
/// BodyOptionalityClient HTTP 客户端。
pub(all) struct BodyOptionalityClient {
  base_url : String
}

///|
/// 创建 BodyOptionalityClient。
pub fn BodyOptionalityClient::new(base_url : String) -> BodyOptionalityClient {
  { base_url, }
}

///|
/// 调用 post /parameters/body-optionality/required-explicit（自动解析响应）。
pub async fn BodyOptionalityClient::post_parameters_body_optionality_required_explicit(
  self : BodyOptionalityClient,
  body : BodyModel,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/parameters/body-optionality/required-explicit",
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
/// 调用 post /parameters/body-optionality/required-implicit（自动解析响应）。
pub async fn BodyOptionalityClient::post_parameters_body_optionality_required_implicit(
  self : BodyOptionalityClient,
  body : BodyModel1,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/parameters/body-optionality/required-implicit",
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
/// OptionalExplicitClient HTTP 客户端。
pub(all) struct OptionalExplicitClient {
  base_url : String
}

///|
/// 创建 OptionalExplicitClient。
pub fn OptionalExplicitClient::new(base_url : String) -> OptionalExplicitClient {
  { base_url, }
}

///|
/// 调用 post /parameters/body-optionality/optional-explicit/set（自动解析响应）。
pub async fn OptionalExplicitClient::post_parameters_body_optionality_optional_explicit_set(
  self : OptionalExplicitClient,
  body : BodyModel?,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/parameters/body-optionality/optional-explicit/set",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  if body is Some(body) {
    headers.set("content-type", "application/json")
    client.request(@http.Post, path, extra_headers=headers)
    client.write(body.to_json())
  } else {
    client.request(@http.Post, path, extra_headers=headers)
  }
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 post /parameters/body-optionality/optional-explicit/omit（自动解析响应）。
pub async fn OptionalExplicitClient::post_parameters_body_optionality_optional_explicit_omit(
  self : OptionalExplicitClient,
  body : BodyModel?,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/parameters/body-optionality/optional-explicit/omit",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  if body is Some(body) {
    headers.set("content-type", "application/json")
    client.request(@http.Post, path, extra_headers=headers)
    client.write(body.to_json())
  } else {
    client.request(@http.Post, path, extra_headers=headers)
  }
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
