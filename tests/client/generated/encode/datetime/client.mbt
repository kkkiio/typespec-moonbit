///|

///|
/// QueryClient HTTP 客户端。
pub(all) struct QueryClient {
  base_url : String
}

///|

///|
/// 创建 QueryClient。
pub fn QueryClient::new(base_url : String) -> QueryClient {
  { base_url, }
}

///|

///|
/// 调用 get /encode/datetime/query/default{?value}（自动解析响应）。
pub async fn QueryClient::get_encode_datetime_query_default__value_(
  self : QueryClient,
  value : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=102)
  sb0.write_string("/encode/datetime/query/default")
  sb0.write_string(@runtime.expand_string("?", "value", false, value))
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

///|
/// 调用 get /encode/datetime/query/rfc3339{?value}（自动解析响应）。
pub async fn QueryClient::get_encode_datetime_query_rfc3339__value_(
  self : QueryClient,
  value : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=102)
  sb0.write_string("/encode/datetime/query/rfc3339")
  sb0.write_string(@runtime.expand_string("?", "value", false, value))
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

///|
/// 调用 get /encode/datetime/query/rfc7231{?value}（自动解析响应）。
pub async fn QueryClient::get_encode_datetime_query_rfc7231__value_(
  self : QueryClient,
  value : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=102)
  sb0.write_string("/encode/datetime/query/rfc7231")
  sb0.write_string(@runtime.expand_string("?", "value", false, value))
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

///|
/// 调用 get /encode/datetime/query/unix-timestamp{?value}（自动解析响应）。
pub async fn QueryClient::get_encode_datetime_query_unix_timestamp__value_(
  self : QueryClient,
  value : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=109)
  sb0.write_string("/encode/datetime/query/unix-timestamp")
  sb0.write_string(@runtime.expand_string("?", "value", false, value))
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

///|
/// 调用 get /encode/datetime/query/unix-timestamp-array{?value}（自动解析响应）。
pub async fn QueryClient::get_encode_datetime_query_unix_timestamp_array__value_(
  self : QueryClient,
  value : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=115)
  sb0.write_string("/encode/datetime/query/unix-timestamp-array")
  sb0.write_string(@runtime.expand_array("?", "value", false, value))
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

///|
/// PropertyClient HTTP 客户端。
pub(all) struct PropertyClient {
  base_url : String
}

///|

///|
/// 创建 PropertyClient。
pub fn PropertyClient::new(base_url : String) -> PropertyClient {
  { base_url, }
}

///|

///|
/// 调用 post /encode/datetime/property/default（自动解析响应）。
pub async fn PropertyClient::post_encode_datetime_property_default(
  self : PropertyClient,
  body : DefaultDatetimeProperty,
) -> DefaultDatetimeProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/property/default",
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
    let parsed : DefaultDatetimeProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/datetime/property/rfc3339（自动解析响应）。
pub async fn PropertyClient::post_encode_datetime_property_rfc3339(
  self : PropertyClient,
  body : Rfc3339DatetimeProperty,
) -> Rfc3339DatetimeProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/property/rfc3339",
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
    let parsed : Rfc3339DatetimeProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/datetime/property/rfc7231（自动解析响应）。
pub async fn PropertyClient::post_encode_datetime_property_rfc7231(
  self : PropertyClient,
  body : Rfc7231DatetimeProperty,
) -> Rfc7231DatetimeProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/property/rfc7231",
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
    let parsed : Rfc7231DatetimeProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/datetime/property/unix-timestamp（自动解析响应）。
pub async fn PropertyClient::post_encode_datetime_property_unix_timestamp(
  self : PropertyClient,
  body : UnixTimestampDatetimeProperty,
) -> UnixTimestampDatetimeProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/property/unix-timestamp",
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
    let parsed : UnixTimestampDatetimeProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/datetime/property/unix-timestamp-array（自动解析响应）。
pub async fn PropertyClient::post_encode_datetime_property_unix_timestamp_array(
  self : PropertyClient,
  body : UnixTimestampArrayDatetimeProperty,
) -> UnixTimestampArrayDatetimeProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/property/unix-timestamp-array",
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
    let parsed : UnixTimestampArrayDatetimeProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// HeaderClient HTTP 客户端。
pub(all) struct HeaderClient {
  base_url : String
}

///|

///|
/// 创建 HeaderClient。
pub fn HeaderClient::new(base_url : String) -> HeaderClient {
  { base_url, }
}

///|

///|
/// 调用 get /encode/datetime/header/default（自动解析响应）。
pub async fn HeaderClient::get_encode_datetime_header_default(
  self : HeaderClient,
  value : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/header/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("value", value)
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

///|
/// 调用 get /encode/datetime/header/rfc3339（自动解析响应）。
pub async fn HeaderClient::get_encode_datetime_header_rfc3339(
  self : HeaderClient,
  value : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/header/rfc3339",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("value", value)
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

///|
/// 调用 get /encode/datetime/header/rfc7231（自动解析响应）。
pub async fn HeaderClient::get_encode_datetime_header_rfc7231(
  self : HeaderClient,
  value : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/header/rfc7231",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("value", value)
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

///|
/// 调用 get /encode/datetime/header/unix-timestamp（自动解析响应）。
pub async fn HeaderClient::get_encode_datetime_header_unix_timestamp(
  self : HeaderClient,
  value : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/header/unix-timestamp",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("value", value)
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

///|
/// 调用 get /encode/datetime/header/unix-timestamp-array（自动解析响应）。
pub async fn HeaderClient::get_encode_datetime_header_unix_timestamp_array(
  self : HeaderClient,
  value : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/header/unix-timestamp-array",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("value", @runtime.join(value, ","))
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

///|
/// ResponseHeaderClient HTTP 客户端。
pub(all) struct ResponseHeaderClient {
  base_url : String
}

///|

///|
/// 创建 ResponseHeaderClient。
pub fn ResponseHeaderClient::new(base_url : String) -> ResponseHeaderClient {
  { base_url, }
}

///|

///|
/// 调用 get /encode/datetime/responseheader/default（自动解析响应）。
pub async fn ResponseHeaderClient::get_encode_datetime_responseheader_default(
  self : ResponseHeaderClient,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/responseheader/default",
  )
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

///|
/// 调用 get /encode/datetime/responseheader/rfc3339（自动解析响应）。
pub async fn ResponseHeaderClient::get_encode_datetime_responseheader_rfc3339(
  self : ResponseHeaderClient,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/responseheader/rfc3339",
  )
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

///|
/// 调用 get /encode/datetime/responseheader/rfc7231（自动解析响应）。
pub async fn ResponseHeaderClient::get_encode_datetime_responseheader_rfc7231(
  self : ResponseHeaderClient,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/responseheader/rfc7231",
  )
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

///|
/// 调用 get /encode/datetime/responseheader/unix-timestamp（自动解析响应）。
pub async fn ResponseHeaderClient::get_encode_datetime_responseheader_unix_timestamp(
  self : ResponseHeaderClient,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/datetime/responseheader/unix-timestamp",
  )
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
