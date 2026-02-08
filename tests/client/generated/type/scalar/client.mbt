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
/// 调用 get /type/scalar/string（自动解析响应）。
pub async fn StringClient::get_type_scalar_string(
  self : StringClient,
) -> String {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/scalar/string")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : String = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/scalar/string（自动解析响应）。
pub async fn StringClient::put_type_scalar_string(
  self : StringClient,
  body : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/scalar/string")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/json")
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
/// BooleanClient HTTP 客户端。
pub(all) struct BooleanClient {
  base_url : String
}

///|

///|
/// 创建 BooleanClient。
pub fn BooleanClient::new(base_url : String) -> BooleanClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/scalar/boolean（自动解析响应）。
pub async fn BooleanClient::get_type_scalar_boolean(
  self : BooleanClient,
) -> Bool {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/scalar/boolean")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Bool = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/scalar/boolean（自动解析响应）。
pub async fn BooleanClient::put_type_scalar_boolean(
  self : BooleanClient,
  body : Bool,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/scalar/boolean")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/json")
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
/// UnknownClient HTTP 客户端。
pub(all) struct UnknownClient {
  base_url : String
}

///|

///|
/// 创建 UnknownClient。
pub fn UnknownClient::new(base_url : String) -> UnknownClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/scalar/unknown（自动解析响应）。
pub async fn UnknownClient::get_type_scalar_unknown(
  self : UnknownClient,
) -> Json {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/scalar/unknown")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Json = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/scalar/unknown（自动解析响应）。
pub async fn UnknownClient::put_type_scalar_unknown(
  self : UnknownClient,
  body : Json,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/scalar/unknown")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/json")
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
/// DecimalTypeClient HTTP 客户端。
pub(all) struct DecimalTypeClient {
  base_url : String
}

///|

///|
/// 创建 DecimalTypeClient。
pub fn DecimalTypeClient::new(base_url : String) -> DecimalTypeClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/scalar/decimal/response_body（自动解析响应）。
pub async fn DecimalTypeClient::get_type_scalar_decimal_response_body(
  self : DecimalTypeClient,
) -> Double {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/scalar/decimal/response_body",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Double = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/scalar/decimal/resquest_body（自动解析响应）。
pub async fn DecimalTypeClient::put_type_scalar_decimal_resquest_body(
  self : DecimalTypeClient,
  body : Double,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/scalar/decimal/resquest_body",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/json")
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
/// 调用 get /type/scalar/decimal/request_parameter{?value}（自动解析响应）。
pub async fn DecimalTypeClient::get_type_scalar_decimal_request_parameter__value_(
  self : DecimalTypeClient,
  value : Double,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=110)
  sb0.write_string("/type/scalar/decimal/request_parameter")
  sb0.write_string(
    @runtime.expand_string("?", "value", false, value.to_string()),
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

///|
/// Decimal128TypeClient HTTP 客户端。
pub(all) struct Decimal128TypeClient {
  base_url : String
}

///|

///|
/// 创建 Decimal128TypeClient。
pub fn Decimal128TypeClient::new(base_url : String) -> Decimal128TypeClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/scalar/decimal128/response_body（自动解析响应）。
pub async fn Decimal128TypeClient::get_type_scalar_decimal128_response_body(
  self : Decimal128TypeClient,
) -> Double {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/scalar/decimal128/response_body",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Double = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/scalar/decimal128/resquest_body（自动解析响应）。
pub async fn Decimal128TypeClient::put_type_scalar_decimal128_resquest_body(
  self : Decimal128TypeClient,
  body : Double,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/scalar/decimal128/resquest_body",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/json")
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
/// 调用 get /type/scalar/decimal128/request_parameter{?value}（自动解析响应）。
pub async fn Decimal128TypeClient::get_type_scalar_decimal128_request_parameter__value_(
  self : Decimal128TypeClient,
  value : Double,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=113)
  sb0.write_string("/type/scalar/decimal128/request_parameter")
  sb0.write_string(
    @runtime.expand_string("?", "value", false, value.to_string()),
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

///|
/// DecimalVerifyClient HTTP 客户端。
pub(all) struct DecimalVerifyClient {
  base_url : String
}

///|

///|
/// 创建 DecimalVerifyClient。
pub fn DecimalVerifyClient::new(base_url : String) -> DecimalVerifyClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/scalar/decimal/prepare_verify（自动解析响应）。
pub async fn DecimalVerifyClient::get_type_scalar_decimal_prepare_verify(
  self : DecimalVerifyClient,
) -> Array[Double] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/scalar/decimal/prepare_verify",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[Double] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /type/scalar/decimal/verify（自动解析响应）。
pub async fn DecimalVerifyClient::post_type_scalar_decimal_verify(
  self : DecimalVerifyClient,
  body : Double,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/scalar/decimal/verify")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/json")
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
/// Decimal128VerifyClient HTTP 客户端。
pub(all) struct Decimal128VerifyClient {
  base_url : String
}

///|

///|
/// 创建 Decimal128VerifyClient。
pub fn Decimal128VerifyClient::new(base_url : String) -> Decimal128VerifyClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/scalar/decimal128/prepare_verify（自动解析响应）。
pub async fn Decimal128VerifyClient::get_type_scalar_decimal128_prepare_verify(
  self : Decimal128VerifyClient,
) -> Array[Double] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/scalar/decimal128/prepare_verify",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[Double] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /type/scalar/decimal128/verify（自动解析响应）。
pub async fn Decimal128VerifyClient::post_type_scalar_decimal128_verify(
  self : Decimal128VerifyClient,
  body : Double,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/scalar/decimal128/verify",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "application/json")
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
