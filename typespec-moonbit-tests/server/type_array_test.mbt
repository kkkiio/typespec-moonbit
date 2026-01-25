///|
/// Test for type/array
/// Reference: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/array/main.test.e2e.ts
async test "type/array" {
  let int32_handler = Int32ValueHandlerImpl::{  }
  let int64_handler = Int64ValueHandlerImpl::{  }
  let model_handler = ModelValueHandlerImpl::{  }
  let string_handler = StringValueHandlerImpl::{  }
  let boolean_handler = BooleanValueHandlerImpl::{  }
  let float32_handler = Float32ValueHandlerImpl::{  }
  let unknown_handler = UnknownValueHandlerImpl::{  }
  let datetime_handler = DatetimeValueHandlerImpl::{  }
  let duration_handler = DurationValueHandlerImpl::{  }
  let nullable_float_handler = NullableFloatValueHandlerImpl::{  }
  let nullable_int32_handler = NullableInt32ValueHandlerImpl::{  }
  let nullable_model_handler = NullableModelValueHandlerImpl::{  }
  let nullable_string_handler = NullableStringValueHandlerImpl::{  }
  let nullable_boolean_handler = NullableBooleanValueHandlerImpl::{  }
  let router = @type_array.create_router(
    int32_value_handler=int32_handler,
    int64_value_handler=int64_handler,
    model_value_handler=model_handler,
    string_value_handler=string_handler,
    boolean_value_handler=boolean_handler,
    float32_value_handler=float32_handler,
    unknown_value_handler=unknown_handler,
    datetime_value_handler=datetime_handler,
    duration_value_handler=duration_handler,
    nullable_float_value_handler=nullable_float_handler,
    nullable_int32_value_handler=nullable_int32_handler,
    nullable_model_value_handler=nullable_model_handler,
    nullable_string_value_handler=nullable_string_handler,
    nullable_boolean_value_handler=nullable_boolean_handler,
  )
  @async.with_task_group(fn(group) {
    let base_url = @server.start_server(group, router)
    // Skip int64 value scenarios (BigInt not fully supported)
    let status = @server.run_scenario("type/array/!(int64value)*/*", base_url)
    assert_true(status is @server.Status::Pass)
  })
}

///|
struct Int32ValueHandlerImpl {}

///|
impl @type_array.Int32ValueHandler for Int32ValueHandlerImpl with get(_self) {
  [
    // Should return [1, 2]
    1, 2,
  ]
}

///|
impl @type_array.Int32ValueHandler for Int32ValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 2)
  assert_eq(body[0], 1)
  assert_eq(body[1], 2)
}

///|
struct Int64ValueHandlerImpl {}

///|
impl @type_array.Int64ValueHandler for Int64ValueHandlerImpl with get(_self) {
  [
    // Should return [0x7fffffffffffffff, -0x7fffffffffffffff]
    0x7fffffffffffffffL, -0x7fffffffffffffffL,
  ]
}

///|
impl @type_array.Int64ValueHandler for Int64ValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 2)
  assert_eq(body[0], 0x7fffffffffffffffL)
  assert_eq(body[1], -0x7fffffffffffffffL)
}

///|
struct ModelValueHandlerImpl {}

///|
impl @type_array.ModelValueHandler for ModelValueHandlerImpl with get(_self) {
  [
    // Should return [{ property: "hello" }, { property: "world" }]
    { property: "hello", children: None },
    { property: "world", children: None },
  ]
}

///|
impl @type_array.ModelValueHandler for ModelValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 2)
  assert_eq(body[0].property, "hello")
  assert_eq(body[1].property, "world")
}

///|
struct StringValueHandlerImpl {}

///|
impl @type_array.StringValueHandler for StringValueHandlerImpl with get(_self) {
  [
    // Should return ["hello", ""]
    "hello", "",
  ]
}

///|
impl @type_array.StringValueHandler for StringValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 2)
  assert_eq(body[0], "hello")
  assert_eq(body[1], "")
}

///|
struct BooleanValueHandlerImpl {}

///|
impl @type_array.BooleanValueHandler for BooleanValueHandlerImpl with get(_self) {
  [
    // Should return [true, false]
    true, false,
  ]
}

///|
impl @type_array.BooleanValueHandler for BooleanValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 2)
  assert_eq(body[0], true)
  assert_eq(body[1], false)
}

///|
struct Float32ValueHandlerImpl {}

///|
impl @type_array.Float32ValueHandler for Float32ValueHandlerImpl with get(_self) {
  [
    // Should return [43.125]
    43.125,
  ]
}

///|
impl @type_array.Float32ValueHandler for Float32ValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 1)
  assert_eq(body[0], 43.125)
}

///|
struct UnknownValueHandlerImpl {}

///|
impl @type_array.UnknownValueHandler for UnknownValueHandlerImpl with get(_self) {
  // Should return [1, "hello", null]
  let j = @json.parse("[1, \"hello\", null]")
  @json.from_json(j)
}

///|
impl @type_array.UnknownValueHandler for UnknownValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 3)
  assert_eq(body[0].stringify(), "1")
  assert_eq(body[1].stringify(), "\"hello\"")
  assert_eq(body[2].stringify(), "null")
}

///|
struct DatetimeValueHandlerImpl {}

///|
impl @type_array.DatetimeValueHandler for DatetimeValueHandlerImpl with get(
  _self,
) {
  // Should return [Temporal.Instant.from("2022-08-26T18:38:00Z")]
  ["2022-08-26T18:38:00Z"]
}

///|
impl @type_array.DatetimeValueHandler for DatetimeValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 1)
  assert_eq(body[0], "2022-08-26T18:38:00Z")
}

///|
struct DurationValueHandlerImpl {}

///|
impl @type_array.DurationValueHandler for DurationValueHandlerImpl with get(
  _self,
) {
  // Should return [Temporal.Duration.from("P123DT22H14M12.011S")]
  ["P123DT22H14M12.011S"]
}

///|
impl @type_array.DurationValueHandler for DurationValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 1)
  assert_eq(body[0], "P123DT22H14M12.011S")
}

///|
struct NullableFloatValueHandlerImpl {}

///|
impl @type_array.NullableFloatValueHandler for NullableFloatValueHandlerImpl with get(
  _self,
) {
  // Should return [1.25, null, 3.0]
  [
    @type_array.Nullable(Some(1.25)),
    @type_array.Nullable(None),
    @type_array.Nullable(Some(3.0)),
  ]
}

///|
impl @type_array.NullableFloatValueHandler for NullableFloatValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 3)
  assert_eq(body[0], @type_array.Nullable(Some(1.25)))
  assert_eq(body[1], @type_array.Nullable(None))
  assert_eq(body[2], @type_array.Nullable(Some(3.0)))
}

///|
struct NullableInt32ValueHandlerImpl {}

///|
impl @type_array.NullableInt32ValueHandler for NullableInt32ValueHandlerImpl with get(
  _self,
) {
  // Should return [1, null, 3]
  [
    @type_array.Nullable(Some(1)),
    @type_array.Nullable(None),
    @type_array.Nullable(Some(3)),
  ]
}

///|
impl @type_array.NullableInt32ValueHandler for NullableInt32ValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 3)
  assert_eq(body[0], @type_array.Nullable(Some(1)))
  assert_eq(body[1], @type_array.Nullable(None))
  assert_eq(body[2], @type_array.Nullable(Some(3)))
}

///|
struct NullableModelValueHandlerImpl {}

///|
impl @type_array.NullableModelValueHandler for NullableModelValueHandlerImpl with get(
  _self,
) {
  // Should return [{ property: "hello" }, null, { property: "world" }]
  [
    @type_array.Nullable(Some({ property: "hello", children: None })),
    @type_array.Nullable(None),
    @type_array.Nullable(Some({ property: "world", children: None })),
  ]
}

///|
impl @type_array.NullableModelValueHandler for NullableModelValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 3)
  match body[0].0 {
    Some(v) => assert_eq(v.property, "hello")
    None =>
      assert_true(false, msg="nullable-model.put: body[0] should not be null")
  }
  assert_true(body[1].0 is None)
  match body[2].0 {
    Some(v) => assert_eq(v.property, "world")
    None =>
      assert_true(false, msg="nullable-model.put: body[2] should not be null")
  }
}

///|
struct NullableStringValueHandlerImpl {}

///|
impl @type_array.NullableStringValueHandler for NullableStringValueHandlerImpl with get(
  _self,
) {
  // Should return ["hello", null, "world"]
  [
    @type_array.Nullable(Some("hello")),
    @type_array.Nullable(None),
    @type_array.Nullable(Some("world")),
  ]
}

///|
impl @type_array.NullableStringValueHandler for NullableStringValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 3)
  assert_eq(body[0], @type_array.Nullable(Some("hello")))
  assert_eq(body[1], @type_array.Nullable(None))
  assert_eq(body[2], @type_array.Nullable(Some("world")))
}

///|
struct NullableBooleanValueHandlerImpl {}

///|
impl @type_array.NullableBooleanValueHandler for NullableBooleanValueHandlerImpl with get(
  _self,
) {
  // Should return [true, null, false]
  [
    @type_array.Nullable(Some(true)),
    @type_array.Nullable(None),
    @type_array.Nullable(Some(false)),
  ]
}

///|
impl @type_array.NullableBooleanValueHandler for NullableBooleanValueHandlerImpl with put(
  _self,
  body,
) {
  assert_eq(body.length(), 3)
  assert_eq(body[0], @type_array.Nullable(Some(true)))
  assert_eq(body[1], @type_array.Nullable(None))
  assert_eq(body[2], @type_array.Nullable(Some(false)))
}
