///|
/// QueryClient HTTP 客户端。
pub struct QueryClient {
  base_url : String
}

///|
/// 创建 QueryClient。
pub fn QueryClient::new(base_url : String) -> QueryClient {
  { base_url, }
}

///|
/// 调用 get /parameters/collection-format/query/multi{?colors*}。
pub async fn QueryClient::get_parameters_collection_format_query_multi__colors__(
  self : QueryClient,
  colors : Array[String],
) -> @http.Response {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=115)
  sb0.write_string("/parameters/collection-format/query/multi")
  sb0.write_string(@client_runtime.expand_array("?", "colors", true, colors))
  let base_path = sb0.to_string()
  let base_path = @client_runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  client.end_request()
}

///|
/// 调用 get /parameters/collection-format/query/ssv{?colors}。
pub async fn QueryClient::get_parameters_collection_format_query_ssv__colors_(
  self : QueryClient,
  colors : Array[String],
) -> @http.Response {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=112)
  sb0.write_string("/parameters/collection-format/query/ssv")
  let base_path = sb0.to_string()
  let base_path = @client_runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let mut first_query = !base_path.contains("?")
  if first_query {
    sb.write_char('?')
    first_query = false
  } else {
    sb.write_char('&')
  }
  sb.write_string("colors=")
  sb.write_string(
    @client_runtime.encode_query_component(@client_runtime.join(colors, " ")),
  )
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  client.end_request()
}

///|
/// 调用 get /parameters/collection-format/query/pipes{?colors}。
pub async fn QueryClient::get_parameters_collection_format_query_pipes__colors_(
  self : QueryClient,
  colors : Array[String],
) -> @http.Response {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=114)
  sb0.write_string("/parameters/collection-format/query/pipes")
  let base_path = sb0.to_string()
  let base_path = @client_runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let mut first_query = !base_path.contains("?")
  if first_query {
    sb.write_char('?')
    first_query = false
  } else {
    sb.write_char('&')
  }
  sb.write_string("colors=")
  sb.write_string(
    @client_runtime.encode_query_component(@client_runtime.join(colors, "|")),
  )
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  client.end_request()
}

///|
/// 调用 get /parameters/collection-format/query/csv{?colors}。
pub async fn QueryClient::get_parameters_collection_format_query_csv__colors_(
  self : QueryClient,
  colors : Array[String],
) -> @http.Response {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let sb0 = StringBuilder::new(size_hint=112)
  sb0.write_string("/parameters/collection-format/query/csv")
  sb0.write_string(@client_runtime.expand_array("?", "colors", false, colors))
  let base_path = sb0.to_string()
  let base_path = @client_runtime.encode_request_target(base_path)
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  client.end_request()
}

///|
/// HeaderClient HTTP 客户端。
pub struct HeaderClient {
  base_url : String
}

///|
/// 创建 HeaderClient。
pub fn HeaderClient::new(base_url : String) -> HeaderClient {
  { base_url, }
}

///|
/// 调用 get /parameters/collection-format/header/csv。
pub async fn HeaderClient::get_parameters_collection_format_header_csv(
  self : HeaderClient,
  colors : Array[String],
) -> @http.Response {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @client_runtime.encode_request_target(
    "/parameters/collection-format/header/csv",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("colors", @client_runtime.join(colors, ","))
  let path = sb.to_string()
  client.request(@http.Get, path, extra_headers=headers)
  client.end_request()
}
