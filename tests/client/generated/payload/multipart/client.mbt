///|

///|
/// FormDataClient HTTP 客户端。
pub(all) struct FormDataClient {
  base_url : String
}

///|

///|
/// 创建 FormDataClient。
pub fn FormDataClient::new(base_url : String) -> FormDataClient {
  { base_url, }
}

///|

///|
/// 调用 post /multipart/form-data/mixed-parts（自动解析响应）。
pub async fn FormDataClient::post_multipart_form_data_mixed_parts(
  self : FormDataClient,
  body : MultiPartRequest,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/mixed-parts",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
/// 调用 post /multipart/form-data/mixed-parts-with-wire-name（自动解析响应）。
pub async fn FormDataClient::post_multipart_form_data_mixed_parts_with_wire_name(
  self : FormDataClient,
  body : MultiPartRequestWithWireName,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/mixed-parts-with-wire-name",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
/// 调用 post /multipart/form-data/optional-parts（自动解析响应）。
pub async fn FormDataClient::post_multipart_form_data_optional_parts(
  self : FormDataClient,
  body : MultiPartOptionalRequest,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/optional-parts",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
/// 调用 post /multipart/form-data/complex-parts（自动解析响应）。
pub async fn FormDataClient::post_multipart_form_data_complex_parts(
  self : FormDataClient,
  body : ComplexPartsRequest,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/complex-parts",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
/// 调用 post /multipart/form-data/json-part（自动解析响应）。
pub async fn FormDataClient::post_multipart_form_data_json_part(
  self : FormDataClient,
  body : JsonPartRequest,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/json-part",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
/// 调用 post /multipart/form-data/binary-array-parts（自动解析响应）。
pub async fn FormDataClient::post_multipart_form_data_binary_array_parts(
  self : FormDataClient,
  body : BinaryArrayPartsRequest,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/binary-array-parts",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
/// 调用 post /multipart/form-data/multi-binary-parts（自动解析响应）。
pub async fn FormDataClient::post_multipart_form_data_multi_binary_parts(
  self : FormDataClient,
  body : MultiBinaryPartsRequest,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/multi-binary-parts",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
/// 调用 post /multipart/form-data/check-filename-and-content-type（自动解析响应）。
pub async fn FormDataClient::post_multipart_form_data_check_filename_and_content_type(
  self : FormDataClient,
  body : MultiPartRequest,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/check-filename-and-content-type",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
/// 调用 post /multipart/form-data/anonymous-model（自动解析响应）。
pub async fn FormDataClient::post_multipart_form_data_anonymous_model(
  self : FormDataClient,
  body : Model1,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/anonymous-model",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
/// HttpPartsClient HTTP 客户端。
pub(all) struct HttpPartsClient {
  base_url : String
}

///|

///|
/// 创建 HttpPartsClient。
pub fn HttpPartsClient::new(base_url : String) -> HttpPartsClient {
  { base_url, }
}

///|

///|
/// 调用 post /multipart/form-data/complex-parts-with-httppart（自动解析响应）。
pub async fn HttpPartsClient::post_multipart_form_data_complex_parts_with_httppart(
  self : HttpPartsClient,
  body : ComplexHttpPartsModelRequest,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/complex-parts-with-httppart",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
/// ContentTypeClient HTTP 客户端。
pub(all) struct ContentTypeClient {
  base_url : String
}

///|

///|
/// 创建 ContentTypeClient。
pub fn ContentTypeClient::new(base_url : String) -> ContentTypeClient {
  { base_url, }
}

///|

///|
/// 调用 post /multipart/form-data/check-filename-and-specific-content-type-with-httppart（自动解析响应）。
pub async fn ContentTypeClient::post_multipart_form_data_check_filename_and_specific_content_type_with_httppart(
  self : ContentTypeClient,
  body : FileWithHttpPartSpecificContentTypeRequest,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/check-filename-and-specific-content-type-with-httppart",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
/// 调用 post /multipart/form-data/check-filename-and-required-content-type-with-httppart（自动解析响应）。
pub async fn ContentTypeClient::post_multipart_form_data_check_filename_and_required_content_type_with_httppart(
  self : ContentTypeClient,
  body : FileWithHttpPartRequiredContentTypeRequest,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/check-filename-and-required-content-type-with-httppart",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
/// 调用 post /multipart/form-data/file-with-http-part-optional-content-type（自动解析响应）。
pub async fn ContentTypeClient::post_multipart_form_data_file_with_http_part_optional_content_type(
  self : ContentTypeClient,
  body : FileWithHttpPartOptionalContentTypeRequest,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/file-with-http-part-optional-content-type",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
/// NonStringClient HTTP 客户端。
pub(all) struct NonStringClient {
  base_url : String
}

///|

///|
/// 创建 NonStringClient。
pub fn NonStringClient::new(base_url : String) -> NonStringClient {
  { base_url, }
}

///|

///|
/// 调用 post /multipart/form-data/non-string-float（自动解析响应）。
pub async fn NonStringClient::post_multipart_form_data_non_string_float(
  self : NonStringClient,
  body : Model0,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/multipart/form-data/non-string-float",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Content-Type", "multipart/form-data")
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
