///|
/// RoutesClient HTTP 客户端。
pub(all) struct RoutesClient {
  base_url : String
}

///|
/// 创建 RoutesClient。
pub fn RoutesClient::new(base_url : String) -> RoutesClient {
  { base_url, }
}

///|
/// 调用 get /routes/fixed（自动解析响应）。
pub async fn RoutesClient::get_routes_fixed(self : RoutesClient) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/routes/fixed")
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
/// PathParametersClient HTTP 客户端。
pub(all) struct PathParametersClient {
  base_url : String
}

///|
/// 创建 PathParametersClient。
pub fn PathParametersClient::new(base_url : String) -> PathParametersClient {
  { base_url, }
}

///|
/// 调用 get /routes/path/template-only/{param}（自动解析响应）。
pub async fn PathParametersClient::get_routes_path_template_only__param_(
  self : PathParametersClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=98)
  sb0.write_string("/routes/path/template-only/")
  sb0.write_string(@runtime.expand_string("", "param", false, param))
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
/// 调用 get /routes/path/explicit/{param}（自动解析响应）。
pub async fn PathParametersClient::get_routes_path_explicit__param_(
  self : PathParametersClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=93)
  sb0.write_string("/routes/path/explicit/")
  sb0.write_string(@runtime.expand_string("", "param", false, param))
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
/// 调用 get /routes/path/annotation-only/{param}（自动解析响应）。
pub async fn PathParametersClient::get_routes_path_annotation_only__param_(
  self : PathParametersClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=100)
  sb0.write_string("/routes/path/annotation-only/")
  sb0.write_string(@runtime.expand_string("", "param", false, param))
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
/// ReservedExpansionClient HTTP 客户端。
pub(all) struct ReservedExpansionClient {
  base_url : String
}

///|
/// 创建 ReservedExpansionClient。
pub fn ReservedExpansionClient::new(
  base_url : String,
) -> ReservedExpansionClient {
  { base_url, }
}

///|
/// 调用 get /routes/path/reserved-expansion/template/{+param}（自动解析响应）。
pub async fn ReservedExpansionClient::get_routes_path_reserved_expansion_template___param_(
  self : ReservedExpansionClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=113)
  sb0.write_string("/routes/path/reserved-expansion/template/")
  sb0.write_string(@runtime.expand_string("+", "param", false, param))
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
/// 调用 get /routes/path/reserved-expansion/annotation/{+param}（自动解析响应）。
pub async fn ReservedExpansionClient::get_routes_path_reserved_expansion_annotation___param_(
  self : ReservedExpansionClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=115)
  sb0.write_string("/routes/path/reserved-expansion/annotation/")
  sb0.write_string(@runtime.expand_string("+", "param", false, param))
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
/// StandardClient HTTP 客户端。
pub(all) struct StandardClient {
  base_url : String
}

///|
/// 创建 StandardClient。
pub fn StandardClient::new(base_url : String) -> StandardClient {
  { base_url, }
}

///|
/// 调用 get /routes/path/simple/standard/primitive{param}（自动解析响应）。
pub async fn StandardClient::get_routes_path_simple_standard_primitive_param_(
  self : StandardClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=109)
  sb0.write_string("/routes/path/simple/standard/primitive")
  sb0.write_string(@runtime.expand_string("", "param", false, param))
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
/// 调用 get /routes/path/simple/standard/array{param}（自动解析响应）。
pub async fn StandardClient::get_routes_path_simple_standard_array_param_(
  self : StandardClient,
  param : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=105)
  sb0.write_string("/routes/path/simple/standard/array")
  sb0.write_string(@runtime.expand_array("", "param", false, param))
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
/// 调用 get /routes/path/simple/standard/record{param}（自动解析响应）。
pub async fn StandardClient::get_routes_path_simple_standard_record_param_(
  self : StandardClient,
  param : Map[String, Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=106)
  sb0.write_string("/routes/path/simple/standard/record")
  sb0.write_string(@runtime.expand_record("", "param", false, param))
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
/// 调用 get /routes/path/path/standard/primitive{/param}（自动解析响应）。
pub async fn StandardClient::get_routes_path_path_standard_primitive__param_(
  self : StandardClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=108)
  sb0.write_string("/routes/path/path/standard/primitive")
  sb0.write_string(@runtime.expand_string("/", "param", false, param))
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
/// 调用 get /routes/path/path/standard/array{/param}（自动解析响应）。
pub async fn StandardClient::get_routes_path_path_standard_array__param_(
  self : StandardClient,
  param : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=104)
  sb0.write_string("/routes/path/path/standard/array")
  sb0.write_string(@runtime.expand_array("/", "param", false, param))
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
/// 调用 get /routes/path/path/standard/record{/param}（自动解析响应）。
pub async fn StandardClient::get_routes_path_path_standard_record__param_(
  self : StandardClient,
  param : Map[String, Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=105)
  sb0.write_string("/routes/path/path/standard/record")
  sb0.write_string(@runtime.expand_record("/", "param", false, param))
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
/// 调用 get /routes/path/label/standard/primitive{.param}（自动解析响应）。
pub async fn StandardClient::get_routes_path_label_standard_primitive__param_(
  self : StandardClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=109)
  sb0.write_string("/routes/path/label/standard/primitive")
  sb0.write_string(@runtime.expand_string(".", "param", false, param))
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
/// 调用 get /routes/path/label/standard/array{.param}（自动解析响应）。
pub async fn StandardClient::get_routes_path_label_standard_array__param_(
  self : StandardClient,
  param : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=105)
  sb0.write_string("/routes/path/label/standard/array")
  sb0.write_string(@runtime.expand_array(".", "param", false, param))
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
/// 调用 get /routes/path/label/standard/record{.param}（自动解析响应）。
pub async fn StandardClient::get_routes_path_label_standard_record__param_(
  self : StandardClient,
  param : Map[String, Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=106)
  sb0.write_string("/routes/path/label/standard/record")
  sb0.write_string(@runtime.expand_record(".", "param", false, param))
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
/// 调用 get /routes/path/matrix/standard/primitive{;param}（自动解析响应）。
pub async fn StandardClient::get_routes_path_matrix_standard_primitive__param_(
  self : StandardClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=110)
  sb0.write_string("/routes/path/matrix/standard/primitive")
  sb0.write_string(@runtime.expand_string(";", "param", false, param))
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
/// 调用 get /routes/path/matrix/standard/array{;param}（自动解析响应）。
pub async fn StandardClient::get_routes_path_matrix_standard_array__param_(
  self : StandardClient,
  param : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=106)
  sb0.write_string("/routes/path/matrix/standard/array")
  sb0.write_string(@runtime.expand_array(";", "param", false, param))
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
/// 调用 get /routes/path/matrix/standard/record{;param}（自动解析响应）。
pub async fn StandardClient::get_routes_path_matrix_standard_record__param_(
  self : StandardClient,
  param : Map[String, Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=107)
  sb0.write_string("/routes/path/matrix/standard/record")
  sb0.write_string(@runtime.expand_record(";", "param", false, param))
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
/// 调用 get /routes/query/query-expansion/standard/primitive{?param}（自动解析响应）。
pub async fn StandardClient::get_routes_query_query_expansion_standard_primitive__param_(
  self : StandardClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=120)
  sb0.write_string("/routes/query/query-expansion/standard/primitive")
  sb0.write_string(@runtime.expand_string("?", "param", false, param))
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
/// 调用 get /routes/query/query-expansion/standard/array{?param}（自动解析响应）。
pub async fn StandardClient::get_routes_query_query_expansion_standard_array__param_(
  self : StandardClient,
  param : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=116)
  sb0.write_string("/routes/query/query-expansion/standard/array")
  sb0.write_string(@runtime.expand_array("?", "param", false, param))
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
/// 调用 get /routes/query/query-expansion/standard/record{?param}（自动解析响应）。
pub async fn StandardClient::get_routes_query_query_expansion_standard_record__param_(
  self : StandardClient,
  param : Map[String, Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=117)
  sb0.write_string("/routes/query/query-expansion/standard/record")
  sb0.write_string(@runtime.expand_record("?", "param", false, param))
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
/// 调用 get /routes/query/query-continuation/standard/primitive?fixed=true{&param}（自动解析响应）。
pub async fn StandardClient::get_routes_query_query_continuation_standard_primitive_fixed_true__param_(
  self : StandardClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=134)
  sb0.write_string(
    "/routes/query/query-continuation/standard/primitive?fixed=true",
  )
  sb0.write_string(@runtime.expand_string("&", "param", false, param))
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
/// 调用 get /routes/query/query-continuation/standard/array?fixed=true{&param}（自动解析响应）。
pub async fn StandardClient::get_routes_query_query_continuation_standard_array_fixed_true__param_(
  self : StandardClient,
  param : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=130)
  sb0.write_string("/routes/query/query-continuation/standard/array?fixed=true")
  sb0.write_string(@runtime.expand_array("&", "param", false, param))
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
/// 调用 get /routes/query/query-continuation/standard/record?fixed=true{&param}（自动解析响应）。
pub async fn StandardClient::get_routes_query_query_continuation_standard_record_fixed_true__param_(
  self : StandardClient,
  param : Map[String, Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=131)
  sb0.write_string(
    "/routes/query/query-continuation/standard/record?fixed=true",
  )
  sb0.write_string(@runtime.expand_record("&", "param", false, param))
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
/// ExplodeClient HTTP 客户端。
pub(all) struct ExplodeClient {
  base_url : String
}

///|
/// 创建 ExplodeClient。
pub fn ExplodeClient::new(base_url : String) -> ExplodeClient {
  { base_url, }
}

///|
/// 调用 get /routes/path/simple/explode/primitive{param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_path_simple_explode_primitive_param__(
  self : ExplodeClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=109)
  sb0.write_string("/routes/path/simple/explode/primitive")
  sb0.write_string(@runtime.expand_string("", "param", true, param))
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
/// 调用 get /routes/path/simple/explode/array{param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_path_simple_explode_array_param__(
  self : ExplodeClient,
  param : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=105)
  sb0.write_string("/routes/path/simple/explode/array")
  sb0.write_string(@runtime.expand_array("", "param", true, param))
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
/// 调用 get /routes/path/simple/explode/record{param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_path_simple_explode_record_param__(
  self : ExplodeClient,
  param : Map[String, Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=106)
  sb0.write_string("/routes/path/simple/explode/record")
  sb0.write_string(@runtime.expand_record("", "param", true, param))
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
/// 调用 get /routes/path/path/explode/primitive{/param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_path_path_explode_primitive__param__(
  self : ExplodeClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=108)
  sb0.write_string("/routes/path/path/explode/primitive")
  sb0.write_string(@runtime.expand_string("/", "param", true, param))
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
/// 调用 get /routes/path/path/explode/array{/param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_path_path_explode_array__param__(
  self : ExplodeClient,
  param : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=104)
  sb0.write_string("/routes/path/path/explode/array")
  sb0.write_string(@runtime.expand_array("/", "param", true, param))
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
/// 调用 get /routes/path/path/explode/record{/param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_path_path_explode_record__param__(
  self : ExplodeClient,
  param : Map[String, Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=105)
  sb0.write_string("/routes/path/path/explode/record")
  sb0.write_string(@runtime.expand_record("/", "param", true, param))
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
/// 调用 get /routes/path/label/explode/primitive{.param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_path_label_explode_primitive__param__(
  self : ExplodeClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=109)
  sb0.write_string("/routes/path/label/explode/primitive")
  sb0.write_string(@runtime.expand_string(".", "param", true, param))
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
/// 调用 get /routes/path/label/explode/array{.param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_path_label_explode_array__param__(
  self : ExplodeClient,
  param : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=105)
  sb0.write_string("/routes/path/label/explode/array")
  sb0.write_string(@runtime.expand_array(".", "param", true, param))
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
/// 调用 get /routes/path/label/explode/record{.param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_path_label_explode_record__param__(
  self : ExplodeClient,
  param : Map[String, Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=106)
  sb0.write_string("/routes/path/label/explode/record")
  sb0.write_string(@runtime.expand_record(".", "param", true, param))
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
/// 调用 get /routes/path/matrix/explode/primitive{;param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_path_matrix_explode_primitive__param__(
  self : ExplodeClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=110)
  sb0.write_string("/routes/path/matrix/explode/primitive")
  sb0.write_string(@runtime.expand_string(";", "param", true, param))
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
/// 调用 get /routes/path/matrix/explode/array{;param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_path_matrix_explode_array__param__(
  self : ExplodeClient,
  param : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=106)
  sb0.write_string("/routes/path/matrix/explode/array")
  sb0.write_string(@runtime.expand_array(";", "param", true, param))
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
/// 调用 get /routes/path/matrix/explode/record{;param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_path_matrix_explode_record__param__(
  self : ExplodeClient,
  param : Map[String, Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=107)
  sb0.write_string("/routes/path/matrix/explode/record")
  sb0.write_string(@runtime.expand_record(";", "param", true, param))
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
/// 调用 get /routes/query/query-expansion/explode/primitive{?param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_query_query_expansion_explode_primitive__param__(
  self : ExplodeClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=120)
  sb0.write_string("/routes/query/query-expansion/explode/primitive")
  sb0.write_string(@runtime.expand_string("?", "param", true, param))
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
/// 调用 get /routes/query/query-expansion/explode/array{?param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_query_query_expansion_explode_array__param__(
  self : ExplodeClient,
  param : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=116)
  sb0.write_string("/routes/query/query-expansion/explode/array")
  sb0.write_string(@runtime.expand_array("?", "param", true, param))
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
/// 调用 get /routes/query/query-expansion/explode/record{?param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_query_query_expansion_explode_record__param__(
  self : ExplodeClient,
  param : Map[String, Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=117)
  sb0.write_string("/routes/query/query-expansion/explode/record")
  sb0.write_string(@runtime.expand_record("?", "param", true, param))
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
/// 调用 get /routes/query/query-continuation/explode/primitive?fixed=true{&param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_query_query_continuation_explode_primitive_fixed_true__param__(
  self : ExplodeClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=134)
  sb0.write_string(
    "/routes/query/query-continuation/explode/primitive?fixed=true",
  )
  sb0.write_string(@runtime.expand_string("&", "param", true, param))
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
/// 调用 get /routes/query/query-continuation/explode/array?fixed=true{&param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_query_query_continuation_explode_array_fixed_true__param__(
  self : ExplodeClient,
  param : Array[String],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=130)
  sb0.write_string("/routes/query/query-continuation/explode/array?fixed=true")
  sb0.write_string(@runtime.expand_array("&", "param", true, param))
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
/// 调用 get /routes/query/query-continuation/explode/record?fixed=true{&param*}（自动解析响应）。
pub async fn ExplodeClient::get_routes_query_query_continuation_explode_record_fixed_true__param__(
  self : ExplodeClient,
  param : Map[String, Int],
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=131)
  sb0.write_string("/routes/query/query-continuation/explode/record?fixed=true")
  sb0.write_string(@runtime.expand_record("&", "param", true, param))
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
/// QueryParametersClient HTTP 客户端。
pub(all) struct QueryParametersClient {
  base_url : String
}

///|
/// 创建 QueryParametersClient。
pub fn QueryParametersClient::new(base_url : String) -> QueryParametersClient {
  { base_url, }
}

///|
/// 调用 get /routes/query/template-only{?param}（自动解析响应）。
pub async fn QueryParametersClient::get_routes_query_template_only__param_(
  self : QueryParametersClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=99)
  sb0.write_string("/routes/query/template-only")
  sb0.write_string(@runtime.expand_string("?", "param", false, param))
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
/// 调用 get /routes/query/explicit{?param}（自动解析响应）。
pub async fn QueryParametersClient::get_routes_query_explicit__param_(
  self : QueryParametersClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=94)
  sb0.write_string("/routes/query/explicit")
  sb0.write_string(@runtime.expand_string("?", "param", false, param))
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
/// 调用 get /routes/query/annotation-only{?param}（自动解析响应）。
pub async fn QueryParametersClient::get_routes_query_annotation_only__param_(
  self : QueryParametersClient,
  param : String,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=101)
  sb0.write_string("/routes/query/annotation-only")
  sb0.write_string(@runtime.expand_string("?", "param", false, param))
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
/// InInterfaceClient HTTP 客户端。
pub(all) struct InInterfaceClient {
  base_url : String
}

///|
/// 创建 InInterfaceClient。
pub fn InInterfaceClient::new(base_url : String) -> InInterfaceClient {
  { base_url, }
}

///|
/// 调用 get /routes/in-interface/fixed（自动解析响应）。
pub async fn InInterfaceClient::get_routes_in_interface_fixed(
  self : InInterfaceClient,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target("/routes/in-interface/fixed")
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
