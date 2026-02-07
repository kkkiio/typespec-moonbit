///|

///|
/// ConditionalRequestClient HTTP 客户端。
pub(all) struct ConditionalRequestClient {
  base_url : String
}

///|

///|
/// 创建 ConditionalRequestClient。
pub fn ConditionalRequestClient::new(
  base_url : String,
) -> ConditionalRequestClient {
  { base_url, }
}

///|

///|
/// 调用 post /special-headers/conditional-request/if-match（自动解析响应）。
pub async fn ConditionalRequestClient::post_special_headers_conditional_request_if_match(
  self : ConditionalRequestClient,
  if_match : String?,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/special-headers/conditional-request/if-match",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  if if_match is Some(v) {
    headers.set("If-Match", v)
  }
  let path = sb.to_string()
  client.request(@http.Post, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /special-headers/conditional-request/if-none-match（自动解析响应）。
pub async fn ConditionalRequestClient::post_special_headers_conditional_request_if_none_match(
  self : ConditionalRequestClient,
  if_none_match : String?,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/special-headers/conditional-request/if-none-match",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  if if_none_match is Some(v) {
    headers.set("If-None-Match", v)
  }
  let path = sb.to_string()
  client.request(@http.Post, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 head /special-headers/conditional-request/if-modified-since（自动解析响应）。
pub async fn ConditionalRequestClient::head_special_headers_conditional_request_if_modified_since(
  self : ConditionalRequestClient,
  if_modified_since : String?,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/special-headers/conditional-request/if-modified-since",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  if if_modified_since is Some(v) {
    headers.set("If-Modified-Since", v)
  }
  let path = sb.to_string()
  client.request(@http.Head, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /special-headers/conditional-request/if-unmodified-since（自动解析响应）。
pub async fn ConditionalRequestClient::post_special_headers_conditional_request_if_unmodified_since(
  self : ConditionalRequestClient,
  if_unmodified_since : String?,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/special-headers/conditional-request/if-unmodified-since",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  if if_unmodified_since is Some(v) {
    headers.set("If-Unmodified-Since", v)
  }
  let path = sb.to_string()
  client.request(@http.Post, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
