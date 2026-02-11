///|
/// ExtendsUnknownClient HTTP 客户端。
pub(all) struct ExtendsUnknownClient {
  base_url : String
}

///|
/// 创建 ExtendsUnknownClient。
pub fn ExtendsUnknownClient::new(base_url : String) -> ExtendsUnknownClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/extendsRecordUnknown（自动解析响应）。
pub async fn ExtendsUnknownClient::get_type_property_additionalproperties_extendsrecordunknown(
  self : ExtendsUnknownClient,
) -> ExtendsUnknownAdditionalProperties {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsRecordUnknown",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ExtendsUnknownAdditionalProperties = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/extendsRecordUnknown（自动解析响应）。
pub async fn ExtendsUnknownClient::put_type_property_additionalproperties_extendsrecordunknown(
  self : ExtendsUnknownClient,
  body : ExtendsUnknownAdditionalProperties,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsRecordUnknown",
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
/// ExtendsUnknownDerivedClient HTTP 客户端。
pub(all) struct ExtendsUnknownDerivedClient {
  base_url : String
}

///|
/// 创建 ExtendsUnknownDerivedClient。
pub fn ExtendsUnknownDerivedClient::new(
  base_url : String,
) -> ExtendsUnknownDerivedClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/extendsRecordUnknownDerived（自动解析响应）。
pub async fn ExtendsUnknownDerivedClient::get_type_property_additionalproperties_extendsrecordunknownderived(
  self : ExtendsUnknownDerivedClient,
) -> ExtendsUnknownAdditionalPropertiesDerived {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsRecordUnknownDerived",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ExtendsUnknownAdditionalPropertiesDerived = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/extendsRecordUnknownDerived（自动解析响应）。
pub async fn ExtendsUnknownDerivedClient::put_type_property_additionalproperties_extendsrecordunknownderived(
  self : ExtendsUnknownDerivedClient,
  body : ExtendsUnknownAdditionalPropertiesDerived,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsRecordUnknownDerived",
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
/// ExtendsUnknownDiscriminatedClient HTTP 客户端。
pub(all) struct ExtendsUnknownDiscriminatedClient {
  base_url : String
}

///|
/// 创建 ExtendsUnknownDiscriminatedClient。
pub fn ExtendsUnknownDiscriminatedClient::new(
  base_url : String,
) -> ExtendsUnknownDiscriminatedClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/extendsUnknownDiscriminated（自动解析响应）。
pub async fn ExtendsUnknownDiscriminatedClient::get_type_property_additionalproperties_extendsunknowndiscriminated(
  self : ExtendsUnknownDiscriminatedClient,
) -> ExtendsUnknownAdditionalPropertiesDiscriminated {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsUnknownDiscriminated",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ExtendsUnknownAdditionalPropertiesDiscriminated = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/extendsUnknownDiscriminated（自动解析响应）。
pub async fn ExtendsUnknownDiscriminatedClient::put_type_property_additionalproperties_extendsunknowndiscriminated(
  self : ExtendsUnknownDiscriminatedClient,
  body : ExtendsUnknownAdditionalPropertiesDiscriminated,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsUnknownDiscriminated",
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
/// IsUnknownClient HTTP 客户端。
pub(all) struct IsUnknownClient {
  base_url : String
}

///|
/// 创建 IsUnknownClient。
pub fn IsUnknownClient::new(base_url : String) -> IsUnknownClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/isRecordUnknown（自动解析响应）。
pub async fn IsUnknownClient::get_type_property_additionalproperties_isrecordunknown(
  self : IsUnknownClient,
) -> Map[String, Json] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isRecordUnknown",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Json] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/isRecordUnknown（自动解析响应）。
pub async fn IsUnknownClient::put_type_property_additionalproperties_isrecordunknown(
  self : IsUnknownClient,
  body : Map[String, Json],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isRecordUnknown",
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
/// IsUnknownDerivedClient HTTP 客户端。
pub(all) struct IsUnknownDerivedClient {
  base_url : String
}

///|
/// 创建 IsUnknownDerivedClient。
pub fn IsUnknownDerivedClient::new(base_url : String) -> IsUnknownDerivedClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/isRecordUnknownDerived（自动解析响应）。
pub async fn IsUnknownDerivedClient::get_type_property_additionalproperties_isrecordunknownderived(
  self : IsUnknownDerivedClient,
) -> IsUnknownAdditionalPropertiesDerived {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isRecordUnknownDerived",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : IsUnknownAdditionalPropertiesDerived = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/isRecordUnknownDerived（自动解析响应）。
pub async fn IsUnknownDerivedClient::put_type_property_additionalproperties_isrecordunknownderived(
  self : IsUnknownDerivedClient,
  body : IsUnknownAdditionalPropertiesDerived,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isRecordUnknownDerived",
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
/// IsUnknownDiscriminatedClient HTTP 客户端。
pub(all) struct IsUnknownDiscriminatedClient {
  base_url : String
}

///|
/// 创建 IsUnknownDiscriminatedClient。
pub fn IsUnknownDiscriminatedClient::new(
  base_url : String,
) -> IsUnknownDiscriminatedClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/isUnknownDiscriminated（自动解析响应）。
pub async fn IsUnknownDiscriminatedClient::get_type_property_additionalproperties_isunknowndiscriminated(
  self : IsUnknownDiscriminatedClient,
) -> Map[String, Json] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isUnknownDiscriminated",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Json] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/isUnknownDiscriminated（自动解析响应）。
pub async fn IsUnknownDiscriminatedClient::put_type_property_additionalproperties_isunknowndiscriminated(
  self : IsUnknownDiscriminatedClient,
  body : Map[String, Json],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isUnknownDiscriminated",
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
/// ExtendsStringClient HTTP 客户端。
pub(all) struct ExtendsStringClient {
  base_url : String
}

///|
/// 创建 ExtendsStringClient。
pub fn ExtendsStringClient::new(base_url : String) -> ExtendsStringClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/extendsRecordString（自动解析响应）。
pub async fn ExtendsStringClient::get_type_property_additionalproperties_extendsrecordstring(
  self : ExtendsStringClient,
) -> ExtendsStringAdditionalProperties {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsRecordString",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ExtendsStringAdditionalProperties = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/extendsRecordString（自动解析响应）。
pub async fn ExtendsStringClient::put_type_property_additionalproperties_extendsrecordstring(
  self : ExtendsStringClient,
  body : ExtendsStringAdditionalProperties,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsRecordString",
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
/// IsStringClient HTTP 客户端。
pub(all) struct IsStringClient {
  base_url : String
}

///|
/// 创建 IsStringClient。
pub fn IsStringClient::new(base_url : String) -> IsStringClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/isRecordstring（自动解析响应）。
pub async fn IsStringClient::get_type_property_additionalproperties_isrecordstring(
  self : IsStringClient,
) -> Map[String, String] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isRecordstring",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, String] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/isRecordstring（自动解析响应）。
pub async fn IsStringClient::put_type_property_additionalproperties_isrecordstring(
  self : IsStringClient,
  body : Map[String, String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isRecordstring",
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
/// SpreadStringClient HTTP 客户端。
pub(all) struct SpreadStringClient {
  base_url : String
}

///|
/// 创建 SpreadStringClient。
pub fn SpreadStringClient::new(base_url : String) -> SpreadStringClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/spreadRecordString（自动解析响应）。
pub async fn SpreadStringClient::get_type_property_additionalproperties_spreadrecordstring(
  self : SpreadStringClient,
) -> Map[String, String] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordString",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, String] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/spreadRecordString（自动解析响应）。
pub async fn SpreadStringClient::put_type_property_additionalproperties_spreadrecordstring(
  self : SpreadStringClient,
  body : Map[String, String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordString",
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
/// ExtendsFloatClient HTTP 客户端。
pub(all) struct ExtendsFloatClient {
  base_url : String
}

///|
/// 创建 ExtendsFloatClient。
pub fn ExtendsFloatClient::new(base_url : String) -> ExtendsFloatClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/extendsRecordFloat（自动解析响应）。
pub async fn ExtendsFloatClient::get_type_property_additionalproperties_extendsrecordfloat(
  self : ExtendsFloatClient,
) -> ExtendsFloatAdditionalProperties {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsRecordFloat",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ExtendsFloatAdditionalProperties = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/extendsRecordFloat（自动解析响应）。
pub async fn ExtendsFloatClient::put_type_property_additionalproperties_extendsrecordfloat(
  self : ExtendsFloatClient,
  body : ExtendsFloatAdditionalProperties,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsRecordFloat",
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
/// IsFloatClient HTTP 客户端。
pub(all) struct IsFloatClient {
  base_url : String
}

///|
/// 创建 IsFloatClient。
pub fn IsFloatClient::new(base_url : String) -> IsFloatClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/isRecordFloat（自动解析响应）。
pub async fn IsFloatClient::get_type_property_additionalproperties_isrecordfloat(
  self : IsFloatClient,
) -> Map[String, Double] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isRecordFloat",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Double] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/isRecordFloat（自动解析响应）。
pub async fn IsFloatClient::put_type_property_additionalproperties_isrecordfloat(
  self : IsFloatClient,
  body : Map[String, Double],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isRecordFloat",
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
/// SpreadFloatClient HTTP 客户端。
pub(all) struct SpreadFloatClient {
  base_url : String
}

///|
/// 创建 SpreadFloatClient。
pub fn SpreadFloatClient::new(base_url : String) -> SpreadFloatClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/spreadRecordFloat（自动解析响应）。
pub async fn SpreadFloatClient::get_type_property_additionalproperties_spreadrecordfloat(
  self : SpreadFloatClient,
) -> Map[String, Double] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordFloat",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Double] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/spreadRecordFloat（自动解析响应）。
pub async fn SpreadFloatClient::put_type_property_additionalproperties_spreadrecordfloat(
  self : SpreadFloatClient,
  body : Map[String, Double],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordFloat",
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
/// ExtendsModelClient HTTP 客户端。
pub(all) struct ExtendsModelClient {
  base_url : String
}

///|
/// 创建 ExtendsModelClient。
pub fn ExtendsModelClient::new(base_url : String) -> ExtendsModelClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/extendsRecordModel（自动解析响应）。
pub async fn ExtendsModelClient::get_type_property_additionalproperties_extendsrecordmodel(
  self : ExtendsModelClient,
) -> ExtendsModelAdditionalProperties {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsRecordModel",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ExtendsModelAdditionalProperties = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/extendsRecordModel（自动解析响应）。
pub async fn ExtendsModelClient::put_type_property_additionalproperties_extendsrecordmodel(
  self : ExtendsModelClient,
  body : ExtendsModelAdditionalProperties,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsRecordModel",
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
/// IsModelClient HTTP 客户端。
pub(all) struct IsModelClient {
  base_url : String
}

///|
/// 创建 IsModelClient。
pub fn IsModelClient::new(base_url : String) -> IsModelClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/isRecordModel（自动解析响应）。
pub async fn IsModelClient::get_type_property_additionalproperties_isrecordmodel(
  self : IsModelClient,
) -> Map[String, ModelForRecord] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isRecordModel",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, ModelForRecord] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/isRecordModel（自动解析响应）。
pub async fn IsModelClient::put_type_property_additionalproperties_isrecordmodel(
  self : IsModelClient,
  body : Map[String, ModelForRecord],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isRecordModel",
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
/// SpreadModelClient HTTP 客户端。
pub(all) struct SpreadModelClient {
  base_url : String
}

///|
/// 创建 SpreadModelClient。
pub fn SpreadModelClient::new(base_url : String) -> SpreadModelClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/spreadRecordModel（自动解析响应）。
pub async fn SpreadModelClient::get_type_property_additionalproperties_spreadrecordmodel(
  self : SpreadModelClient,
) -> Map[String, ModelForRecord] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordModel",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, ModelForRecord] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/spreadRecordModel（自动解析响应）。
pub async fn SpreadModelClient::put_type_property_additionalproperties_spreadrecordmodel(
  self : SpreadModelClient,
  body : Map[String, ModelForRecord],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordModel",
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
/// ExtendsModelArrayClient HTTP 客户端。
pub(all) struct ExtendsModelArrayClient {
  base_url : String
}

///|
/// 创建 ExtendsModelArrayClient。
pub fn ExtendsModelArrayClient::new(
  base_url : String,
) -> ExtendsModelArrayClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/extendsRecordModelArray（自动解析响应）。
pub async fn ExtendsModelArrayClient::get_type_property_additionalproperties_extendsrecordmodelarray(
  self : ExtendsModelArrayClient,
) -> ExtendsModelArrayAdditionalProperties {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsRecordModelArray",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ExtendsModelArrayAdditionalProperties = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/extendsRecordModelArray（自动解析响应）。
pub async fn ExtendsModelArrayClient::put_type_property_additionalproperties_extendsrecordmodelarray(
  self : ExtendsModelArrayClient,
  body : ExtendsModelArrayAdditionalProperties,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsRecordModelArray",
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
/// IsModelArrayClient HTTP 客户端。
pub(all) struct IsModelArrayClient {
  base_url : String
}

///|
/// 创建 IsModelArrayClient。
pub fn IsModelArrayClient::new(base_url : String) -> IsModelArrayClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/isRecordModelArray（自动解析响应）。
pub async fn IsModelArrayClient::get_type_property_additionalproperties_isrecordmodelarray(
  self : IsModelArrayClient,
) -> Map[String, Array[ModelForRecord]] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isRecordModelArray",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Array[ModelForRecord]] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/isRecordModelArray（自动解析响应）。
pub async fn IsModelArrayClient::put_type_property_additionalproperties_isrecordmodelarray(
  self : IsModelArrayClient,
  body : Map[String, Array[ModelForRecord]],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/isRecordModelArray",
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
/// SpreadModelArrayClient HTTP 客户端。
pub(all) struct SpreadModelArrayClient {
  base_url : String
}

///|
/// 创建 SpreadModelArrayClient。
pub fn SpreadModelArrayClient::new(base_url : String) -> SpreadModelArrayClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/spreadRecordModelArray（自动解析响应）。
pub async fn SpreadModelArrayClient::get_type_property_additionalproperties_spreadrecordmodelarray(
  self : SpreadModelArrayClient,
) -> Map[String, Array[ModelForRecord]] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordModelArray",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Array[ModelForRecord]] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/spreadRecordModelArray（自动解析响应）。
pub async fn SpreadModelArrayClient::put_type_property_additionalproperties_spreadrecordmodelarray(
  self : SpreadModelArrayClient,
  body : Map[String, Array[ModelForRecord]],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordModelArray",
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
/// SpreadDifferentStringClient HTTP 客户端。
pub(all) struct SpreadDifferentStringClient {
  base_url : String
}

///|
/// 创建 SpreadDifferentStringClient。
pub fn SpreadDifferentStringClient::new(
  base_url : String,
) -> SpreadDifferentStringClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/spreadDifferentRecordString（自动解析响应）。
pub async fn SpreadDifferentStringClient::get_type_property_additionalproperties_spreaddifferentrecordstring(
  self : SpreadDifferentStringClient,
) -> Map[String, String] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadDifferentRecordString",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, String] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/spreadDifferentRecordString（自动解析响应）。
pub async fn SpreadDifferentStringClient::put_type_property_additionalproperties_spreaddifferentrecordstring(
  self : SpreadDifferentStringClient,
  body : Map[String, String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadDifferentRecordString",
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
/// SpreadDifferentFloatClient HTTP 客户端。
pub(all) struct SpreadDifferentFloatClient {
  base_url : String
}

///|
/// 创建 SpreadDifferentFloatClient。
pub fn SpreadDifferentFloatClient::new(
  base_url : String,
) -> SpreadDifferentFloatClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/spreadDifferentRecordFloat（自动解析响应）。
pub async fn SpreadDifferentFloatClient::get_type_property_additionalproperties_spreaddifferentrecordfloat(
  self : SpreadDifferentFloatClient,
) -> Map[String, Double] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadDifferentRecordFloat",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Double] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/spreadDifferentRecordFloat（自动解析响应）。
pub async fn SpreadDifferentFloatClient::put_type_property_additionalproperties_spreaddifferentrecordfloat(
  self : SpreadDifferentFloatClient,
  body : Map[String, Double],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadDifferentRecordFloat",
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
/// SpreadDifferentModelClient HTTP 客户端。
pub(all) struct SpreadDifferentModelClient {
  base_url : String
}

///|
/// 创建 SpreadDifferentModelClient。
pub fn SpreadDifferentModelClient::new(
  base_url : String,
) -> SpreadDifferentModelClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/spreadDifferentRecordModel（自动解析响应）。
pub async fn SpreadDifferentModelClient::get_type_property_additionalproperties_spreaddifferentrecordmodel(
  self : SpreadDifferentModelClient,
) -> Map[String, ModelForRecord] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadDifferentRecordModel",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, ModelForRecord] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/spreadDifferentRecordModel（自动解析响应）。
pub async fn SpreadDifferentModelClient::put_type_property_additionalproperties_spreaddifferentrecordmodel(
  self : SpreadDifferentModelClient,
  body : Map[String, ModelForRecord],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadDifferentRecordModel",
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
/// SpreadDifferentModelArrayClient HTTP 客户端。
pub(all) struct SpreadDifferentModelArrayClient {
  base_url : String
}

///|
/// 创建 SpreadDifferentModelArrayClient。
pub fn SpreadDifferentModelArrayClient::new(
  base_url : String,
) -> SpreadDifferentModelArrayClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/spreadDifferentRecordModelArray（自动解析响应）。
pub async fn SpreadDifferentModelArrayClient::get_type_property_additionalproperties_spreaddifferentrecordmodelarray(
  self : SpreadDifferentModelArrayClient,
) -> Map[String, Array[ModelForRecord]] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadDifferentRecordModelArray",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Array[ModelForRecord]] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/spreadDifferentRecordModelArray（自动解析响应）。
pub async fn SpreadDifferentModelArrayClient::put_type_property_additionalproperties_spreaddifferentrecordmodelarray(
  self : SpreadDifferentModelArrayClient,
  body : Map[String, Array[ModelForRecord]],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadDifferentRecordModelArray",
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
/// ExtendsDifferentSpreadStringClient HTTP 客户端。
pub(all) struct ExtendsDifferentSpreadStringClient {
  base_url : String
}

///|
/// 创建 ExtendsDifferentSpreadStringClient。
pub fn ExtendsDifferentSpreadStringClient::new(
  base_url : String,
) -> ExtendsDifferentSpreadStringClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/extendsDifferentSpreadString（自动解析响应）。
pub async fn ExtendsDifferentSpreadStringClient::get_type_property_additionalproperties_extendsdifferentspreadstring(
  self : ExtendsDifferentSpreadStringClient,
) -> DifferentSpreadStringDerived {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsDifferentSpreadString",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : DifferentSpreadStringDerived = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/extendsDifferentSpreadString（自动解析响应）。
pub async fn ExtendsDifferentSpreadStringClient::put_type_property_additionalproperties_extendsdifferentspreadstring(
  self : ExtendsDifferentSpreadStringClient,
  body : DifferentSpreadStringDerived,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsDifferentSpreadString",
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
/// ExtendsDifferentSpreadFloatClient HTTP 客户端。
pub(all) struct ExtendsDifferentSpreadFloatClient {
  base_url : String
}

///|
/// 创建 ExtendsDifferentSpreadFloatClient。
pub fn ExtendsDifferentSpreadFloatClient::new(
  base_url : String,
) -> ExtendsDifferentSpreadFloatClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/extendsDifferentSpreadFloat（自动解析响应）。
pub async fn ExtendsDifferentSpreadFloatClient::get_type_property_additionalproperties_extendsdifferentspreadfloat(
  self : ExtendsDifferentSpreadFloatClient,
) -> DifferentSpreadFloatDerived {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsDifferentSpreadFloat",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : DifferentSpreadFloatDerived = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/extendsDifferentSpreadFloat（自动解析响应）。
pub async fn ExtendsDifferentSpreadFloatClient::put_type_property_additionalproperties_extendsdifferentspreadfloat(
  self : ExtendsDifferentSpreadFloatClient,
  body : DifferentSpreadFloatDerived,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsDifferentSpreadFloat",
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
/// ExtendsDifferentSpreadModelClient HTTP 客户端。
pub(all) struct ExtendsDifferentSpreadModelClient {
  base_url : String
}

///|
/// 创建 ExtendsDifferentSpreadModelClient。
pub fn ExtendsDifferentSpreadModelClient::new(
  base_url : String,
) -> ExtendsDifferentSpreadModelClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/extendsDifferentSpreadModel（自动解析响应）。
pub async fn ExtendsDifferentSpreadModelClient::get_type_property_additionalproperties_extendsdifferentspreadmodel(
  self : ExtendsDifferentSpreadModelClient,
) -> DifferentSpreadModelDerived {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsDifferentSpreadModel",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : DifferentSpreadModelDerived = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/extendsDifferentSpreadModel（自动解析响应）。
pub async fn ExtendsDifferentSpreadModelClient::put_type_property_additionalproperties_extendsdifferentspreadmodel(
  self : ExtendsDifferentSpreadModelClient,
  body : DifferentSpreadModelDerived,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsDifferentSpreadModel",
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
/// ExtendsDifferentSpreadModelArrayClient HTTP 客户端。
pub(all) struct ExtendsDifferentSpreadModelArrayClient {
  base_url : String
}

///|
/// 创建 ExtendsDifferentSpreadModelArrayClient。
pub fn ExtendsDifferentSpreadModelArrayClient::new(
  base_url : String,
) -> ExtendsDifferentSpreadModelArrayClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/extendsDifferentSpreadModelArray（自动解析响应）。
pub async fn ExtendsDifferentSpreadModelArrayClient::get_type_property_additionalproperties_extendsdifferentspreadmodelarray(
  self : ExtendsDifferentSpreadModelArrayClient,
) -> DifferentSpreadModelArrayDerived {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsDifferentSpreadModelArray",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : DifferentSpreadModelArrayDerived = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/extendsDifferentSpreadModelArray（自动解析响应）。
pub async fn ExtendsDifferentSpreadModelArrayClient::put_type_property_additionalproperties_extendsdifferentspreadmodelarray(
  self : ExtendsDifferentSpreadModelArrayClient,
  body : DifferentSpreadModelArrayDerived,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/extendsDifferentSpreadModelArray",
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
/// MultipleSpreadClient HTTP 客户端。
pub(all) struct MultipleSpreadClient {
  base_url : String
}

///|
/// 创建 MultipleSpreadClient。
pub fn MultipleSpreadClient::new(base_url : String) -> MultipleSpreadClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/multipleSpreadRecord（自动解析响应）。
pub async fn MultipleSpreadClient::get_type_property_additionalproperties_multiplespreadrecord(
  self : MultipleSpreadClient,
) -> Map[String, Union1] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/multipleSpreadRecord",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Union1] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/multipleSpreadRecord（自动解析响应）。
pub async fn MultipleSpreadClient::put_type_property_additionalproperties_multiplespreadrecord(
  self : MultipleSpreadClient,
  body : Map[String, Union1],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/multipleSpreadRecord",
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
/// SpreadRecordUnionClient HTTP 客户端。
pub(all) struct SpreadRecordUnionClient {
  base_url : String
}

///|
/// 创建 SpreadRecordUnionClient。
pub fn SpreadRecordUnionClient::new(
  base_url : String,
) -> SpreadRecordUnionClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/spreadRecordUnion（自动解析响应）。
pub async fn SpreadRecordUnionClient::get_type_property_additionalproperties_spreadrecordunion(
  self : SpreadRecordUnionClient,
) -> Map[String, Union] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordUnion",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Union] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/spreadRecordUnion（自动解析响应）。
pub async fn SpreadRecordUnionClient::put_type_property_additionalproperties_spreadrecordunion(
  self : SpreadRecordUnionClient,
  body : Map[String, Union],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordUnion",
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
/// SpreadRecordNonDiscriminatedUnionClient HTTP 客户端。
pub(all) struct SpreadRecordNonDiscriminatedUnionClient {
  base_url : String
}

///|
/// 创建 SpreadRecordNonDiscriminatedUnionClient。
pub fn SpreadRecordNonDiscriminatedUnionClient::new(
  base_url : String,
) -> SpreadRecordNonDiscriminatedUnionClient {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/spreadRecordNonDiscriminatedUnion（自动解析响应）。
pub async fn SpreadRecordNonDiscriminatedUnionClient::get_type_property_additionalproperties_spreadrecordnondiscriminatedunion(
  self : SpreadRecordNonDiscriminatedUnionClient,
) -> Map[String, Union2] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordNonDiscriminatedUnion",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Union2] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/spreadRecordNonDiscriminatedUnion（自动解析响应）。
pub async fn SpreadRecordNonDiscriminatedUnionClient::put_type_property_additionalproperties_spreadrecordnondiscriminatedunion(
  self : SpreadRecordNonDiscriminatedUnionClient,
  body : Map[String, Union2],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordNonDiscriminatedUnion",
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
/// SpreadRecordNonDiscriminatedUnion2Client HTTP 客户端。
pub(all) struct SpreadRecordNonDiscriminatedUnion2Client {
  base_url : String
}

///|
/// 创建 SpreadRecordNonDiscriminatedUnion2Client。
pub fn SpreadRecordNonDiscriminatedUnion2Client::new(
  base_url : String,
) -> SpreadRecordNonDiscriminatedUnion2Client {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/spreadRecordNonDiscriminatedUnion2（自动解析响应）。
pub async fn SpreadRecordNonDiscriminatedUnion2Client::get_type_property_additionalproperties_spreadrecordnondiscriminatedunion2(
  self : SpreadRecordNonDiscriminatedUnion2Client,
) -> Map[String, Union3] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordNonDiscriminatedUnion2",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Union3] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/spreadRecordNonDiscriminatedUnion2（自动解析响应）。
pub async fn SpreadRecordNonDiscriminatedUnion2Client::put_type_property_additionalproperties_spreadrecordnondiscriminatedunion2(
  self : SpreadRecordNonDiscriminatedUnion2Client,
  body : Map[String, Union3],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordNonDiscriminatedUnion2",
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
/// SpreadRecordNonDiscriminatedUnion3Client HTTP 客户端。
pub(all) struct SpreadRecordNonDiscriminatedUnion3Client {
  base_url : String
}

///|
/// 创建 SpreadRecordNonDiscriminatedUnion3Client。
pub fn SpreadRecordNonDiscriminatedUnion3Client::new(
  base_url : String,
) -> SpreadRecordNonDiscriminatedUnion3Client {
  { base_url, }
}

///|
/// 调用 get /type/property/additionalProperties/spreadRecordNonDiscriminatedUnion3（自动解析响应）。
pub async fn SpreadRecordNonDiscriminatedUnion3Client::get_type_property_additionalproperties_spreadrecordnondiscriminatedunion3(
  self : SpreadRecordNonDiscriminatedUnion3Client,
) -> Map[String, Union4] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordNonDiscriminatedUnion3",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Union4] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/property/additionalProperties/spreadRecordNonDiscriminatedUnion3（自动解析响应）。
pub async fn SpreadRecordNonDiscriminatedUnion3Client::put_type_property_additionalproperties_spreadrecordnondiscriminatedunion3(
  self : SpreadRecordNonDiscriminatedUnion3Client,
  body : Map[String, Union4],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/property/additionalProperties/spreadRecordNonDiscriminatedUnion3",
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
