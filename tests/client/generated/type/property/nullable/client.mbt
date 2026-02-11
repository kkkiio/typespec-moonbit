///|
/// StringClient HTTP 客户端。
pub(all) struct StringClient {
  base_url : String
}

///|
/// 创建 StringClient。
pub fn StringClient::new(base_url : String) -> StringClient {
  { base_url, }
}

///|
/// 调用 get /type/property/nullable/string/non-null（自动解析响应）。
pub async fn StringClient::get_type_property_nullable_string_non_null(
  self : StringClient,
) -> StringProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/string/non-null",
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
/// 调用 get /type/property/nullable/string/null（自动解析响应）。
pub async fn StringClient::get_type_property_nullable_string_null(
  self : StringClient,
) -> StringProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/string/null",
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
/// 调用 patch /type/property/nullable/string/non-null（自动解析响应）。
pub async fn StringClient::patch_type_property_nullable_string_non_null(
  self : StringClient,
  body : StringProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/string/non-null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 patch /type/property/nullable/string/null（自动解析响应）。
pub async fn StringClient::patch_type_property_nullable_string_null(
  self : StringClient,
  body : StringProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/string/null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// BytesClient HTTP 客户端。
pub(all) struct BytesClient {
  base_url : String
}

///|
/// 创建 BytesClient。
pub fn BytesClient::new(base_url : String) -> BytesClient {
  { base_url, }
}

///|
/// 调用 get /type/property/nullable/bytes/non-null（自动解析响应）。
pub async fn BytesClient::get_type_property_nullable_bytes_non_null(
  self : BytesClient,
) -> BytesProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/bytes/non-null",
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
/// 调用 get /type/property/nullable/bytes/null（自动解析响应）。
pub async fn BytesClient::get_type_property_nullable_bytes_null(
  self : BytesClient,
) -> BytesProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/bytes/null",
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
/// 调用 patch /type/property/nullable/bytes/non-null（自动解析响应）。
pub async fn BytesClient::patch_type_property_nullable_bytes_non_null(
  self : BytesClient,
  body : BytesProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/bytes/non-null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 patch /type/property/nullable/bytes/null（自动解析响应）。
pub async fn BytesClient::patch_type_property_nullable_bytes_null(
  self : BytesClient,
  body : BytesProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/bytes/null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// DatetimeClient HTTP 客户端。
pub(all) struct DatetimeClient {
  base_url : String
}

///|
/// 创建 DatetimeClient。
pub fn DatetimeClient::new(base_url : String) -> DatetimeClient {
  { base_url, }
}

///|
/// 调用 get /type/property/nullable/datetime/non-null（自动解析响应）。
pub async fn DatetimeClient::get_type_property_nullable_datetime_non_null(
  self : DatetimeClient,
) -> DatetimeProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/datetime/non-null",
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
/// 调用 get /type/property/nullable/datetime/null（自动解析响应）。
pub async fn DatetimeClient::get_type_property_nullable_datetime_null(
  self : DatetimeClient,
) -> DatetimeProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/datetime/null",
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
/// 调用 patch /type/property/nullable/datetime/non-null（自动解析响应）。
pub async fn DatetimeClient::patch_type_property_nullable_datetime_non_null(
  self : DatetimeClient,
  body : DatetimeProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/datetime/non-null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 patch /type/property/nullable/datetime/null（自动解析响应）。
pub async fn DatetimeClient::patch_type_property_nullable_datetime_null(
  self : DatetimeClient,
  body : DatetimeProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/datetime/null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// DurationClient HTTP 客户端。
pub(all) struct DurationClient {
  base_url : String
}

///|
/// 创建 DurationClient。
pub fn DurationClient::new(base_url : String) -> DurationClient {
  { base_url, }
}

///|
/// 调用 get /type/property/nullable/duration/non-null（自动解析响应）。
pub async fn DurationClient::get_type_property_nullable_duration_non_null(
  self : DurationClient,
) -> DurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/duration/non-null",
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
/// 调用 get /type/property/nullable/duration/null（自动解析响应）。
pub async fn DurationClient::get_type_property_nullable_duration_null(
  self : DurationClient,
) -> DurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/duration/null",
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
/// 调用 patch /type/property/nullable/duration/non-null（自动解析响应）。
pub async fn DurationClient::patch_type_property_nullable_duration_non_null(
  self : DurationClient,
  body : DurationProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/duration/non-null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 patch /type/property/nullable/duration/null（自动解析响应）。
pub async fn DurationClient::patch_type_property_nullable_duration_null(
  self : DurationClient,
  body : DurationProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/duration/null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// CollectionsByteClient HTTP 客户端。
pub(all) struct CollectionsByteClient {
  base_url : String
}

///|
/// 创建 CollectionsByteClient。
pub fn CollectionsByteClient::new(base_url : String) -> CollectionsByteClient {
  { base_url, }
}

///|
/// 调用 get /type/property/nullable/collections/bytes/non-null（自动解析响应）。
pub async fn CollectionsByteClient::get_type_property_nullable_collections_bytes_non_null(
  self : CollectionsByteClient,
) -> CollectionsByteProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/collections/bytes/non-null",
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
/// 调用 get /type/property/nullable/collections/bytes/null（自动解析响应）。
pub async fn CollectionsByteClient::get_type_property_nullable_collections_bytes_null(
  self : CollectionsByteClient,
) -> CollectionsByteProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/collections/bytes/null",
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
/// 调用 patch /type/property/nullable/collections/bytes/non-null（自动解析响应）。
pub async fn CollectionsByteClient::patch_type_property_nullable_collections_bytes_non_null(
  self : CollectionsByteClient,
  body : CollectionsByteProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/collections/bytes/non-null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 patch /type/property/nullable/collections/bytes/null（自动解析响应）。
pub async fn CollectionsByteClient::patch_type_property_nullable_collections_bytes_null(
  self : CollectionsByteClient,
  body : CollectionsByteProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/collections/bytes/null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// CollectionsModelClient HTTP 客户端。
pub(all) struct CollectionsModelClient {
  base_url : String
}

///|
/// 创建 CollectionsModelClient。
pub fn CollectionsModelClient::new(base_url : String) -> CollectionsModelClient {
  { base_url, }
}

///|
/// 调用 get /type/property/nullable/collections/model/non-null（自动解析响应）。
pub async fn CollectionsModelClient::get_type_property_nullable_collections_model_non_null(
  self : CollectionsModelClient,
) -> CollectionsModelProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/collections/model/non-null",
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
/// 调用 get /type/property/nullable/collections/model/null（自动解析响应）。
pub async fn CollectionsModelClient::get_type_property_nullable_collections_model_null(
  self : CollectionsModelClient,
) -> CollectionsModelProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/collections/model/null",
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
/// 调用 patch /type/property/nullable/collections/model/non-null（自动解析响应）。
pub async fn CollectionsModelClient::patch_type_property_nullable_collections_model_non_null(
  self : CollectionsModelClient,
  body : CollectionsModelProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/collections/model/non-null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 patch /type/property/nullable/collections/model/null（自动解析响应）。
pub async fn CollectionsModelClient::patch_type_property_nullable_collections_model_null(
  self : CollectionsModelClient,
  body : CollectionsModelProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/collections/model/null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// CollectionsStringClient HTTP 客户端。
pub(all) struct CollectionsStringClient {
  base_url : String
}

///|
/// 创建 CollectionsStringClient。
pub fn CollectionsStringClient::new(
  base_url : String,
) -> CollectionsStringClient {
  { base_url, }
}

///|
/// 调用 get /type/property/nullable/collections/string/non-null（自动解析响应）。
pub async fn CollectionsStringClient::get_type_property_nullable_collections_string_non_null(
  self : CollectionsStringClient,
) -> CollectionsStringProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/collections/string/non-null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : CollectionsStringProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 get /type/property/nullable/collections/string/null（自动解析响应）。
pub async fn CollectionsStringClient::get_type_property_nullable_collections_string_null(
  self : CollectionsStringClient,
) -> CollectionsStringProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/collections/string/null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : CollectionsStringProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 patch /type/property/nullable/collections/string/non-null（自动解析响应）。
pub async fn CollectionsStringClient::patch_type_property_nullable_collections_string_non_null(
  self : CollectionsStringClient,
  body : CollectionsStringProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/collections/string/non-null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 patch /type/property/nullable/collections/string/null（自动解析响应）。
pub async fn CollectionsStringClient::patch_type_property_nullable_collections_string_null(
  self : CollectionsStringClient,
  body : CollectionsStringProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/nullable/collections/string/null",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/merge-patch+json")
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Patch, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
