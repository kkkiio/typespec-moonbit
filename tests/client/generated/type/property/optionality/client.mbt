///|

///|
/// StringClient HTTP 客户端。
pub(all) struct StringClient {
  base_url : String
}

///|

///|
/// 创建 StringClient。
pub fn StringClient::new(base_url : String) -> StringClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/string/all（自动解析响应）。
pub async fn StringClient::get_type_property_optional_string_all(
  self : StringClient,
) -> StringProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/string/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : StringProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/string/default（自动解析响应）。
pub async fn StringClient::get_type_property_optional_string_default(
  self : StringClient,
) -> StringProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/string/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : StringProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/string/all（自动解析响应）。
pub async fn StringClient::put_type_property_optional_string_all(
  self : StringClient,
  body : StringProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/string/all",
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
/// 调用 put /type/property/optional/string/default（自动解析响应）。
pub async fn StringClient::put_type_property_optional_string_default(
  self : StringClient,
  body : StringProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/string/default",
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
/// BytesClient HTTP 客户端。
pub(all) struct BytesClient {
  base_url : String
}

///|

///|
/// 创建 BytesClient。
pub fn BytesClient::new(base_url : String) -> BytesClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/bytes/all（自动解析响应）。
pub async fn BytesClient::get_type_property_optional_bytes_all(
  self : BytesClient,
) -> BytesProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/bytes/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : BytesProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/bytes/default（自动解析响应）。
pub async fn BytesClient::get_type_property_optional_bytes_default(
  self : BytesClient,
) -> BytesProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/bytes/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : BytesProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/bytes/all（自动解析响应）。
pub async fn BytesClient::put_type_property_optional_bytes_all(
  self : BytesClient,
  body : BytesProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/bytes/all",
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
/// 调用 put /type/property/optional/bytes/default（自动解析响应）。
pub async fn BytesClient::put_type_property_optional_bytes_default(
  self : BytesClient,
  body : BytesProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/bytes/default",
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
/// DatetimeClient HTTP 客户端。
pub(all) struct DatetimeClient {
  base_url : String
}

///|

///|
/// 创建 DatetimeClient。
pub fn DatetimeClient::new(base_url : String) -> DatetimeClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/datetime/all（自动解析响应）。
pub async fn DatetimeClient::get_type_property_optional_datetime_all(
  self : DatetimeClient,
) -> DatetimeProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/datetime/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : DatetimeProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/datetime/default（自动解析响应）。
pub async fn DatetimeClient::get_type_property_optional_datetime_default(
  self : DatetimeClient,
) -> DatetimeProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/datetime/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : DatetimeProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/datetime/all（自动解析响应）。
pub async fn DatetimeClient::put_type_property_optional_datetime_all(
  self : DatetimeClient,
  body : DatetimeProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/datetime/all",
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
/// 调用 put /type/property/optional/datetime/default（自动解析响应）。
pub async fn DatetimeClient::put_type_property_optional_datetime_default(
  self : DatetimeClient,
  body : DatetimeProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/datetime/default",
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
/// DurationClient HTTP 客户端。
pub(all) struct DurationClient {
  base_url : String
}

///|

///|
/// 创建 DurationClient。
pub fn DurationClient::new(base_url : String) -> DurationClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/duration/all（自动解析响应）。
pub async fn DurationClient::get_type_property_optional_duration_all(
  self : DurationClient,
) -> DurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/duration/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : DurationProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/duration/default（自动解析响应）。
pub async fn DurationClient::get_type_property_optional_duration_default(
  self : DurationClient,
) -> DurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/duration/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : DurationProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/duration/all（自动解析响应）。
pub async fn DurationClient::put_type_property_optional_duration_all(
  self : DurationClient,
  body : DurationProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/duration/all",
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
/// 调用 put /type/property/optional/duration/default（自动解析响应）。
pub async fn DurationClient::put_type_property_optional_duration_default(
  self : DurationClient,
  body : DurationProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/duration/default",
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
/// PlainDateClient HTTP 客户端。
pub(all) struct PlainDateClient {
  base_url : String
}

///|

///|
/// 创建 PlainDateClient。
pub fn PlainDateClient::new(base_url : String) -> PlainDateClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/plainDate/all（自动解析响应）。
pub async fn PlainDateClient::get_type_property_optional_plaindate_all(
  self : PlainDateClient,
) -> PlainDateProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/plainDate/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : PlainDateProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/plainDate/default（自动解析响应）。
pub async fn PlainDateClient::get_type_property_optional_plaindate_default(
  self : PlainDateClient,
) -> PlainDateProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/plainDate/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : PlainDateProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/plainDate/all（自动解析响应）。
pub async fn PlainDateClient::put_type_property_optional_plaindate_all(
  self : PlainDateClient,
  body : PlainDateProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/plainDate/all",
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
/// 调用 put /type/property/optional/plainDate/default（自动解析响应）。
pub async fn PlainDateClient::put_type_property_optional_plaindate_default(
  self : PlainDateClient,
  body : PlainDateProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/plainDate/default",
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
/// PlainTimeClient HTTP 客户端。
pub(all) struct PlainTimeClient {
  base_url : String
}

///|

///|
/// 创建 PlainTimeClient。
pub fn PlainTimeClient::new(base_url : String) -> PlainTimeClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/plainTime/all（自动解析响应）。
pub async fn PlainTimeClient::get_type_property_optional_plaintime_all(
  self : PlainTimeClient,
) -> PlainTimeProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/plainTime/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : PlainTimeProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/plainTime/default（自动解析响应）。
pub async fn PlainTimeClient::get_type_property_optional_plaintime_default(
  self : PlainTimeClient,
) -> PlainTimeProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/plainTime/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : PlainTimeProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/plainTime/all（自动解析响应）。
pub async fn PlainTimeClient::put_type_property_optional_plaintime_all(
  self : PlainTimeClient,
  body : PlainTimeProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/plainTime/all",
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
/// 调用 put /type/property/optional/plainTime/default（自动解析响应）。
pub async fn PlainTimeClient::put_type_property_optional_plaintime_default(
  self : PlainTimeClient,
  body : PlainTimeProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/plainTime/default",
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
/// CollectionsByteClient HTTP 客户端。
pub(all) struct CollectionsByteClient {
  base_url : String
}

///|

///|
/// 创建 CollectionsByteClient。
pub fn CollectionsByteClient::new(base_url : String) -> CollectionsByteClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/collections/bytes/all（自动解析响应）。
pub async fn CollectionsByteClient::get_type_property_optional_collections_bytes_all(
  self : CollectionsByteClient,
) -> CollectionsByteProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/collections/bytes/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : CollectionsByteProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/collections/bytes/default（自动解析响应）。
pub async fn CollectionsByteClient::get_type_property_optional_collections_bytes_default(
  self : CollectionsByteClient,
) -> CollectionsByteProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/collections/bytes/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : CollectionsByteProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/collections/bytes/all（自动解析响应）。
pub async fn CollectionsByteClient::put_type_property_optional_collections_bytes_all(
  self : CollectionsByteClient,
  body : CollectionsByteProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/collections/bytes/all",
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
/// 调用 put /type/property/optional/collections/bytes/default（自动解析响应）。
pub async fn CollectionsByteClient::put_type_property_optional_collections_bytes_default(
  self : CollectionsByteClient,
  body : CollectionsByteProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/collections/bytes/default",
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
/// CollectionsModelClient HTTP 客户端。
pub(all) struct CollectionsModelClient {
  base_url : String
}

///|

///|
/// 创建 CollectionsModelClient。
pub fn CollectionsModelClient::new(base_url : String) -> CollectionsModelClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/collections/model/all（自动解析响应）。
pub async fn CollectionsModelClient::get_type_property_optional_collections_model_all(
  self : CollectionsModelClient,
) -> CollectionsModelProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/collections/model/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : CollectionsModelProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/collections/model/default（自动解析响应）。
pub async fn CollectionsModelClient::get_type_property_optional_collections_model_default(
  self : CollectionsModelClient,
) -> CollectionsModelProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/collections/model/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : CollectionsModelProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/collections/model/all（自动解析响应）。
pub async fn CollectionsModelClient::put_type_property_optional_collections_model_all(
  self : CollectionsModelClient,
  body : CollectionsModelProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/collections/model/all",
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
/// 调用 put /type/property/optional/collections/model/default（自动解析响应）。
pub async fn CollectionsModelClient::put_type_property_optional_collections_model_default(
  self : CollectionsModelClient,
  body : CollectionsModelProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/collections/model/default",
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
/// StringLiteralClient HTTP 客户端。
pub(all) struct StringLiteralClient {
  base_url : String
}

///|

///|
/// 创建 StringLiteralClient。
pub fn StringLiteralClient::new(base_url : String) -> StringLiteralClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/string/literal/all（自动解析响应）。
pub async fn StringLiteralClient::get_type_property_optional_string_literal_all(
  self : StringLiteralClient,
) -> StringLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/string/literal/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : StringLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/string/literal/default（自动解析响应）。
pub async fn StringLiteralClient::get_type_property_optional_string_literal_default(
  self : StringLiteralClient,
) -> StringLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/string/literal/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : StringLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/string/literal/all（自动解析响应）。
pub async fn StringLiteralClient::put_type_property_optional_string_literal_all(
  self : StringLiteralClient,
  body : StringLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/string/literal/all",
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
/// 调用 put /type/property/optional/string/literal/default（自动解析响应）。
pub async fn StringLiteralClient::put_type_property_optional_string_literal_default(
  self : StringLiteralClient,
  body : StringLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/string/literal/default",
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
/// IntLiteralClient HTTP 客户端。
pub(all) struct IntLiteralClient {
  base_url : String
}

///|

///|
/// 创建 IntLiteralClient。
pub fn IntLiteralClient::new(base_url : String) -> IntLiteralClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/int/literal/all（自动解析响应）。
pub async fn IntLiteralClient::get_type_property_optional_int_literal_all(
  self : IntLiteralClient,
) -> IntLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/int/literal/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : IntLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/int/literal/default（自动解析响应）。
pub async fn IntLiteralClient::get_type_property_optional_int_literal_default(
  self : IntLiteralClient,
) -> IntLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/int/literal/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : IntLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/int/literal/all（自动解析响应）。
pub async fn IntLiteralClient::put_type_property_optional_int_literal_all(
  self : IntLiteralClient,
  body : IntLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/int/literal/all",
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
/// 调用 put /type/property/optional/int/literal/default（自动解析响应）。
pub async fn IntLiteralClient::put_type_property_optional_int_literal_default(
  self : IntLiteralClient,
  body : IntLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/int/literal/default",
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
/// FloatLiteralClient HTTP 客户端。
pub(all) struct FloatLiteralClient {
  base_url : String
}

///|

///|
/// 创建 FloatLiteralClient。
pub fn FloatLiteralClient::new(base_url : String) -> FloatLiteralClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/float/literal/all（自动解析响应）。
pub async fn FloatLiteralClient::get_type_property_optional_float_literal_all(
  self : FloatLiteralClient,
) -> FloatLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/float/literal/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : FloatLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/float/literal/default（自动解析响应）。
pub async fn FloatLiteralClient::get_type_property_optional_float_literal_default(
  self : FloatLiteralClient,
) -> FloatLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/float/literal/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : FloatLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/float/literal/all（自动解析响应）。
pub async fn FloatLiteralClient::put_type_property_optional_float_literal_all(
  self : FloatLiteralClient,
  body : FloatLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/float/literal/all",
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
/// 调用 put /type/property/optional/float/literal/default（自动解析响应）。
pub async fn FloatLiteralClient::put_type_property_optional_float_literal_default(
  self : FloatLiteralClient,
  body : FloatLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/float/literal/default",
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
/// BooleanLiteralClient HTTP 客户端。
pub(all) struct BooleanLiteralClient {
  base_url : String
}

///|

///|
/// 创建 BooleanLiteralClient。
pub fn BooleanLiteralClient::new(base_url : String) -> BooleanLiteralClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/boolean/literal/all（自动解析响应）。
pub async fn BooleanLiteralClient::get_type_property_optional_boolean_literal_all(
  self : BooleanLiteralClient,
) -> BooleanLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/boolean/literal/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : BooleanLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/boolean/literal/default（自动解析响应）。
pub async fn BooleanLiteralClient::get_type_property_optional_boolean_literal_default(
  self : BooleanLiteralClient,
) -> BooleanLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/boolean/literal/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : BooleanLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/boolean/literal/all（自动解析响应）。
pub async fn BooleanLiteralClient::put_type_property_optional_boolean_literal_all(
  self : BooleanLiteralClient,
  body : BooleanLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/boolean/literal/all",
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
/// 调用 put /type/property/optional/boolean/literal/default（自动解析响应）。
pub async fn BooleanLiteralClient::put_type_property_optional_boolean_literal_default(
  self : BooleanLiteralClient,
  body : BooleanLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/boolean/literal/default",
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
/// UnionStringLiteralClient HTTP 客户端。
pub(all) struct UnionStringLiteralClient {
  base_url : String
}

///|

///|
/// 创建 UnionStringLiteralClient。
pub fn UnionStringLiteralClient::new(
  base_url : String,
) -> UnionStringLiteralClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/union/string/literal/all（自动解析响应）。
pub async fn UnionStringLiteralClient::get_type_property_optional_union_string_literal_all(
  self : UnionStringLiteralClient,
) -> UnionStringLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/union/string/literal/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : UnionStringLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/union/string/literal/default（自动解析响应）。
pub async fn UnionStringLiteralClient::get_type_property_optional_union_string_literal_default(
  self : UnionStringLiteralClient,
) -> UnionStringLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/union/string/literal/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : UnionStringLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/union/string/literal/all（自动解析响应）。
pub async fn UnionStringLiteralClient::put_type_property_optional_union_string_literal_all(
  self : UnionStringLiteralClient,
  body : UnionStringLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/union/string/literal/all",
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
/// 调用 put /type/property/optional/union/string/literal/default（自动解析响应）。
pub async fn UnionStringLiteralClient::put_type_property_optional_union_string_literal_default(
  self : UnionStringLiteralClient,
  body : UnionStringLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/union/string/literal/default",
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
/// UnionIntLiteralClient HTTP 客户端。
pub(all) struct UnionIntLiteralClient {
  base_url : String
}

///|

///|
/// 创建 UnionIntLiteralClient。
pub fn UnionIntLiteralClient::new(base_url : String) -> UnionIntLiteralClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/union/int/literal/all（自动解析响应）。
pub async fn UnionIntLiteralClient::get_type_property_optional_union_int_literal_all(
  self : UnionIntLiteralClient,
) -> UnionIntLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/union/int/literal/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : UnionIntLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/union/int/literal/default（自动解析响应）。
pub async fn UnionIntLiteralClient::get_type_property_optional_union_int_literal_default(
  self : UnionIntLiteralClient,
) -> UnionIntLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/union/int/literal/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : UnionIntLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/union/int/literal/all（自动解析响应）。
pub async fn UnionIntLiteralClient::put_type_property_optional_union_int_literal_all(
  self : UnionIntLiteralClient,
  body : UnionIntLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/union/int/literal/all",
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
/// 调用 put /type/property/optional/union/int/literal/default（自动解析响应）。
pub async fn UnionIntLiteralClient::put_type_property_optional_union_int_literal_default(
  self : UnionIntLiteralClient,
  body : UnionIntLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/union/int/literal/default",
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
/// UnionFloatLiteralClient HTTP 客户端。
pub(all) struct UnionFloatLiteralClient {
  base_url : String
}

///|

///|
/// 创建 UnionFloatLiteralClient。
pub fn UnionFloatLiteralClient::new(
  base_url : String,
) -> UnionFloatLiteralClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/union/float/literal/all（自动解析响应）。
pub async fn UnionFloatLiteralClient::get_type_property_optional_union_float_literal_all(
  self : UnionFloatLiteralClient,
) -> UnionFloatLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/union/float/literal/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : UnionFloatLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/union/float/literal/default（自动解析响应）。
pub async fn UnionFloatLiteralClient::get_type_property_optional_union_float_literal_default(
  self : UnionFloatLiteralClient,
) -> UnionFloatLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/union/float/literal/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : UnionFloatLiteralProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/union/float/literal/all（自动解析响应）。
pub async fn UnionFloatLiteralClient::put_type_property_optional_union_float_literal_all(
  self : UnionFloatLiteralClient,
  body : UnionFloatLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/union/float/literal/all",
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
/// 调用 put /type/property/optional/union/float/literal/default（自动解析响应）。
pub async fn UnionFloatLiteralClient::put_type_property_optional_union_float_literal_default(
  self : UnionFloatLiteralClient,
  body : UnionFloatLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/union/float/literal/default",
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
/// RequiredAndOptionalClient HTTP 客户端。
pub(all) struct RequiredAndOptionalClient {
  base_url : String
}

///|

///|
/// 创建 RequiredAndOptionalClient。
pub fn RequiredAndOptionalClient::new(
  base_url : String,
) -> RequiredAndOptionalClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/property/optional/requiredAndOptional/all（自动解析响应）。
pub async fn RequiredAndOptionalClient::get_type_property_optional_requiredandoptional_all(
  self : RequiredAndOptionalClient,
) -> RequiredAndOptionalProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/requiredAndOptional/all",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : RequiredAndOptionalProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 get /type/property/optional/requiredAndOptional/requiredOnly（自动解析响应）。
pub async fn RequiredAndOptionalClient::get_type_property_optional_requiredandoptional_requiredonly(
  self : RequiredAndOptionalClient,
) -> RequiredAndOptionalProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/requiredAndOptional/requiredOnly",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : RequiredAndOptionalProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/property/optional/requiredAndOptional/all（自动解析响应）。
pub async fn RequiredAndOptionalClient::put_type_property_optional_requiredandoptional_all(
  self : RequiredAndOptionalClient,
  body : RequiredAndOptionalProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/requiredAndOptional/all",
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
/// 调用 put /type/property/optional/requiredAndOptional/requiredOnly（自动解析响应）。
pub async fn RequiredAndOptionalClient::put_type_property_optional_requiredandoptional_requiredonly(
  self : RequiredAndOptionalClient,
  body : RequiredAndOptionalProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/optional/requiredAndOptional/requiredOnly",
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
