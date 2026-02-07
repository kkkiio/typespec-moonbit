///|
/// AliasClient HTTP 客户端。
pub struct AliasClient {
  base_url : String
}

///|
/// 创建 AliasClient。
pub fn AliasClient::new(base_url : String) -> AliasClient {
  { base_url, }
}

///|
/// 调用 put /parameters/spread/alias/request-body（自动解析响应）。
pub async fn AliasClient::put_parameters_spread_alias_request_body(
  self : AliasClient,
  body : Model0,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @client_runtime.encode_request_target(
    "/parameters/spread/alias/request-body",
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
/// 调用 post /parameters/spread/alias/inner-model-parameter/{id}（自动解析响应）。
pub async fn AliasClient::post_parameters_spread_alias_inner_model_parameter__id_(
  self : AliasClient,
  id : String,
  x_ms_test_header : String,
  body : Model1,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=115)
  sb0.write_string("/parameters/spread/alias/inner-model-parameter/")
  sb0.write_string(@client_runtime.expand_string("", "id", false, id))
  let base_path = sb0.to_string()
  let base_path = @client_runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("x-ms-test-header", x_ms_test_header)
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
/// 调用 put /parameters/spread/alias/request-parameter/{id}（自动解析响应）。
pub async fn AliasClient::put_parameters_spread_alias_request_parameter__id_(
  self : AliasClient,
  id : String,
  x_ms_test_header : String,
  body : Model2,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=111)
  sb0.write_string("/parameters/spread/alias/request-parameter/")
  sb0.write_string(@client_runtime.expand_string("", "id", false, id))
  let base_path = sb0.to_string()
  let base_path = @client_runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("x-ms-test-header", x_ms_test_header)
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
/// 调用 put /parameters/spread/alias/multiple-parameters/{id}（自动解析响应）。
pub async fn AliasClient::put_parameters_spread_alias_multiple_parameters__id_(
  self : AliasClient,
  id : String,
  x_ms_test_header : String,
  body : Model3,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=113)
  sb0.write_string("/parameters/spread/alias/multiple-parameters/")
  sb0.write_string(@client_runtime.expand_string("", "id", false, id))
  let base_path = sb0.to_string()
  let base_path = @client_runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("x-ms-test-header", x_ms_test_header)
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
/// 调用 post /parameters/spread/alias/inner-alias-parameter/{id}（自动解析响应）。
pub async fn AliasClient::post_parameters_spread_alias_inner_alias_parameter__id_(
  self : AliasClient,
  id : String,
  x_ms_test_header : String,
  body : Model4,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=115)
  sb0.write_string("/parameters/spread/alias/inner-alias-parameter/")
  sb0.write_string(@client_runtime.expand_string("", "id", false, id))
  let base_path = sb0.to_string()
  let base_path = @client_runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("x-ms-test-header", x_ms_test_header)
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
/// ModelClient HTTP 客户端。
pub struct ModelClient {
  base_url : String
}

///|
/// 创建 ModelClient。
pub fn ModelClient::new(base_url : String) -> ModelClient {
  { base_url, }
}

///|
/// 调用 put /parameters/spread/model/request-body（自动解析响应）。
pub async fn ModelClient::put_parameters_spread_model_request_body(
  self : ModelClient,
  body : BodyParameter5,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @client_runtime.encode_request_target(
    "/parameters/spread/model/request-body",
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
/// 调用 put /parameters/spread/model/composite-request-only-with-body（自动解析响应）。
pub async fn ModelClient::put_parameters_spread_model_composite_request_only_with_body(
  self : ModelClient,
  body : BodyParameter,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @client_runtime.encode_request_target(
    "/parameters/spread/model/composite-request-only-with-body",
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
/// 调用 put /parameters/spread/model/composite-request-without-body/{name}（自动解析响应）。
pub async fn ModelClient::put_parameters_spread_model_composite_request_without_body__name_(
  self : ModelClient,
  name : String,
  test_header : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=126)
  sb0.write_string("/parameters/spread/model/composite-request-without-body/")
  sb0.write_string(@client_runtime.expand_string("", "name", false, name))
  let base_path = sb0.to_string()
  let base_path = @client_runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("test-header", test_header)
  let path = sb.to_string()
  client.request(@http.Put, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /parameters/spread/model/composite-request/{name}（自动解析响应）。
pub async fn ModelClient::put_parameters_spread_model_composite_request__name_(
  self : ModelClient,
  name : String,
  test_header : String,
  body : BodyParameter,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=113)
  sb0.write_string("/parameters/spread/model/composite-request/")
  sb0.write_string(@client_runtime.expand_string("", "name", false, name))
  let base_path = sb0.to_string()
  let base_path = @client_runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("test-header", test_header)
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
/// 调用 put /parameters/spread/model/composite-request-mix/{name}（自动解析响应）。
pub async fn ModelClient::put_parameters_spread_model_composite_request_mix__name_(
  self : ModelClient,
  name : String,
  test_header : String,
  body : Model6,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=117)
  sb0.write_string("/parameters/spread/model/composite-request-mix/")
  sb0.write_string(@client_runtime.expand_string("", "name", false, name))
  let base_path = sb0.to_string()
  let base_path = @client_runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("test-header", test_header)
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
