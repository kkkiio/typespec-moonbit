///|

///|
/// 对齐上游：test/e2e/http/type/array/array.test.ts（核心断言）
#cfg(target="native")
async test "runtime type/array" {
  let int32_client = @type_array_generated.Int32ValueClient::new(
    "http://localhost:3000",
  )
  let int32_response = int32_client.get_type_array_int32()
  assert_eq(int32_response, [1, 2])
  int32_client.put_type_array_int32([1, 2])
  let bool_client = @type_array_generated.BooleanValueClient::new(
    "http://localhost:3000",
  )
  let bool_response = bool_client.get_type_array_boolean()
  assert_eq(bool_response, [true, false])
  bool_client.put_type_array_boolean([true, false])
  let string_client = @type_array_generated.StringValueClient::new(
    "http://localhost:3000",
  )
  let string_response = string_client.get_type_array_string()
  assert_eq(string_response, ["hello", ""])
  string_client.put_type_array_string(["hello", ""])
  let float_client = @type_array_generated.Float32ValueClient::new(
    "http://localhost:3000",
  )
  let float_response = float_client.get_type_array_float32()
  assert_eq(float_response, [43.125])
  float_client.put_type_array_float32([43.125])
  let duration_client = @type_array_generated.DurationValueClient::new(
    "http://localhost:3000",
  )
  let duration_response = duration_client.get_type_array_duration()
  assert_eq(duration_response, ["P123DT22H14M12.011S"])
  duration_client.put_type_array_duration(["P123DT22H14M12.011S"])
}
