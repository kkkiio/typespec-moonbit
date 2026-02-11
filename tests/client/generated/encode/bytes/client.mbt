///|
/// QueryClient HTTP 客户端。
pub(all) struct QueryClient {
  base_url : String
}

///|
/// 创建 QueryClient。
pub fn QueryClient::new(base_url : String) -> QueryClient {
  { base_url, }
}

///|
/// 调用 get /encode/bytes/query/default{?value}（自动解析响应）。
pub async fn QueryClient::get_encode_bytes_query_default__value_(
  self : QueryClient,
  value : Bytes,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=99)
  sb0.write_string("/encode/bytes/query/default")
  sb0.write_string(
    @runtime.expand_string(
      "?",
      "value",
      false,
      @runtime.encode_bytes(value, @runtime.BytesEncoding::Base64Url),
    ),
  )
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /encode/bytes/query/base64{?value}（自动解析响应）。
pub async fn QueryClient::get_encode_bytes_query_base64__value_(
  self : QueryClient,
  value : Bytes,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=98)
  sb0.write_string("/encode/bytes/query/base64")
  sb0.write_string(
    @runtime.expand_string(
      "?",
      "value",
      false,
      @runtime.encode_bytes(value, @runtime.BytesEncoding::Base64),
    ),
  )
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /encode/bytes/query/base64url{?value}（自动解析响应）。
pub async fn QueryClient::get_encode_bytes_query_base64url__value_(
  self : QueryClient,
  value : Bytes,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=101)
  sb0.write_string("/encode/bytes/query/base64url")
  sb0.write_string(
    @runtime.expand_string(
      "?",
      "value",
      false,
      @runtime.encode_bytes(value, @runtime.BytesEncoding::Base64Url),
    ),
  )
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /encode/bytes/query/base64url-array{?value}（自动解析响应）。
pub async fn QueryClient::get_encode_bytes_query_base64url_array__value_(
  self : QueryClient,
  value : Array[Bytes],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=107)
  sb0.write_string("/encode/bytes/query/base64url-array")
  sb0.write_string(
    @runtime.expand_array(
      "?",
      "value",
      false,
      @runtime.encode_bytes_list(value, @runtime.BytesEncoding::Base64Url),
    ),
  )
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// PropertyClient HTTP 客户端。
pub(all) struct PropertyClient {
  base_url : String
}

///|
/// 创建 PropertyClient。
pub fn PropertyClient::new(base_url : String) -> PropertyClient {
  { base_url, }
}

///|
/// 调用 post /encode/bytes/property/default（自动解析响应）。
pub async fn PropertyClient::post_encode_bytes_property_default(
  self : PropertyClient,
  body : DefaultBytesProperty,
) -> DefaultBytesProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/property/default",
  )
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
    let parsed : DefaultBytesProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 post /encode/bytes/property/base64（自动解析响应）。
pub async fn PropertyClient::post_encode_bytes_property_base64(
  self : PropertyClient,
  body : Base64BytesProperty,
) -> Base64BytesProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/property/base64",
  )
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
    let parsed : Base64BytesProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 post /encode/bytes/property/base64url（自动解析响应）。
pub async fn PropertyClient::post_encode_bytes_property_base64url(
  self : PropertyClient,
  body : Base64UrlBytesProperty,
) -> Base64UrlBytesProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/property/base64url",
  )
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
    let parsed : Base64UrlBytesProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 post /encode/bytes/property/base64url-array（自动解析响应）。
pub async fn PropertyClient::post_encode_bytes_property_base64url_array(
  self : PropertyClient,
  body : Base64UrlArrayBytesProperty,
) -> Base64UrlArrayBytesProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/property/base64url-array",
  )
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
    let parsed : Base64UrlArrayBytesProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// HeaderClient HTTP 客户端。
pub(all) struct HeaderClient {
  base_url : String
}

///|
/// 创建 HeaderClient。
pub fn HeaderClient::new(base_url : String) -> HeaderClient {
  { base_url, }
}

///|
/// 调用 get /encode/bytes/header/default（自动解析响应）。
pub async fn HeaderClient::get_encode_bytes_header_default(
  self : HeaderClient,
  value : Bytes,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/encode/bytes/header/default")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set(
    "value",
    @runtime.encode_bytes(value, @runtime.BytesEncoding::Base64),
  )
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /encode/bytes/header/base64（自动解析响应）。
pub async fn HeaderClient::get_encode_bytes_header_base64(
  self : HeaderClient,
  value : Bytes,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/encode/bytes/header/base64")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set(
    "value",
    @runtime.encode_bytes(value, @runtime.BytesEncoding::Base64),
  )
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /encode/bytes/header/base64url（自动解析响应）。
pub async fn HeaderClient::get_encode_bytes_header_base64url(
  self : HeaderClient,
  value : Bytes,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/header/base64url",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set(
    "value",
    @runtime.encode_bytes(value, @runtime.BytesEncoding::Base64Url),
  )
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /encode/bytes/header/base64url-array（自动解析响应）。
pub async fn HeaderClient::get_encode_bytes_header_base64url_array(
  self : HeaderClient,
  value : Array[Bytes],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/header/base64url-array",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set(
    "value",
    @runtime.encode_bytes_array(value, @runtime.BytesEncoding::Base64, ","),
  )
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// RequestBodyClient HTTP 客户端。
pub(all) struct RequestBodyClient {
  base_url : String
}

///|
/// 创建 RequestBodyClient。
pub fn RequestBodyClient::new(base_url : String) -> RequestBodyClient {
  { base_url, }
}

///|
/// 调用 post /encode/bytes/body/request/default（自动解析响应）。
pub async fn RequestBodyClient::post_encode_bytes_body_request_default(
  self : RequestBodyClient,
  body : Bytes,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/body/request/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("Content-Type", "application/octet-stream")
  client.request(@http.Post, path, extra_headers=headers)
  client.write(body)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 post /encode/bytes/body/request/octet-stream（自动解析响应）。
pub async fn RequestBodyClient::post_encode_bytes_body_request_octet_stream(
  self : RequestBodyClient,
  body : Bytes,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/body/request/octet-stream",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/octet-stream")
  let path = sb.to_string()
  client.request(@http.Post, path, extra_headers=headers)
  client.write(body)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 post /encode/bytes/body/request/custom-content-type（自动解析响应）。
pub async fn RequestBodyClient::post_encode_bytes_body_request_custom_content_type(
  self : RequestBodyClient,
  body : Bytes,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/body/request/custom-content-type",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "image/png")
  let path = sb.to_string()
  client.request(@http.Post, path, extra_headers=headers)
  client.write(body)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 post /encode/bytes/body/request/base64（自动解析响应）。
pub async fn RequestBodyClient::post_encode_bytes_body_request_base64(
  self : RequestBodyClient,
  body : Bytes,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/body/request/base64",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/json")
  let path = sb.to_string()
  client.request(@http.Post, path, extra_headers=headers)
  let encoded = @runtime.encode_bytes(body, @runtime.BytesEncoding::Base64)
  client.write(encoded.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 post /encode/bytes/body/request/base64url（自动解析响应）。
pub async fn RequestBodyClient::post_encode_bytes_body_request_base64url(
  self : RequestBodyClient,
  body : Bytes,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/body/request/base64url",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/json")
  let path = sb.to_string()
  client.request(@http.Post, path, extra_headers=headers)
  let encoded = @runtime.encode_bytes(body, @runtime.BytesEncoding::Base64Url)
  client.write(encoded.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// ResponseBodyClient HTTP 客户端。
pub(all) struct ResponseBodyClient {
  base_url : String
}

///|
/// 创建 ResponseBodyClient。
pub fn ResponseBodyClient::new(base_url : String) -> ResponseBodyClient {
  { base_url, }
}

///|
/// 调用 get /encode/bytes/body/response/default（自动解析响应）。
pub async fn ResponseBodyClient::get_encode_bytes_body_response_default(
  self : ResponseBodyClient,
) -> Bytes {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/body/response/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
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
/// 调用 get /encode/bytes/body/response/octet-stream（自动解析响应）。
pub async fn ResponseBodyClient::get_encode_bytes_body_response_octet_stream(
  self : ResponseBodyClient,
) -> Bytes {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/body/response/octet-stream",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
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
/// 调用 get /encode/bytes/body/response/custom-content-type（自动解析响应）。
pub async fn ResponseBodyClient::get_encode_bytes_body_response_custom_content_type(
  self : ResponseBodyClient,
) -> Bytes {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/body/response/custom-content-type",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
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
/// 调用 get /encode/bytes/body/response/base64（自动解析响应）。
pub async fn ResponseBodyClient::get_encode_bytes_body_response_base64(
  self : ResponseBodyClient,
) -> Bytes {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/body/response/base64",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let encoded : String = @json.from_json(@json.parse(response_body))
    let parsed = @runtime.decode_bytes(encoded, @runtime.BytesEncoding::Base64)
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /encode/bytes/body/response/base64url（自动解析响应）。
pub async fn ResponseBodyClient::get_encode_bytes_body_response_base64url(
  self : ResponseBodyClient,
) -> Bytes {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/bytes/body/response/base64url",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let encoded : String = @json.from_json(@json.parse(response_body))
    let parsed = @runtime.decode_bytes(encoded, @runtime.BytesEncoding::Base64)
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
