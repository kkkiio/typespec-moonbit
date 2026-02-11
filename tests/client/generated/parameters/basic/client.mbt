///|
/// ExplicitBodyClient HTTP 客户端。
pub(all) struct ExplicitBodyClient {
  base_url : String
}

///|
/// 创建 ExplicitBodyClient。
pub fn ExplicitBodyClient::new(base_url : String) -> ExplicitBodyClient {
  { base_url, }
}

///|
/// 调用 put /parameters/basic/explicit-body/simple（自动解析响应）。
pub async fn ExplicitBodyClient::put_parameters_basic_explicit_body_simple(
  self : ExplicitBodyClient,
  body : User,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/parameters/basic/explicit-body/simple",
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
/// ImplicitBodyClient HTTP 客户端。
pub(all) struct ImplicitBodyClient {
  base_url : String
}

///|
/// 创建 ImplicitBodyClient。
pub fn ImplicitBodyClient::new(base_url : String) -> ImplicitBodyClient {
  { base_url, }
}

///|
/// 调用 put /parameters/basic/implicit-body/simple（自动解析响应）。
pub async fn ImplicitBodyClient::put_parameters_basic_implicit_body_simple(
  self : ImplicitBodyClient,
  body : Model,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/parameters/basic/implicit-body/simple",
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
