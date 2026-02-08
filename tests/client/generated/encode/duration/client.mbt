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
/// 调用 get /encode/duration/query/default{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_default__input_(
  self : QueryClient,
  input : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=102)
  sb0.write_string("/encode/duration/query/default")
  sb0.write_string(@runtime.expand_string("?", "input", false, input))
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
/// 调用 get /encode/duration/query/iso8601{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_iso8601__input_(
  self : QueryClient,
  input : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=102)
  sb0.write_string("/encode/duration/query/iso8601")
  sb0.write_string(@runtime.expand_string("?", "input", false, input))
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
/// 调用 get /encode/duration/query/int32-seconds{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_int32_seconds__input_(
  self : QueryClient,
  input : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=108)
  sb0.write_string("/encode/duration/query/int32-seconds")
  sb0.write_string(@runtime.expand_string("?", "input", false, input))
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
/// 调用 get /encode/duration/query/int32-seconds-larger-unit{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_int32_seconds_larger_unit__input_(
  self : QueryClient,
  input : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=120)
  sb0.write_string("/encode/duration/query/int32-seconds-larger-unit")
  sb0.write_string(@runtime.expand_string("?", "input", false, input))
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
/// 调用 get /encode/duration/query/float-seconds{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_float_seconds__input_(
  self : QueryClient,
  input : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=108)
  sb0.write_string("/encode/duration/query/float-seconds")
  sb0.write_string(@runtime.expand_string("?", "input", false, input))
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
/// 调用 get /encode/duration/query/float-seconds-larger-unit{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_float_seconds_larger_unit__input_(
  self : QueryClient,
  input : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=120)
  sb0.write_string("/encode/duration/query/float-seconds-larger-unit")
  sb0.write_string(@runtime.expand_string("?", "input", false, input))
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
/// 调用 get /encode/duration/query/float64-seconds{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_float64_seconds__input_(
  self : QueryClient,
  input : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=110)
  sb0.write_string("/encode/duration/query/float64-seconds")
  sb0.write_string(@runtime.expand_string("?", "input", false, input))
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
/// 调用 get /encode/duration/query/int32-milliseconds{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_int32_milliseconds__input_(
  self : QueryClient,
  input : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=113)
  sb0.write_string("/encode/duration/query/int32-milliseconds")
  sb0.write_string(@runtime.expand_string("?", "input", false, input))
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
/// 调用 get /encode/duration/query/int32-milliseconds-larger-unit{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_int32_milliseconds_larger_unit__input_(
  self : QueryClient,
  input : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=125)
  sb0.write_string("/encode/duration/query/int32-milliseconds-larger-unit")
  sb0.write_string(@runtime.expand_string("?", "input", false, input))
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
/// 调用 get /encode/duration/query/float-milliseconds{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_float_milliseconds__input_(
  self : QueryClient,
  input : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=113)
  sb0.write_string("/encode/duration/query/float-milliseconds")
  sb0.write_string(@runtime.expand_string("?", "input", false, input))
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
/// 调用 get /encode/duration/query/float-milliseconds-larger-unit{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_float_milliseconds_larger_unit__input_(
  self : QueryClient,
  input : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=125)
  sb0.write_string("/encode/duration/query/float-milliseconds-larger-unit")
  sb0.write_string(@runtime.expand_string("?", "input", false, input))
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
/// 调用 get /encode/duration/query/float64-milliseconds{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_float64_milliseconds__input_(
  self : QueryClient,
  input : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=115)
  sb0.write_string("/encode/duration/query/float64-milliseconds")
  sb0.write_string(@runtime.expand_string("?", "input", false, input))
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
/// 调用 get /encode/duration/query/int32-seconds-array{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_int32_seconds_array__input_(
  self : QueryClient,
  input : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=114)
  sb0.write_string("/encode/duration/query/int32-seconds-array")
  sb0.write_string(@runtime.expand_array("?", "input", false, input))
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
/// 调用 get /encode/duration/query/int32-milliseconds-array{?input}（自动解析响应）。
pub async fn QueryClient::get_encode_duration_query_int32_milliseconds_array__input_(
  self : QueryClient,
  input : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=119)
  sb0.write_string("/encode/duration/query/int32-milliseconds-array")
  sb0.write_string(@runtime.expand_array("?", "input", false, input))
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
/// 调用 post /encode/duration/property/default（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_default(
  self : PropertyClient,
  body : DefaultDurationProperty,
) -> DefaultDurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/default",
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
    let parsed : DefaultDurationProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/duration/property/iso8601（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_iso8601(
  self : PropertyClient,
  body : Iso8601DurationProperty,
) -> Iso8601DurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/iso8601",
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
    let parsed : Iso8601DurationProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/duration/property/int32-seconds（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_int32_seconds(
  self : PropertyClient,
  body : Int32SecondsDurationProperty,
) -> Int32SecondsDurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/int32-seconds",
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
    let parsed : Int32SecondsDurationProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/duration/property/float-seconds（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_float_seconds(
  self : PropertyClient,
  body : FloatSecondsDurationProperty,
) -> FloatSecondsDurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/float-seconds",
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
    let parsed : FloatSecondsDurationProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/duration/property/float64-seconds（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_float64_seconds(
  self : PropertyClient,
  body : Float64SecondsDurationProperty,
) -> Float64SecondsDurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/float64-seconds",
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
    let parsed : Float64SecondsDurationProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/duration/property/int32-milliseconds（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_int32_milliseconds(
  self : PropertyClient,
  body : Int32MillisecondsDurationProperty,
) -> Int32MillisecondsDurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/int32-milliseconds",
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
    let parsed : Int32MillisecondsDurationProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/duration/property/float-milliseconds（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_float_milliseconds(
  self : PropertyClient,
  body : FloatMillisecondsDurationProperty,
) -> FloatMillisecondsDurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/float-milliseconds",
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
    let parsed : FloatMillisecondsDurationProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/duration/property/float64-milliseconds（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_float64_milliseconds(
  self : PropertyClient,
  body : Float64MillisecondsDurationProperty,
) -> Float64MillisecondsDurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/float64-milliseconds",
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
    let parsed : Float64MillisecondsDurationProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/duration/property/float-seconds-array（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_float_seconds_array(
  self : PropertyClient,
  body : FloatSecondsDurationArrayProperty,
) -> FloatSecondsDurationArrayProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/float-seconds-array",
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
    let parsed : FloatSecondsDurationArrayProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/duration/property/float-milliseconds-array（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_float_milliseconds_array(
  self : PropertyClient,
  body : FloatMillisecondsDurationArrayProperty,
) -> FloatMillisecondsDurationArrayProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/float-milliseconds-array",
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
    let parsed : FloatMillisecondsDurationArrayProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/duration/property/int32-seconds-larger-unit（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_int32_seconds_larger_unit(
  self : PropertyClient,
  body : Int32SecondsLargerUnitDurationProperty,
) -> Int32SecondsLargerUnitDurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/int32-seconds-larger-unit",
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
    let parsed : Int32SecondsLargerUnitDurationProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/duration/property/float-seconds-larger-unit（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_float_seconds_larger_unit(
  self : PropertyClient,
  body : FloatSecondsLargerUnitDurationProperty,
) -> FloatSecondsLargerUnitDurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/float-seconds-larger-unit",
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
    let parsed : FloatSecondsLargerUnitDurationProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/duration/property/int32-milliseconds-larger-unit（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_int32_milliseconds_larger_unit(
  self : PropertyClient,
  body : Int32MillisecondsLargerUnitDurationProperty,
) -> Int32MillisecondsLargerUnitDurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/int32-milliseconds-larger-unit",
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
    let parsed : Int32MillisecondsLargerUnitDurationProperty = @json.from_json(
      @json.parse(response_body),
    )
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|

///|
/// 调用 post /encode/duration/property/float-milliseconds-larger-unit（自动解析响应）。
pub async fn PropertyClient::post_encode_duration_property_float_milliseconds_larger_unit(
  self : PropertyClient,
  body : FloatMillisecondsLargerUnitDurationProperty,
) -> FloatMillisecondsLargerUnitDurationProperty {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/property/float-milliseconds-larger-unit",
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
    let parsed : FloatMillisecondsLargerUnitDurationProperty = @json.from_json(
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
/// 调用 get /encode/duration/header/default（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_default(
  self : HeaderClient,
  duration : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/default",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", duration)
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
/// 调用 get /encode/duration/header/iso8601（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_iso8601(
  self : HeaderClient,
  duration : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/iso8601",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", duration)
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
/// 调用 get /encode/duration/header/iso8601-array（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_iso8601_array(
  self : HeaderClient,
  duration : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/iso8601-array",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", @runtime.join(duration, ","))
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
/// 调用 get /encode/duration/header/int32-seconds（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_int32_seconds(
  self : HeaderClient,
  duration : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/int32-seconds",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", duration)
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
/// 调用 get /encode/duration/header/int32-seconds-larger-unit（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_int32_seconds_larger_unit(
  self : HeaderClient,
  duration : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/int32-seconds-larger-unit",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", duration)
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
/// 调用 get /encode/duration/header/float-seconds（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_float_seconds(
  self : HeaderClient,
  duration : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/float-seconds",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", duration)
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
/// 调用 get /encode/duration/header/float-seconds-larger-unit（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_float_seconds_larger_unit(
  self : HeaderClient,
  duration : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/float-seconds-larger-unit",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", duration)
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
/// 调用 get /encode/duration/header/float64-seconds（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_float64_seconds(
  self : HeaderClient,
  duration : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/float64-seconds",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", duration)
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
/// 调用 get /encode/duration/header/int32-milliseconds（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_int32_milliseconds(
  self : HeaderClient,
  duration : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/int32-milliseconds",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", duration)
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
/// 调用 get /encode/duration/header/int32-milliseconds-larger-unit（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_int32_milliseconds_larger_unit(
  self : HeaderClient,
  duration : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/int32-milliseconds-larger-unit",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", duration)
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
/// 调用 get /encode/duration/header/float-milliseconds（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_float_milliseconds(
  self : HeaderClient,
  duration : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/float-milliseconds",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", duration)
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
/// 调用 get /encode/duration/header/float-milliseconds-larger-unit（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_float_milliseconds_larger_unit(
  self : HeaderClient,
  duration : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/float-milliseconds-larger-unit",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", duration)
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
/// 调用 get /encode/duration/header/float64-milliseconds（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_float64_milliseconds(
  self : HeaderClient,
  duration : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/float64-milliseconds",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", duration)
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
/// 调用 get /encode/duration/header/int32-milliseconds-array（自动解析响应）。
pub async fn HeaderClient::get_encode_duration_header_int32_milliseconds_array(
  self : HeaderClient,
  duration : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/encode/duration/header/int32-milliseconds-array",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("duration", @runtime.join(duration, ","))
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
