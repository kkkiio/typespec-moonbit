///|

///|
/// Int32ValueClient HTTP 客户端。
pub(all) struct Int32ValueClient {
  base_url : String
}

///|

///|
/// 创建 Int32ValueClient。
pub fn Int32ValueClient::new(base_url : String) -> Int32ValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/int32（自动解析响应）。
pub async fn Int32ValueClient::get_type_array_int32(
  self : Int32ValueClient,
) -> Array[Int] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/int32")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[Int] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/array/int32（自动解析响应）。
pub async fn Int32ValueClient::put_type_array_int32(
  self : Int32ValueClient,
  body : Array[Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/int32")
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
/// Int64ValueClient HTTP 客户端。
pub(all) struct Int64ValueClient {
  base_url : String
}

///|

///|
/// 创建 Int64ValueClient。
pub fn Int64ValueClient::new(base_url : String) -> Int64ValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/int64（自动解析响应）。
pub async fn Int64ValueClient::get_type_array_int64(
  self : Int64ValueClient,
) -> Array[Int64] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/int64")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[Int64] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/array/int64（自动解析响应）。
pub async fn Int64ValueClient::put_type_array_int64(
  self : Int64ValueClient,
  body : Array[Int64],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/int64")
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
/// BooleanValueClient HTTP 客户端。
pub(all) struct BooleanValueClient {
  base_url : String
}

///|

///|
/// 创建 BooleanValueClient。
pub fn BooleanValueClient::new(base_url : String) -> BooleanValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/boolean（自动解析响应）。
pub async fn BooleanValueClient::get_type_array_boolean(
  self : BooleanValueClient,
) -> Array[Bool] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/boolean")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[Bool] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/array/boolean（自动解析响应）。
pub async fn BooleanValueClient::put_type_array_boolean(
  self : BooleanValueClient,
  body : Array[Bool],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/boolean")
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
/// StringValueClient HTTP 客户端。
pub(all) struct StringValueClient {
  base_url : String
}

///|

///|
/// 创建 StringValueClient。
pub fn StringValueClient::new(base_url : String) -> StringValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/string（自动解析响应）。
pub async fn StringValueClient::get_type_array_string(
  self : StringValueClient,
) -> Array[String] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/string")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[String] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/array/string（自动解析响应）。
pub async fn StringValueClient::put_type_array_string(
  self : StringValueClient,
  body : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/string")
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
/// Float32ValueClient HTTP 客户端。
pub(all) struct Float32ValueClient {
  base_url : String
}

///|

///|
/// 创建 Float32ValueClient。
pub fn Float32ValueClient::new(base_url : String) -> Float32ValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/float32（自动解析响应）。
pub async fn Float32ValueClient::get_type_array_float32(
  self : Float32ValueClient,
) -> Array[Double] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/float32")
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
/// 调用 put /type/array/float32（自动解析响应）。
pub async fn Float32ValueClient::put_type_array_float32(
  self : Float32ValueClient,
  body : Array[Double],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/float32")
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
/// DatetimeValueClient HTTP 客户端。
pub(all) struct DatetimeValueClient {
  base_url : String
}

///|

///|
/// 创建 DatetimeValueClient。
pub fn DatetimeValueClient::new(base_url : String) -> DatetimeValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/datetime（自动解析响应）。
pub async fn DatetimeValueClient::get_type_array_datetime(
  self : DatetimeValueClient,
) -> Array[String] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/datetime")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[String] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/array/datetime（自动解析响应）。
pub async fn DatetimeValueClient::put_type_array_datetime(
  self : DatetimeValueClient,
  body : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/datetime")
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
/// DurationValueClient HTTP 客户端。
pub(all) struct DurationValueClient {
  base_url : String
}

///|

///|
/// 创建 DurationValueClient。
pub fn DurationValueClient::new(base_url : String) -> DurationValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/duration（自动解析响应）。
pub async fn DurationValueClient::get_type_array_duration(
  self : DurationValueClient,
) -> Array[String] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/duration")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[String] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/array/duration（自动解析响应）。
pub async fn DurationValueClient::put_type_array_duration(
  self : DurationValueClient,
  body : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/duration")
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
/// UnknownValueClient HTTP 客户端。
pub(all) struct UnknownValueClient {
  base_url : String
}

///|

///|
/// 创建 UnknownValueClient。
pub fn UnknownValueClient::new(base_url : String) -> UnknownValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/unknown（自动解析响应）。
pub async fn UnknownValueClient::get_type_array_unknown(
  self : UnknownValueClient,
) -> Array[Json] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/unknown")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[Json] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/array/unknown（自动解析响应）。
pub async fn UnknownValueClient::put_type_array_unknown(
  self : UnknownValueClient,
  body : Array[Json],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/unknown")
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
/// ModelValueClient HTTP 客户端。
pub(all) struct ModelValueClient {
  base_url : String
}

///|

///|
/// 创建 ModelValueClient。
pub fn ModelValueClient::new(base_url : String) -> ModelValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/model（自动解析响应）。
pub async fn ModelValueClient::get_type_array_model(
  self : ModelValueClient,
) -> Array[InnerModel] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/model")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[InnerModel] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/array/model（自动解析响应）。
pub async fn ModelValueClient::put_type_array_model(
  self : ModelValueClient,
  body : Array[InnerModel],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/model")
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
/// NullableFloatValueClient HTTP 客户端。
pub(all) struct NullableFloatValueClient {
  base_url : String
}

///|

///|
/// 创建 NullableFloatValueClient。
pub fn NullableFloatValueClient::new(
  base_url : String,
) -> NullableFloatValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/nullable-float（自动解析响应）。
pub async fn NullableFloatValueClient::get_type_array_nullable_float(
  self : NullableFloatValueClient,
) -> Array[@runtime.Nullable[Double]] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/nullable-float")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[@runtime.Nullable[Double]] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/array/nullable-float（自动解析响应）。
pub async fn NullableFloatValueClient::put_type_array_nullable_float(
  self : NullableFloatValueClient,
  body : Array[@runtime.Nullable[Double]],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/nullable-float")
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
/// NullableInt32ValueClient HTTP 客户端。
pub(all) struct NullableInt32ValueClient {
  base_url : String
}

///|

///|
/// 创建 NullableInt32ValueClient。
pub fn NullableInt32ValueClient::new(
  base_url : String,
) -> NullableInt32ValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/nullable-int32（自动解析响应）。
pub async fn NullableInt32ValueClient::get_type_array_nullable_int32(
  self : NullableInt32ValueClient,
) -> Array[@runtime.Nullable[Int]] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/nullable-int32")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[@runtime.Nullable[Int]] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/array/nullable-int32（自动解析响应）。
pub async fn NullableInt32ValueClient::put_type_array_nullable_int32(
  self : NullableInt32ValueClient,
  body : Array[@runtime.Nullable[Int]],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/nullable-int32")
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
/// NullableBooleanValueClient HTTP 客户端。
pub(all) struct NullableBooleanValueClient {
  base_url : String
}

///|

///|
/// 创建 NullableBooleanValueClient。
pub fn NullableBooleanValueClient::new(
  base_url : String,
) -> NullableBooleanValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/nullable-boolean（自动解析响应）。
pub async fn NullableBooleanValueClient::get_type_array_nullable_boolean(
  self : NullableBooleanValueClient,
) -> Array[@runtime.Nullable[Bool]] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/nullable-boolean")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[@runtime.Nullable[Bool]] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/array/nullable-boolean（自动解析响应）。
pub async fn NullableBooleanValueClient::put_type_array_nullable_boolean(
  self : NullableBooleanValueClient,
  body : Array[@runtime.Nullable[Bool]],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/nullable-boolean")
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
/// NullableStringValueClient HTTP 客户端。
pub(all) struct NullableStringValueClient {
  base_url : String
}

///|

///|
/// 创建 NullableStringValueClient。
pub fn NullableStringValueClient::new(
  base_url : String,
) -> NullableStringValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/nullable-string（自动解析响应）。
pub async fn NullableStringValueClient::get_type_array_nullable_string(
  self : NullableStringValueClient,
) -> Array[@runtime.Nullable[String]] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/nullable-string")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[@runtime.Nullable[String]] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/array/nullable-string（自动解析响应）。
pub async fn NullableStringValueClient::put_type_array_nullable_string(
  self : NullableStringValueClient,
  body : Array[@runtime.Nullable[String]],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/nullable-string")
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
/// NullableModelValueClient HTTP 客户端。
pub(all) struct NullableModelValueClient {
  base_url : String
}

///|

///|
/// 创建 NullableModelValueClient。
pub fn NullableModelValueClient::new(
  base_url : String,
) -> NullableModelValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/array/nullable-model（自动解析响应）。
pub async fn NullableModelValueClient::get_type_array_nullable_model(
  self : NullableModelValueClient,
) -> Array[@runtime.Nullable[InnerModel]] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/nullable-model")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Array[@runtime.Nullable[InnerModel]] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/array/nullable-model（自动解析响应）。
pub async fn NullableModelValueClient::put_type_array_nullable_model(
  self : NullableModelValueClient,
  body : Array[@runtime.Nullable[InnerModel]],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/array/nullable-model")
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
