///|
/// BooleanClient HTTP 客户端。
pub(all) struct BooleanClient {
  base_url : String
}

///|
/// 创建 BooleanClient。
pub fn BooleanClient::new(base_url : String) -> BooleanClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/boolean（自动解析响应）。
pub async fn BooleanClient::get_type_property_value_types_boolean(
  self : BooleanClient,
) -> BooleanProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/boolean",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : BooleanProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/boolean（自动解析响应）。
pub async fn BooleanClient::put_type_property_value_types_boolean(
  self : BooleanClient,
  body : BooleanProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/boolean",
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
/// 调用 get /type/property/value-types/string（自动解析响应）。
pub async fn StringClient::get_type_property_value_types_string(
  self : StringClient,
) -> StringProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/string",
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
/// 调用 put /type/property/value-types/string（自动解析响应）。
pub async fn StringClient::put_type_property_value_types_string(
  self : StringClient,
  body : StringProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/string",
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
/// 调用 get /type/property/value-types/bytes（自动解析响应）。
pub async fn BytesClient::get_type_property_value_types_bytes(
  self : BytesClient,
) -> BytesProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/bytes",
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
/// 调用 put /type/property/value-types/bytes（自动解析响应）。
pub async fn BytesClient::put_type_property_value_types_bytes(
  self : BytesClient,
  body : BytesProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/bytes",
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
/// IntClient HTTP 客户端。
pub(all) struct IntClient {
  base_url : String
}

///|
/// 创建 IntClient。
pub fn IntClient::new(base_url : String) -> IntClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/int（自动解析响应）。
pub async fn IntClient::get_type_property_value_types_int(
  self : IntClient,
) -> IntProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/int",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : IntProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/int（自动解析响应）。
pub async fn IntClient::put_type_property_value_types_int(
  self : IntClient,
  body : IntProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/int",
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
/// FloatClient HTTP 客户端。
pub(all) struct FloatClient {
  base_url : String
}

///|
/// 创建 FloatClient。
pub fn FloatClient::new(base_url : String) -> FloatClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/float（自动解析响应）。
pub async fn FloatClient::get_type_property_value_types_float(
  self : FloatClient,
) -> FloatProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/float",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : FloatProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/float（自动解析响应）。
pub async fn FloatClient::put_type_property_value_types_float(
  self : FloatClient,
  body : FloatProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/float",
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
/// DecimalClient HTTP 客户端。
pub(all) struct DecimalClient {
  base_url : String
}

///|
/// 创建 DecimalClient。
pub fn DecimalClient::new(base_url : String) -> DecimalClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/decimal（自动解析响应）。
pub async fn DecimalClient::get_type_property_value_types_decimal(
  self : DecimalClient,
) -> DecimalProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/decimal",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : DecimalProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/decimal（自动解析响应）。
pub async fn DecimalClient::put_type_property_value_types_decimal(
  self : DecimalClient,
  body : DecimalProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/decimal",
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
/// Decimal128Client HTTP 客户端。
pub(all) struct Decimal128Client {
  base_url : String
}

///|
/// 创建 Decimal128Client。
pub fn Decimal128Client::new(base_url : String) -> Decimal128Client {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/decimal128（自动解析响应）。
pub async fn Decimal128Client::get_type_property_value_types_decimal128(
  self : Decimal128Client,
) -> Decimal128Property {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/decimal128",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Decimal128Property = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/decimal128（自动解析响应）。
pub async fn Decimal128Client::put_type_property_value_types_decimal128(
  self : Decimal128Client,
  body : Decimal128Property,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/decimal128",
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
/// 调用 get /type/property/value-types/datetime（自动解析响应）。
pub async fn DatetimeClient::get_type_property_value_types_datetime(
  self : DatetimeClient,
) -> DatetimeProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/datetime",
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
/// 调用 put /type/property/value-types/datetime（自动解析响应）。
pub async fn DatetimeClient::put_type_property_value_types_datetime(
  self : DatetimeClient,
  body : DatetimeProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/datetime",
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
/// 调用 get /type/property/value-types/duration（自动解析响应）。
pub async fn DurationClient::get_type_property_value_types_duration(
  self : DurationClient,
) -> DurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/duration",
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
/// 调用 put /type/property/value-types/duration（自动解析响应）。
pub async fn DurationClient::put_type_property_value_types_duration(
  self : DurationClient,
  body : DurationProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/duration",
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
/// EnumClient HTTP 客户端。
pub(all) struct EnumClient {
  base_url : String
}

///|
/// 创建 EnumClient。
pub fn EnumClient::new(base_url : String) -> EnumClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/enum（自动解析响应）。
pub async fn EnumClient::get_type_property_value_types_enum(
  self : EnumClient,
) -> EnumProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/enum",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : EnumProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/enum（自动解析响应）。
pub async fn EnumClient::put_type_property_value_types_enum(
  self : EnumClient,
  body : EnumProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/enum",
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
/// ExtensibleEnumClient HTTP 客户端。
pub(all) struct ExtensibleEnumClient {
  base_url : String
}

///|
/// 创建 ExtensibleEnumClient。
pub fn ExtensibleEnumClient::new(base_url : String) -> ExtensibleEnumClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/extensible-enum（自动解析响应）。
pub async fn ExtensibleEnumClient::get_type_property_value_types_extensible_enum(
  self : ExtensibleEnumClient,
) -> ExtensibleEnumProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/extensible-enum",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ExtensibleEnumProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/extensible-enum（自动解析响应）。
pub async fn ExtensibleEnumClient::put_type_property_value_types_extensible_enum(
  self : ExtensibleEnumClient,
  body : ExtensibleEnumProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/extensible-enum",
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
/// ModelClient HTTP 客户端。
pub(all) struct ModelClient {
  base_url : String
}

///|
/// 创建 ModelClient。
pub fn ModelClient::new(base_url : String) -> ModelClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/model（自动解析响应）。
pub async fn ModelClient::get_type_property_value_types_model(
  self : ModelClient,
) -> ModelProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/model",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ModelProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/model（自动解析响应）。
pub async fn ModelClient::put_type_property_value_types_model(
  self : ModelClient,
  body : ModelProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/model",
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
/// 调用 get /type/property/value-types/collections/string（自动解析响应）。
pub async fn CollectionsStringClient::get_type_property_value_types_collections_string(
  self : CollectionsStringClient,
) -> CollectionsStringProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/collections/string",
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
/// 调用 put /type/property/value-types/collections/string（自动解析响应）。
pub async fn CollectionsStringClient::put_type_property_value_types_collections_string(
  self : CollectionsStringClient,
  body : CollectionsStringProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/collections/string",
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
/// CollectionsIntClient HTTP 客户端。
pub(all) struct CollectionsIntClient {
  base_url : String
}

///|
/// 创建 CollectionsIntClient。
pub fn CollectionsIntClient::new(base_url : String) -> CollectionsIntClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/collections/int（自动解析响应）。
pub async fn CollectionsIntClient::get_type_property_value_types_collections_int(
  self : CollectionsIntClient,
) -> CollectionsIntProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/collections/int",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : CollectionsIntProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/collections/int（自动解析响应）。
pub async fn CollectionsIntClient::put_type_property_value_types_collections_int(
  self : CollectionsIntClient,
  body : CollectionsIntProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/collections/int",
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
/// 调用 get /type/property/value-types/collections/model（自动解析响应）。
pub async fn CollectionsModelClient::get_type_property_value_types_collections_model(
  self : CollectionsModelClient,
) -> CollectionsModelProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/collections/model",
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
/// 调用 put /type/property/value-types/collections/model（自动解析响应）。
pub async fn CollectionsModelClient::put_type_property_value_types_collections_model(
  self : CollectionsModelClient,
  body : CollectionsModelProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/collections/model",
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
/// DictionaryStringClient HTTP 客户端。
pub(all) struct DictionaryStringClient {
  base_url : String
}

///|
/// 创建 DictionaryStringClient。
pub fn DictionaryStringClient::new(base_url : String) -> DictionaryStringClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/dictionary/string（自动解析响应）。
pub async fn DictionaryStringClient::get_type_property_value_types_dictionary_string(
  self : DictionaryStringClient,
) -> DictionaryStringProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/dictionary/string",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : DictionaryStringProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/dictionary/string（自动解析响应）。
pub async fn DictionaryStringClient::put_type_property_value_types_dictionary_string(
  self : DictionaryStringClient,
  body : DictionaryStringProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/dictionary/string",
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
/// NeverClient HTTP 客户端。
pub(all) struct NeverClient {
  base_url : String
}

///|
/// 创建 NeverClient。
pub fn NeverClient::new(base_url : String) -> NeverClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/never（自动解析响应）。
pub async fn NeverClient::get_type_property_value_types_never(
  self : NeverClient,
) -> NeverProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/never",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : NeverProperty = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/never（自动解析响应）。
pub async fn NeverClient::put_type_property_value_types_never(
  self : NeverClient,
  body : NeverProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/never",
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
/// UnknownStringClient HTTP 客户端。
pub(all) struct UnknownStringClient {
  base_url : String
}

///|
/// 创建 UnknownStringClient。
pub fn UnknownStringClient::new(base_url : String) -> UnknownStringClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/unknown/string（自动解析响应）。
pub async fn UnknownStringClient::get_type_property_value_types_unknown_string(
  self : UnknownStringClient,
) -> UnknownStringProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/unknown/string",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : UnknownStringProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/unknown/string（自动解析响应）。
pub async fn UnknownStringClient::put_type_property_value_types_unknown_string(
  self : UnknownStringClient,
  body : UnknownStringProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/unknown/string",
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
/// UnknownIntClient HTTP 客户端。
pub(all) struct UnknownIntClient {
  base_url : String
}

///|
/// 创建 UnknownIntClient。
pub fn UnknownIntClient::new(base_url : String) -> UnknownIntClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/unknown/int（自动解析响应）。
pub async fn UnknownIntClient::get_type_property_value_types_unknown_int(
  self : UnknownIntClient,
) -> UnknownIntProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/unknown/int",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : UnknownIntProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/unknown/int（自动解析响应）。
pub async fn UnknownIntClient::put_type_property_value_types_unknown_int(
  self : UnknownIntClient,
  body : UnknownIntProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/unknown/int",
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
/// UnknownDictClient HTTP 客户端。
pub(all) struct UnknownDictClient {
  base_url : String
}

///|
/// 创建 UnknownDictClient。
pub fn UnknownDictClient::new(base_url : String) -> UnknownDictClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/unknown/dict（自动解析响应）。
pub async fn UnknownDictClient::get_type_property_value_types_unknown_dict(
  self : UnknownDictClient,
) -> UnknownDictProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/unknown/dict",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : UnknownDictProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/unknown/dict（自动解析响应）。
pub async fn UnknownDictClient::put_type_property_value_types_unknown_dict(
  self : UnknownDictClient,
  body : UnknownDictProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/unknown/dict",
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
/// UnknownArrayClient HTTP 客户端。
pub(all) struct UnknownArrayClient {
  base_url : String
}

///|
/// 创建 UnknownArrayClient。
pub fn UnknownArrayClient::new(base_url : String) -> UnknownArrayClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/unknown/array（自动解析响应）。
pub async fn UnknownArrayClient::get_type_property_value_types_unknown_array(
  self : UnknownArrayClient,
) -> UnknownArrayProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/unknown/array",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : UnknownArrayProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/unknown/array（自动解析响应）。
pub async fn UnknownArrayClient::put_type_property_value_types_unknown_array(
  self : UnknownArrayClient,
  body : UnknownArrayProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/unknown/array",
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
/// StringLiteralClient HTTP 客户端。
pub(all) struct StringLiteralClient {
  base_url : String
}

///|
/// 创建 StringLiteralClient。
pub fn StringLiteralClient::new(base_url : String) -> StringLiteralClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/string/literal（自动解析响应）。
pub async fn StringLiteralClient::get_type_property_value_types_string_literal(
  self : StringLiteralClient,
) -> StringLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/string/literal",
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
/// 调用 put /type/property/value-types/string/literal（自动解析响应）。
pub async fn StringLiteralClient::put_type_property_value_types_string_literal(
  self : StringLiteralClient,
  body : StringLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/string/literal",
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
/// IntLiteralClient HTTP 客户端。
pub(all) struct IntLiteralClient {
  base_url : String
}

///|
/// 创建 IntLiteralClient。
pub fn IntLiteralClient::new(base_url : String) -> IntLiteralClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/int/literal（自动解析响应）。
pub async fn IntLiteralClient::get_type_property_value_types_int_literal(
  self : IntLiteralClient,
) -> IntLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/int/literal",
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
/// 调用 put /type/property/value-types/int/literal（自动解析响应）。
pub async fn IntLiteralClient::put_type_property_value_types_int_literal(
  self : IntLiteralClient,
  body : IntLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/int/literal",
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
/// FloatLiteralClient HTTP 客户端。
pub(all) struct FloatLiteralClient {
  base_url : String
}

///|
/// 创建 FloatLiteralClient。
pub fn FloatLiteralClient::new(base_url : String) -> FloatLiteralClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/float/literal（自动解析响应）。
pub async fn FloatLiteralClient::get_type_property_value_types_float_literal(
  self : FloatLiteralClient,
) -> FloatLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/float/literal",
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
/// 调用 put /type/property/value-types/float/literal（自动解析响应）。
pub async fn FloatLiteralClient::put_type_property_value_types_float_literal(
  self : FloatLiteralClient,
  body : FloatLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/float/literal",
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
/// BooleanLiteralClient HTTP 客户端。
pub(all) struct BooleanLiteralClient {
  base_url : String
}

///|
/// 创建 BooleanLiteralClient。
pub fn BooleanLiteralClient::new(base_url : String) -> BooleanLiteralClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/boolean/literal（自动解析响应）。
pub async fn BooleanLiteralClient::get_type_property_value_types_boolean_literal(
  self : BooleanLiteralClient,
) -> BooleanLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/boolean/literal",
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
/// 调用 put /type/property/value-types/boolean/literal（自动解析响应）。
pub async fn BooleanLiteralClient::put_type_property_value_types_boolean_literal(
  self : BooleanLiteralClient,
  body : BooleanLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/boolean/literal",
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
/// UnionStringLiteralClient HTTP 客户端。
pub(all) struct UnionStringLiteralClient {
  base_url : String
}

///|
/// 创建 UnionStringLiteralClient。
pub fn UnionStringLiteralClient::new(
  base_url : String,
) -> UnionStringLiteralClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/union/string/literal（自动解析响应）。
pub async fn UnionStringLiteralClient::get_type_property_value_types_union_string_literal(
  self : UnionStringLiteralClient,
) -> UnionStringLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/union/string/literal",
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
/// 调用 put /type/property/value-types/union/string/literal（自动解析响应）。
pub async fn UnionStringLiteralClient::put_type_property_value_types_union_string_literal(
  self : UnionStringLiteralClient,
  body : UnionStringLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/union/string/literal",
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
/// UnionIntLiteralClient HTTP 客户端。
pub(all) struct UnionIntLiteralClient {
  base_url : String
}

///|
/// 创建 UnionIntLiteralClient。
pub fn UnionIntLiteralClient::new(base_url : String) -> UnionIntLiteralClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/union/int/literal（自动解析响应）。
pub async fn UnionIntLiteralClient::get_type_property_value_types_union_int_literal(
  self : UnionIntLiteralClient,
) -> UnionIntLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/union/int/literal",
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
/// 调用 put /type/property/value-types/union/int/literal（自动解析响应）。
pub async fn UnionIntLiteralClient::put_type_property_value_types_union_int_literal(
  self : UnionIntLiteralClient,
  body : UnionIntLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/union/int/literal",
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
/// UnionFloatLiteralClient HTTP 客户端。
pub(all) struct UnionFloatLiteralClient {
  base_url : String
}

///|
/// 创建 UnionFloatLiteralClient。
pub fn UnionFloatLiteralClient::new(
  base_url : String,
) -> UnionFloatLiteralClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/union/float/literal（自动解析响应）。
pub async fn UnionFloatLiteralClient::get_type_property_value_types_union_float_literal(
  self : UnionFloatLiteralClient,
) -> UnionFloatLiteralProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/union/float/literal",
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
/// 调用 put /type/property/value-types/union/float/literal（自动解析响应）。
pub async fn UnionFloatLiteralClient::put_type_property_value_types_union_float_literal(
  self : UnionFloatLiteralClient,
  body : UnionFloatLiteralProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/union/float/literal",
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
/// UnionEnumValueClient HTTP 客户端。
pub(all) struct UnionEnumValueClient {
  base_url : String
}

///|
/// 创建 UnionEnumValueClient。
pub fn UnionEnumValueClient::new(base_url : String) -> UnionEnumValueClient {
  { base_url, }
}

///|
/// 调用 get /type/property/value-types/union-enum-value（自动解析响应）。
pub async fn UnionEnumValueClient::get_type_property_value_types_union_enum_value(
  self : UnionEnumValueClient,
) -> UnionEnumValueProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/union-enum-value",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : UnionEnumValueProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/value-types/union-enum-value（自动解析响应）。
pub async fn UnionEnumValueClient::put_type_property_value_types_union_enum_value(
  self : UnionEnumValueClient,
  body : UnionEnumValueProperty,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/value-types/union-enum-value",
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
