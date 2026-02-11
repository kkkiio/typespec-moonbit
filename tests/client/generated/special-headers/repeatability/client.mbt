///|
/// RepeatabilityClient HTTP 客户端。
pub(all) struct RepeatabilityClient {
  base_url : String
}

///|
/// 创建 RepeatabilityClient。
pub fn RepeatabilityClient::new(base_url : String) -> RepeatabilityClient {
  { base_url, }
}

///|
/// 调用 post /special-headers/repeatability/immediateSuccess（自动解析响应）。
pub async fn RepeatabilityClient::post_special_headers_repeatability_immediatesuccess(
  self : RepeatabilityClient,
  repeatability_request_id : String,
  repeatability_first_sent : @runtime.UtcDateTime,
) -> Unit {
  let client = @http.Client::new(self.base_url)
  defer client.close()
  let headers : Map[String, String] = {}
  let base_path = @runtime.encode_request_target(
    "/special-headers/repeatability/immediateSuccess",
  )
  let sb = StringBuilder::new(size_hint=base_path.length() + 128)
  sb.write_string(base_path)
  headers.set("Repeatability-Request-ID", repeatability_request_id)
  headers.set(
    "Repeatability-First-Sent",
    @runtime.encode_utc_datetime_uri(
      repeatability_first_sent,
      @runtime.DateTimeEncoding::Rfc7231,
      @runtime.NumberWireType::Int64,
    ),
  )
  let path = sb.to_string()
  client.request(@http.Post, path, extra_headers=headers)
  let response = client.end_request()
  if response.code == 204 {
    ()
  } else {
    fail("unexpected status code: " + response.code.to_string())
  }
}
