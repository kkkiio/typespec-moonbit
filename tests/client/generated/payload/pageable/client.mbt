///|

///|
/// ServerDrivenPaginationClient HTTP 客户端。
pub(all) struct ServerDrivenPaginationClient {
  base_url : String
}

///|

///|
/// 创建 ServerDrivenPaginationClient。
pub fn ServerDrivenPaginationClient::new(
  base_url : String,
) -> ServerDrivenPaginationClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/pageable/server-driven-pagination/link（自动解析响应）。
pub async fn ServerDrivenPaginationClient::get_payload_pageable_server_driven_pagination_link(
  self : ServerDrivenPaginationClient,
) -> Model0 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/pageable/server-driven-pagination/link",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model0 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /payload/pageable/server-driven-pagination/link-string（自动解析响应）。
pub async fn ServerDrivenPaginationClient::get_payload_pageable_server_driven_pagination_link_string(
  self : ServerDrivenPaginationClient,
) -> Model2 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/pageable/server-driven-pagination/link-string",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model2 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /payload/pageable/server-driven-pagination/nested-link（自动解析响应）。
pub async fn ServerDrivenPaginationClient::get_payload_pageable_server_driven_pagination_nested_link(
  self : ServerDrivenPaginationClient,
) -> Model3 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/pageable/server-driven-pagination/nested-link",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model3 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// ContinuationTokenClient HTTP 客户端。
pub(all) struct ContinuationTokenClient {
  base_url : String
}

///|

///|
/// 创建 ContinuationTokenClient。
pub fn ContinuationTokenClient::new(
  base_url : String,
) -> ContinuationTokenClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/pageable/server-driven-pagination/continuationtoken/request-query-response-body{?token,bar}（自动解析响应）。
pub async fn ContinuationTokenClient::get_payload_pageable_server_driven_pagination_continuationtoken_request_query_response_body__token_bar_(
  self : ContinuationTokenClient,
  token : String,
  foo : String?,
  bar : String?,
) -> Model9 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=164)
  sb0.write_string(
    "/payload/pageable/server-driven-pagination/continuationtoken/request-query-response-body",
  )
  sb0.write_string(@runtime.expand_string("?", "token", false, token))
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let mut first_query = !base_path.contains("?")
  if foo is Some(v) {
    headers.set("foo", v)
  }
  if bar is Some(v) {
    if first_query {
      sb.write_char('?')
      first_query = false
    } else {
      sb.write_char('&')
    }
    sb.write_string("bar=")
    sb.write_string(@runtime.encode_query_component(v))
  }
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model9 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /payload/pageable/server-driven-pagination/continuationtoken/request-header-response-body{?bar}（自动解析响应）。
pub async fn ContinuationTokenClient::get_payload_pageable_server_driven_pagination_continuationtoken_request_header_response_body__bar_(
  self : ContinuationTokenClient,
  bar : String,
  token : String?,
  foo : String?,
) -> Model7 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=159)
  sb0.write_string(
    "/payload/pageable/server-driven-pagination/continuationtoken/request-header-response-body",
  )
  sb0.write_string(@runtime.expand_string("?", "bar", false, bar))
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  if token is Some(v) {
    headers.set("token", v)
  }
  if foo is Some(v) {
    headers.set("foo", v)
  }
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model7 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /payload/pageable/server-driven-pagination/continuationtoken/request-query-response-header{?token,bar}（自动解析响应）。
pub async fn ContinuationTokenClient::get_payload_pageable_server_driven_pagination_continuationtoken_request_query_response_header__token_bar_(
  self : ContinuationTokenClient,
  token : String,
  foo : String?,
  bar : String?,
) -> Model10 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=166)
  sb0.write_string(
    "/payload/pageable/server-driven-pagination/continuationtoken/request-query-response-header",
  )
  sb0.write_string(@runtime.expand_string("?", "token", false, token))
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let mut first_query = !base_path.contains("?")
  if foo is Some(v) {
    headers.set("foo", v)
  }
  if bar is Some(v) {
    if first_query {
      sb.write_char('?')
      first_query = false
    } else {
      sb.write_char('&')
    }
    sb.write_string("bar=")
    sb.write_string(@runtime.encode_query_component(v))
  }
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model10 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /payload/pageable/server-driven-pagination/continuationtoken/request-header-response-header{?bar}（自动解析响应）。
pub async fn ContinuationTokenClient::get_payload_pageable_server_driven_pagination_continuationtoken_request_header_response_header__bar_(
  self : ContinuationTokenClient,
  bar : String,
  token : String?,
  foo : String?,
) -> Model8 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=161)
  sb0.write_string(
    "/payload/pageable/server-driven-pagination/continuationtoken/request-header-response-header",
  )
  sb0.write_string(@runtime.expand_string("?", "bar", false, bar))
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  if token is Some(v) {
    headers.set("token", v)
  }
  if foo is Some(v) {
    headers.set("foo", v)
  }
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model8 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /payload/pageable/server-driven-pagination/continuationtoken/request-query-nested-response-body{?token,bar}（自动解析响应）。
pub async fn ContinuationTokenClient::get_payload_pageable_server_driven_pagination_continuationtoken_request_query_nested_response_body__token_bar_(
  self : ContinuationTokenClient,
  token : String,
  foo : String?,
  bar : String?,
) -> Model14 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=171)
  sb0.write_string(
    "/payload/pageable/server-driven-pagination/continuationtoken/request-query-nested-response-body",
  )
  sb0.write_string(@runtime.expand_string("?", "token", false, token))
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let mut first_query = !base_path.contains("?")
  if foo is Some(v) {
    headers.set("foo", v)
  }
  if bar is Some(v) {
    if first_query {
      sb.write_char('?')
      first_query = false
    } else {
      sb.write_char('&')
    }
    sb.write_string("bar=")
    sb.write_string(@runtime.encode_query_component(v))
  }
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model14 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /payload/pageable/server-driven-pagination/continuationtoken/request-header-nested-response-body{?bar}（自动解析响应）。
pub async fn ContinuationTokenClient::get_payload_pageable_server_driven_pagination_continuationtoken_request_header_nested_response_body__bar_(
  self : ContinuationTokenClient,
  bar : String,
  token : String?,
  foo : String?,
) -> Model11 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=166)
  sb0.write_string(
    "/payload/pageable/server-driven-pagination/continuationtoken/request-header-nested-response-body",
  )
  sb0.write_string(@runtime.expand_string("?", "bar", false, bar))
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  if token is Some(v) {
    headers.set("token", v)
  }
  if foo is Some(v) {
    headers.set("foo", v)
  }
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model11 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// PageSizeClient HTTP 客户端。
pub(all) struct PageSizeClient {
  base_url : String
}

///|

///|
/// 创建 PageSizeClient。
pub fn PageSizeClient::new(base_url : String) -> PageSizeClient {
  { base_url, }
}

///|

///|
/// 调用 get /payload/pageable/pagesize/without-continuation（自动解析响应）。
pub async fn PageSizeClient::get_payload_pageable_pagesize_without_continuation(
  self : PageSizeClient,
) -> Model6 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/payload/pageable/pagesize/without-continuation",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model6 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /payload/pageable/pagesize/list{?pageSize}（自动解析响应）。
pub async fn PageSizeClient::get_payload_pageable_pagesize_list__pagesize_(
  self : PageSizeClient,
  pagesize : Int,
) -> Model1 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=106)
  sb0.write_string("/payload/pageable/pagesize/list")
  sb0.write_string(
    @runtime.expand_string("?", "pageSize", false, pagesize.to_string()),
  )
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model1 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
