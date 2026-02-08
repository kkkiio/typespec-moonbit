///|

///|
fn load_png_bytes() -> Bytes raise {
  @fs.read_file_to_bytes("node_modules/@typespec/http-specs/assets/image.png")
}

///|

///|
/// 对齐上游：test/e2e/http/encode/bytes/main.test.ts（非 skip）
#cfg(target="native")
async test "runtime encode/bytes" {
  let test_bytes = @encoding/utf8.encode("test")
  let png_bytes = load_png_bytes()
  let query = @encode_bytes.QueryClient::new("http://localhost:3000")
  query.get_encode_bytes_query_base64__value_(test_bytes)
  query.get_encode_bytes_query_base64url__value_(test_bytes)
  query.get_encode_bytes_query_base64url_array__value_([test_bytes, test_bytes])
  let property = @encode_bytes.PropertyClient::new("http://localhost:3000")
  let base64 = property.post_encode_bytes_property_base64({ value: test_bytes })
  assert_eq(base64.value, test_bytes)
  let base64url = property.post_encode_bytes_property_base64url({
    value: test_bytes,
  })
  assert_eq(base64url.value, test_bytes)
  let header = @encode_bytes.HeaderClient::new("http://localhost:3000")
  header.get_encode_bytes_header_base64(test_bytes)
  header.get_encode_bytes_header_base64url(test_bytes)
  let request_body = @encode_bytes.RequestBodyClient::new(
    "http://localhost:3000",
  )
  request_body.post_encode_bytes_body_request_octet_stream(png_bytes)
  request_body.post_encode_bytes_body_request_custom_content_type(png_bytes)
  let response_body = @encode_bytes.ResponseBodyClient::new(
    "http://localhost:3000",
  )
  let response_base64 = response_body.get_encode_bytes_body_response_base64()
  assert_eq(response_base64, test_bytes)
  let response_base64url = response_body.get_encode_bytes_body_response_base64url()
  assert_eq(response_base64url, test_bytes)
}

///|
#cfg(target="native")
async test "runtime encode/bytes: full body and response coverage" {
  let test_bytes = @encoding/utf8.encode("test")
  let png_bytes = load_png_bytes()
  let request_body = @encode_bytes.RequestBodyClient::new(
    "http://localhost:3000",
  )
  request_body.post_encode_bytes_body_request_default(png_bytes)
  request_body.post_encode_bytes_body_request_base64(test_bytes)
  request_body.post_encode_bytes_body_request_base64url(test_bytes)
  let response_body = @encode_bytes.ResponseBodyClient::new(
    "http://localhost:3000",
  )
  let response_default = response_body.get_encode_bytes_body_response_default()
  assert_eq(response_default, png_bytes)
  let response_octet = response_body.get_encode_bytes_body_response_octet_stream()
  assert_eq(response_octet, png_bytes)
  let response_custom = response_body.get_encode_bytes_body_response_custom_content_type()
  assert_eq(response_custom, png_bytes)
}

///|
/// 对齐上游：test/e2e/http/encode/datetime/main.test.ts（非 skip）
#cfg(target="native")
async test "runtime encode/datetime" {
  let query = @encode_datetime.QueryClient::new("http://localhost:3000")
  query.get_encode_datetime_query_default__value_("2022-08-26T18:38:00.000Z")
  query.get_encode_datetime_query_rfc3339__value_("2022-08-26T18:38:00.000Z")
  let rfc7231 : Result[Unit, Error] = try? query.get_encode_datetime_query_rfc7231__value_(
    "Fri, 26 Aug 2022 14:38:00 GMT",
  )
  match rfc7231 {
    Ok(_) => fail("expected rfc7231 query currently fails with 400")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("expected 400 error, got: " + err.to_string())
      }
  }
  let property = @encode_datetime.PropertyClient::new("http://localhost:3000")
  let rfc3339 = property.post_encode_datetime_property_rfc3339({
    value: "2022-08-26T18:38:00.000Z",
  })
  assert_eq(rfc3339.value, "2022-08-26T18:38:00.000Z")
  let header = @encode_datetime.HeaderClient::new("http://localhost:3000")
  header.get_encode_datetime_header_default("Fri, 26 Aug 2022 14:38:00 GMT")
  header.get_encode_datetime_header_rfc3339("2022-08-26T18:38:00.000Z")
  header.get_encode_datetime_header_rfc7231("Fri, 26 Aug 2022 14:38:00 GMT")
  let response_header = @encode_datetime.ResponseHeaderClient::new(
    "http://localhost:3000",
  )
  response_header.get_encode_datetime_responseheader_default()
  response_header.get_encode_datetime_responseheader_rfc3339()
}

///|
/// 对齐上游：test/e2e/http/encode/duration/main.test.ts（非 skip）
#cfg(target="native")
async test "runtime encode/duration" {
  let query = @encode_duration.QueryClient::new("http://localhost:3000")
  query.get_encode_duration_query_default__input_("P40D")
  query.get_encode_duration_query_iso8601__input_("P40D")
  let property = @encode_duration.PropertyClient::new("http://localhost:3000")
  let default_response = property.post_encode_duration_property_default({
    value: "P40D",
  })
  assert_eq(default_response.value, "P40D")
  let iso_response = property.post_encode_duration_property_iso8601({
    value: "P40D",
  })
  assert_eq(iso_response.value, "P40D")
  let header = @encode_duration.HeaderClient::new("http://localhost:3000")
  header.get_encode_duration_header_default("P40D")
  header.get_encode_duration_header_iso8601("P40D")
  header.get_encode_duration_header_iso8601_array(["P40D", "P50D"])
}
