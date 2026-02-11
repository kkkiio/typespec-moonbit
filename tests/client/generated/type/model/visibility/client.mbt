///|
/// VisibilityClient HTTP 客户端。
pub(all) struct VisibilityClient {
  base_url : String
}

///|
/// 创建 VisibilityClient。
pub fn VisibilityClient::new(base_url : String) -> VisibilityClient {
  { base_url, }
}

///|
/// 调用 get /type/model/visibility{?queryProp}（自动解析响应）。
pub async fn VisibilityClient::get_type_model_visibility__queryprop_(
  self : VisibilityClient,
  queryprop : Int,
  body : VisibilityModel,
) -> VisibilityModel {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=98)
  sb0.write_string("/type/model/visibility")
  sb0.write_string(
    @runtime.expand_string("?", "queryProp", false, queryprop.to_string()),
  )
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Get, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : VisibilityModel = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 head /type/model/visibility{?queryProp}（自动解析响应）。
pub async fn VisibilityClient::head_type_model_visibility__queryprop_(
  self : VisibilityClient,
  queryprop : Int,
  body : VisibilityModel,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=98)
  sb0.write_string("/type/model/visibility")
  sb0.write_string(
    @runtime.expand_string("?", "queryProp", false, queryprop.to_string()),
  )
  let base_path = sb0.to_string()
  let base_path = @runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Head, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 200 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/model/visibility（自动解析响应）。
pub async fn VisibilityClient::put_type_model_visibility(
  self : VisibilityClient,
  body : VisibilityModel,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/model/visibility")
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
/// 调用 patch /type/model/visibility（自动解析响应）。
pub async fn VisibilityClient::patch_type_model_visibility(
  self : VisibilityClient,
  body : VisibilityModel,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/model/visibility")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
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
/// 调用 post /type/model/visibility（自动解析响应）。
pub async fn VisibilityClient::post_type_model_visibility(
  self : VisibilityClient,
  body : VisibilityModel,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/model/visibility")
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
/// 调用 delete /type/model/visibility（自动解析响应）。
pub async fn VisibilityClient::delete_type_model_visibility(
  self : VisibilityClient,
  body : VisibilityModel,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/type/model/visibility")
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Delete, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}

///|
/// 调用 put /type/model/visibility/readonlyroundtrip（自动解析响应）。
pub async fn VisibilityClient::put_type_model_visibility_readonlyroundtrip(
  self : VisibilityClient,
  body : ReadOnlyModel,
) -> ReadOnlyModel {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/type/model/visibility/readonlyroundtrip",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  headers.set("content-type", "application/json")
  client.request(@http.Put, path, extra_headers=headers)
  client.write(body.to_json())
  let response = client.end_request()
  if response.code == 200 {
    @runtime.expect_json_content_type(response)
    let response_body = client.read_all().text()
    let parsed : ReadOnlyModel = @json.from_json(@json.parse(response_body))
    parsed
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
