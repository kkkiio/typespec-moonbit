///|

///|
/// 对齐上游：test/e2e/http/special-headers/*/main.test.ts（非 skip）
#cfg(target="native")
async test "runtime special-headers" {
  let if_time = @runtime.UtcDateTime::from_string("2022-08-26T14:38:00.000Z")
  let repeatability_first_sent = @runtime.UtcDateTime::from_string(
    "2022-11-15T12:45:26.000Z",
  )
  let conditional = @special_headers_conditional_request.ConditionalRequestClient::new(
    "http://localhost:3000",
  )
  conditional.head_special_headers_conditional_request_if_modified_since(
    Some(if_time),
  )
  conditional.post_special_headers_conditional_request_if_unmodified_since(
    Some(if_time),
  )
  let repeatability = @special_headers_repeatability.RepeatabilityClient::new(
    "http://localhost:3000",
  )
  repeatability.post_special_headers_repeatability_immediatesuccess(
    "2378d9bc-1726-11ee-be56-0242ac120002", repeatability_first_sent,
  )
}
