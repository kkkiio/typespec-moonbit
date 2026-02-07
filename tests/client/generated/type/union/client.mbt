///|

///|
/// StringsOnlyClient HTTP 客户端。
pub(all) struct StringsOnlyClient {
  base_url : String
}

///|

///|
/// 创建 StringsOnlyClient。
pub fn StringsOnlyClient::new(base_url : String) -> StringsOnlyClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/union/strings-only（自动解析响应）。
pub async fn StringsOnlyClient::get_type_union_strings_only(
  self : StringsOnlyClient,
) -> Model10 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/strings-only")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
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
/// 调用 post /type/union/strings-only（自动解析响应）。
pub async fn StringsOnlyClient::post_type_union_strings_only(
  self : StringsOnlyClient,
  body : Model11,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/strings-only")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
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
/// StringExtensibleClient HTTP 客户端。
pub(all) struct StringExtensibleClient {
  base_url : String
}

///|

///|
/// 创建 StringExtensibleClient。
pub fn StringExtensibleClient::new(base_url : String) -> StringExtensibleClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/union/string-extensible（自动解析响应）。
pub async fn StringExtensibleClient::get_type_union_string_extensible(
  self : StringExtensibleClient,
) -> Model16 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/union/string-extensible",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model16 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /type/union/string-extensible（自动解析响应）。
pub async fn StringExtensibleClient::post_type_union_string_extensible(
  self : StringExtensibleClient,
  body : Model17,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/union/string-extensible",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
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
/// StringExtensibleNamedClient HTTP 客户端。
pub(all) struct StringExtensibleNamedClient {
  base_url : String
}

///|

///|
/// 创建 StringExtensibleNamedClient。
pub fn StringExtensibleNamedClient::new(
  base_url : String,
) -> StringExtensibleNamedClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/union/string-extensible-named（自动解析响应）。
pub async fn StringExtensibleNamedClient::get_type_union_string_extensible_named(
  self : StringExtensibleNamedClient,
) -> Model18 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/union/string-extensible-named",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model18 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /type/union/string-extensible-named（自动解析响应）。
pub async fn StringExtensibleNamedClient::post_type_union_string_extensible_named(
  self : StringExtensibleNamedClient,
  body : Model19,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/union/string-extensible-named",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
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
/// IntsOnlyClient HTTP 客户端。
pub(all) struct IntsOnlyClient {
  base_url : String
}

///|

///|
/// 创建 IntsOnlyClient。
pub fn IntsOnlyClient::new(base_url : String) -> IntsOnlyClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/union/ints-only（自动解析响应）。
pub async fn IntsOnlyClient::get_type_union_ints_only(
  self : IntsOnlyClient,
) -> Model0 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/ints-only")
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
/// 调用 post /type/union/ints-only（自动解析响应）。
pub async fn IntsOnlyClient::post_type_union_ints_only(
  self : IntsOnlyClient,
  body : Model2,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/ints-only")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
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
/// FloatsOnlyClient HTTP 客户端。
pub(all) struct FloatsOnlyClient {
  base_url : String
}

///|

///|
/// 创建 FloatsOnlyClient。
pub fn FloatsOnlyClient::new(base_url : String) -> FloatsOnlyClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/union/floats-only（自动解析响应）。
pub async fn FloatsOnlyClient::get_type_union_floats_only(
  self : FloatsOnlyClient,
) -> Model5 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/floats-only")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model5 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /type/union/floats-only（自动解析响应）。
pub async fn FloatsOnlyClient::post_type_union_floats_only(
  self : FloatsOnlyClient,
  body : Model7,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/floats-only")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
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
/// ModelsOnlyClient HTTP 客户端。
pub(all) struct ModelsOnlyClient {
  base_url : String
}

///|

///|
/// 创建 ModelsOnlyClient。
pub fn ModelsOnlyClient::new(base_url : String) -> ModelsOnlyClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/union/models-only（自动解析响应）。
pub async fn ModelsOnlyClient::get_type_union_models_only(
  self : ModelsOnlyClient,
) -> Model6 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/models-only")
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
/// 调用 post /type/union/models-only（自动解析响应）。
pub async fn ModelsOnlyClient::post_type_union_models_only(
  self : ModelsOnlyClient,
  body : Model9,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/models-only")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
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
/// EnumsOnlyClient HTTP 客户端。
pub(all) struct EnumsOnlyClient {
  base_url : String
}

///|

///|
/// 创建 EnumsOnlyClient。
pub fn EnumsOnlyClient::new(base_url : String) -> EnumsOnlyClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/union/enums-only（自动解析响应）。
pub async fn EnumsOnlyClient::get_type_union_enums_only(
  self : EnumsOnlyClient,
) -> Model1 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/enums-only")
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

///|

///|
/// 调用 post /type/union/enums-only（自动解析响应）。
pub async fn EnumsOnlyClient::post_type_union_enums_only(
  self : EnumsOnlyClient,
  body : Model3,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/enums-only")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
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
/// StringAndArrayClient HTTP 客户端。
pub(all) struct StringAndArrayClient {
  base_url : String
}

///|

///|
/// 创建 StringAndArrayClient。
pub fn StringAndArrayClient::new(base_url : String) -> StringAndArrayClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/union/string-and-array（自动解析响应）。
pub async fn StringAndArrayClient::get_type_union_string_and_array(
  self : StringAndArrayClient,
) -> Model14 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/string-and-array")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
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
/// 调用 post /type/union/string-and-array（自动解析响应）。
pub async fn StringAndArrayClient::post_type_union_string_and_array(
  self : StringAndArrayClient,
  body : Model15,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/string-and-array")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
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
/// MixedLiteralsClient HTTP 客户端。
pub(all) struct MixedLiteralsClient {
  base_url : String
}

///|

///|
/// 创建 MixedLiteralsClient。
pub fn MixedLiteralsClient::new(base_url : String) -> MixedLiteralsClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/union/mixed-literals（自动解析响应）。
pub async fn MixedLiteralsClient::get_type_union_mixed_literals(
  self : MixedLiteralsClient,
) -> Model12 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/mixed-literals")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model12 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /type/union/mixed-literals（自动解析响应）。
pub async fn MixedLiteralsClient::post_type_union_mixed_literals(
  self : MixedLiteralsClient,
  body : Model13,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/mixed-literals")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
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
/// MixedTypesClient HTTP 客户端。
pub(all) struct MixedTypesClient {
  base_url : String
}

///|

///|
/// 创建 MixedTypesClient。
pub fn MixedTypesClient::new(base_url : String) -> MixedTypesClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/union/mixed-types（自动解析响应）。
pub async fn MixedTypesClient::get_type_union_mixed_types(
  self : MixedTypesClient,
) -> Model4 {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/mixed-types")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Model4 = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /type/union/mixed-types（自动解析响应）。
pub async fn MixedTypesClient::post_type_union_mixed_types(
  self : MixedTypesClient,
  body : Model8,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/union/mixed-types")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Post, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
