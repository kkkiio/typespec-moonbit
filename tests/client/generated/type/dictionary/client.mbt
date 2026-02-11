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
/// 调用 get /type/dictionary/int32（自动解析响应）。
pub async fn Int32ValueClient::get_type_dictionary_int32(
  self : Int32ValueClient,
) -> Map[String, Int] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/int32")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Int] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/dictionary/int32（自动解析响应）。
pub async fn Int32ValueClient::put_type_dictionary_int32(
  self : Int32ValueClient,
  body : Map[String, Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/int32")
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
/// 调用 get /type/dictionary/int64（自动解析响应）。
pub async fn Int64ValueClient::get_type_dictionary_int64(
  self : Int64ValueClient,
) -> Map[String, Int64] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/int64")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Int64] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/dictionary/int64（自动解析响应）。
pub async fn Int64ValueClient::put_type_dictionary_int64(
  self : Int64ValueClient,
  body : Map[String, Int64],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/int64")
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
/// 调用 get /type/dictionary/boolean（自动解析响应）。
pub async fn BooleanValueClient::get_type_dictionary_boolean(
  self : BooleanValueClient,
) -> Map[String, Bool] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/boolean")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, Bool] = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/dictionary/boolean（自动解析响应）。
pub async fn BooleanValueClient::put_type_dictionary_boolean(
  self : BooleanValueClient,
  body : Map[String, Bool],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/boolean")
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
/// 调用 get /type/dictionary/string（自动解析响应）。
pub async fn StringValueClient::get_type_dictionary_string(
  self : StringValueClient,
) -> Map[String, String] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/string")
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

///|
/// 调用 put /type/dictionary/string（自动解析响应）。
pub async fn StringValueClient::put_type_dictionary_string(
  self : StringValueClient,
  body : Map[String, String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/string")
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
/// 调用 get /type/dictionary/float32（自动解析响应）。
pub async fn Float32ValueClient::get_type_dictionary_float32(
  self : Float32ValueClient,
) -> Map[String, Double] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/float32")
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

///|
/// 调用 put /type/dictionary/float32（自动解析响应）。
pub async fn Float32ValueClient::put_type_dictionary_float32(
  self : Float32ValueClient,
  body : Map[String, Double],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/float32")
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
/// 调用 get /type/dictionary/datetime（自动解析响应）。
pub async fn DatetimeValueClient::get_type_dictionary_datetime(
  self : DatetimeValueClient,
) -> Map[String, @runtime.UtcDateTime] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/datetime")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, @runtime.UtcDateTime] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/dictionary/datetime（自动解析响应）。
pub async fn DatetimeValueClient::put_type_dictionary_datetime(
  self : DatetimeValueClient,
  body : Map[String, @runtime.UtcDateTime],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/datetime")
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
/// 调用 get /type/dictionary/duration（自动解析响应）。
pub async fn DurationValueClient::get_type_dictionary_duration(
  self : DurationValueClient,
) -> Map[String, @runtime.Duration] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/duration")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, @runtime.Duration] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/dictionary/duration（自动解析响应）。
pub async fn DurationValueClient::put_type_dictionary_duration(
  self : DurationValueClient,
  body : Map[String, @runtime.Duration],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/duration")
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
/// 调用 get /type/dictionary/unknown（自动解析响应）。
pub async fn UnknownValueClient::get_type_dictionary_unknown(
  self : UnknownValueClient,
) -> Map[String, Json] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/unknown")
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

///|
/// 调用 put /type/dictionary/unknown（自动解析响应）。
pub async fn UnknownValueClient::put_type_dictionary_unknown(
  self : UnknownValueClient,
  body : Map[String, Json],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/unknown")
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
/// 调用 get /type/dictionary/model（自动解析响应）。
pub async fn ModelValueClient::get_type_dictionary_model(
  self : ModelValueClient,
) -> Map[String, InnerModel] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/model")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, InnerModel] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/dictionary/model（自动解析响应）。
pub async fn ModelValueClient::put_type_dictionary_model(
  self : ModelValueClient,
  body : Map[String, InnerModel],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/dictionary/model")
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
/// RecursiveModelValueClient HTTP 客户端。
pub(all) struct RecursiveModelValueClient {
  base_url : String
}

///|

///|
/// 创建 RecursiveModelValueClient。
pub fn RecursiveModelValueClient::new(
  base_url : String,
) -> RecursiveModelValueClient {
  { base_url, }
}

///|

///|
/// 调用 get /type/dictionary/model/recursive（自动解析响应）。
pub async fn RecursiveModelValueClient::get_type_dictionary_model_recursive(
  self : RecursiveModelValueClient,
) -> Map[String, InnerModel] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/dictionary/model/recursive",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, InnerModel] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/dictionary/model/recursive（自动解析响应）。
pub async fn RecursiveModelValueClient::put_type_dictionary_model_recursive(
  self : RecursiveModelValueClient,
  body : Map[String, InnerModel],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/dictionary/model/recursive",
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
/// 调用 get /type/dictionary/nullable-float（自动解析响应）。
pub async fn NullableFloatValueClient::get_type_dictionary_nullable_float(
  self : NullableFloatValueClient,
) -> Map[String, @runtime.Nullable[Double]] {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/dictionary/nullable-float",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : Map[String, @runtime.Nullable[Double]] = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 put /type/dictionary/nullable-float（自动解析响应）。
pub async fn NullableFloatValueClient::put_type_dictionary_nullable_float(
  self : NullableFloatValueClient,
  body : Map[String, @runtime.Nullable[Double]],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/dictionary/nullable-float",
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
