///|
/// BodyOptionalityClient HTTP 客户端。
pub struct BodyOptionalityClient {
  base_url : String
}

///|
/// 创建 BodyOptionalityClient。
pub fn BodyOptionalityClient::new(base_url : String) -> BodyOptionalityClient {
  { base_url, }
}

///|
/// 调用 post /parameters/body-optionality/required-explicit。
pub async fn BodyOptionalityClient::post_parameters_body_optionality_required_explicit(
  self : BodyOptionalityClient,
  body : BodyModel,
) -> @http.Response {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @client_runtime.encode_request_target(
    "/parameters/body-optionality/required-explicit",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
  client.write(body.to_json())
  client.end_request()
}

///|
/// 调用 post /parameters/body-optionality/required-implicit。
pub async fn BodyOptionalityClient::post_parameters_body_optionality_required_implicit(
  self : BodyOptionalityClient,
  body : BodyModel0,
) -> @http.Response {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @client_runtime.encode_request_target(
    "/parameters/body-optionality/required-implicit",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
  client.write(body.to_json())
  client.end_request()
}

///|
/// OptionalExplicitClient HTTP 客户端。
pub struct OptionalExplicitClient {
  base_url : String
}

///|
/// 创建 OptionalExplicitClient。
pub fn OptionalExplicitClient::new(base_url : String) -> OptionalExplicitClient {
  { base_url, }
}

///|
/// 调用 post /parameters/body-optionality/optional-explicit/set。
pub async fn OptionalExplicitClient::post_parameters_body_optionality_optional_explicit_set(
  self : OptionalExplicitClient,
  body : BodyModel?,
) -> @http.Response {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @client_runtime.encode_request_target(
    "/parameters/body-optionality/optional-explicit/set",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  if body is Some(body) {
    headers.set("content-type", "application/json")
    client.request(@http.Post, path, extra_headers=headers)
    client.write(body.to_json())
    client.end_request()
  } else {
    client.request(@http.Post, path, extra_headers=headers)
    client.end_request()
  }
}

///|
/// 调用 post /parameters/body-optionality/optional-explicit/omit。
pub async fn OptionalExplicitClient::post_parameters_body_optionality_optional_explicit_omit(
  self : OptionalExplicitClient,
  body : BodyModel?,
) -> @http.Response {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @client_runtime.encode_request_target(
    "/parameters/body-optionality/optional-explicit/omit",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  if body is Some(body) {
    headers.set("content-type", "application/json")
    client.request(@http.Post, path, extra_headers=headers)
    client.write(body.to_json())
    client.end_request()
  } else {
    client.request(@http.Post, path, extra_headers=headers)
    client.end_request()
  }
}
