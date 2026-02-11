///|
/// VersionedClient HTTP 客户端。
pub(all) struct VersionedClient {
  base_url : String
}

///|
/// 创建 VersionedClient。
pub fn VersionedClient::new(base_url : String) -> VersionedClient {
  { base_url, }
}

///|
/// 调用 head /server/versions/versioned/without-api-version（自动解析响应）。
pub async fn VersionedClient::head_server_versions_versioned_without_api_version(
  self : VersionedClient,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/server/versions/versioned/without-api-version",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Head, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 head /server/versions/versioned/with-query-api-version{?api%2Dversion}（自动解析响应）。
pub async fn VersionedClient::head_server_versions_versioned_with_query_api_version__api_2dversion_(
  self : VersionedClient,
  api_2dversion : String,
  api_version : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=129)
  sb0.write_string("/server/versions/versioned/with-query-api-version")
  sb0.write_string(
    @runtime.expand_string("?", "api%2Dversion", false, api_2dversion),
  )
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let mut first_query = !base_path.contains("?")
  if first_query {
    sb.write_char('?')
    first_query = false
  } else {
    sb.write_char('&')
  }
  sb.write_string("api-version=")
  sb.write_string(@runtime.encode_query_component(api_version))
  let path = sb.to_string()
  client.request(@http.Head, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 head /server/versions/versioned/with-path-api-version/{apiVersion}（自动解析响应）。
pub async fn VersionedClient::head_server_versions_versioned_with_path_api_version__apiversion_(
  self : VersionedClient,
  apiversion : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=125)
  sb0.write_string("/server/versions/versioned/with-path-api-version/")
  sb0.write_string(@runtime.expand_string("", "apiVersion", false, apiversion))
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Head, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 head /server/versions/versioned/with-query-old-api-version{?api%2Dversion}（自动解析响应）。
pub async fn VersionedClient::head_server_versions_versioned_with_query_old_api_version__api_2dversion_(
  self : VersionedClient,
  api_2dversion : String,
  api_version : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=133)
  sb0.write_string("/server/versions/versioned/with-query-old-api-version")
  sb0.write_string(
    @runtime.expand_string("?", "api%2Dversion", false, api_2dversion),
  )
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let mut first_query = !base_path.contains("?")
  if first_query {
    sb.write_char('?')
    first_query = false
  } else {
    sb.write_char('&')
  }
  sb.write_string("api-version=")
  sb.write_string(@runtime.encode_query_component(api_version))
  let path = sb.to_string()
  client.request(@http.Head, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
