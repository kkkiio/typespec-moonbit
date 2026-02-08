///|

///|
/// 对齐上游：test/e2e/http/special-headers/*/main.test.ts（非 skip）
#cfg(target="native")
async test "runtime special-headers" {
  let conditional = @special_headers_conditional_request.ConditionalRequestClient::new(
    "http://localhost:3000",
  )
  conditional.head_special_headers_conditional_request_if_modified_since(
    Some("Fri, 26 Aug 2022 14:38:00 GMT"),
  )
  conditional.post_special_headers_conditional_request_if_unmodified_since(
    Some("Fri, 26 Aug 2022 14:38:00 GMT"),
  )
  let repeatability = @special_headers_repeatability.RepeatabilityClient::new(
    "http://localhost:3000",
  )
  repeatability.post_special_headers_repeatability_immediatesuccess(
    "2378d9bc-1726-11ee-be56-0242ac120002", "Tue, 15 Nov 2022 12:45:26 GMT",
  )
}
