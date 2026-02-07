///|

///|
/// 对齐上游断言：
/// .moonagent/repos/typespec/packages/http-client-js/test/e2e/http/type/scalar/main.test.ts
async test "runtime type/scalar: string boolean unknown" {
  let string_client = @type_scalar.StringClient::new("http://localhost:3000")
  let str = string_client.get_type_scalar_string()
  assert_eq(str, "test")
  let bool_client = @type_scalar.BooleanClient::new("http://localhost:3000")
  let b = bool_client.get_type_scalar_boolean()
  assert_eq(b, true)
  bool_client.put_type_scalar_boolean("application/json", true)
  let unknown_client = @type_scalar.UnknownClient::new("http://localhost:3000")
  let unknown = unknown_client.get_type_scalar_unknown()
  match unknown {
    String(v) => assert_eq(v, "test")
    _ => fail("unexpected unknown scalar variant")
  }
}

///|
/// 缺失类型修复来源：
/// .moonagent/repos/typespec/packages/http-client-js/test/e2e/http/type/scalar/main.test.ts
/// decimal / decimal128 在上游断言为 number，这里已修复 emitter 映射后按 number 断言。
#cfg(target="native")
async test "runtime type/scalar: decimal decimal128" {
  let decimal_client = @type_scalar.DecimalTypeClient::new(
    "http://localhost:3000",
  )
  let decimal_response = decimal_client.get_type_scalar_decimal_response_body()
  assert_eq(decimal_response, 0.33333)
  decimal_client.put_type_scalar_decimal_resquest_body(
    "application/json", 0.33333,
  )
  decimal_client.get_type_scalar_decimal_request_parameter__value_(0.33333)
  let decimal_verify = @type_scalar.DecimalVerifyClient::new(
    "http://localhost:3000",
  )
  let prepared = decimal_verify.get_type_scalar_decimal_prepare_verify()
  assert_eq(prepared, [0.1, 0.1, 0.1])
  decimal_verify.post_type_scalar_decimal_verify("application/json", 0.3)
  let decimal128_client = @type_scalar.Decimal128TypeClient::new(
    "http://localhost:3000",
  )
  let decimal128_response = decimal128_client.get_type_scalar_decimal128_response_body()
  assert_eq(decimal128_response, 0.33333)
  decimal128_client.put_type_scalar_decimal128_resquest_body(
    "application/json", 0.33333,
  )
  decimal128_client.get_type_scalar_decimal128_request_parameter__value_(
    0.33333,
  )
  let decimal128_verify = @type_scalar.Decimal128VerifyClient::new(
    "http://localhost:3000",
  )
  let prepared128 = decimal128_verify.get_type_scalar_decimal128_prepare_verify()
  assert_eq(prepared128, [0.1, 0.1, 0.1])
  decimal128_verify.post_type_scalar_decimal128_verify("application/json", 0.3)
}

///|
/// 对齐上游断言：
/// .moonagent/repos/typespec/packages/http-client-js/test/e2e/http/type/enum/extensible/main.test.ts
/// .moonagent/repos/typespec/packages/http-client-js/test/e2e/http/type/enum/fixed/main.test.ts
#cfg(target="native")
async test "runtime type/enum: extensible + fixed" {
  let ext = @type_enum_extensible.StringClient::new("http://localhost:3000")
  assert_eq(ext.get_type_enum_extensible_string_known_value(), "Monday")
  assert_eq(ext.get_type_enum_extensible_string_unknown_value(), "Weekend")
  let fixed = @type_enum_fixed.StringClient::new("http://localhost:3000")
  assert_eq(fixed.get_type_enum_fixed_string_known_value(), "Monday")
}
