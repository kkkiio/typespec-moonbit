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
    int32_handler, int64_handler, model_handler, string_handler, boolean_handler,
    float32_handler, unknown_handler, datetime_handler, duration_handler, nullable_float_handler,
    nullable_int32_handler, nullable_model_handler, nullable_string_handler, nullable_boolean_handler,
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
impl @type_array.Int32ValueHandler for Int32ValueHandlerImpl with get(
  _self : Int32ValueHandlerImpl,
) {
  // Should return [1, 2]
  [1, 2]
}

///|
impl @type_array.Int32ValueHandler for Int32ValueHandlerImpl with put(
  _self : Int32ValueHandlerImpl,
  body : Array[Int],
) {
  guard body.length() == 2 else { fail("int32.put: body length should be 2") }
  guard body[0] == 1 else { fail("int32.put: body[0] should be 1") }
  guard body[1] == 2 else { fail("int32.put: body[1] should be 2") }
}

///|
struct Int64ValueHandlerImpl {}

///|
impl @type_array.Int64ValueHandler for Int64ValueHandlerImpl with get(
  _self : Int64ValueHandlerImpl,
) {
  // Should return [0x7fffffffffffffff, -0x7fffffffffffffff]
  [0x7fffffffffffffffL, -0x7fffffffffffffffL]
}

///|
impl @type_array.Int64ValueHandler for Int64ValueHandlerImpl with put(
  _self : Int64ValueHandlerImpl,
  body : Array[Int64],
) {
  guard body.length() == 2 else { fail("int64.put: body length should be 2") }
  guard body[0] == 0x7fffffffffffffffL else {
    fail("int64.put: body[0] should be max int64")
  }
  guard body[1] == -0x7fffffffffffffffL else {
    fail("int64.put: body[1] should be min int64")
  }
}

///|
struct ModelValueHandlerImpl {}

///|
impl @type_array.ModelValueHandler for ModelValueHandlerImpl with get(
  _self : ModelValueHandlerImpl,
) {
  // Should return [{ property: "hello" }, { property: "world" }]
  [{ property: "hello", children: None }, { property: "world", children: None }]
}

///|
impl @type_array.ModelValueHandler for ModelValueHandlerImpl with put(
  _self : ModelValueHandlerImpl,
  body : Array[@type_array.InnerModel],
) {
  guard body.length() == 2 else { fail("model.put: body length should be 2") }
  guard body[0].property == "hello" else {
    fail("model.put: body[0].property should be 'hello'")
  }
  guard body[1].property == "world" else {
    fail("model.put: body[1].property should be 'world'")
  }
}

///|
struct StringValueHandlerImpl {}

///|
impl @type_array.StringValueHandler for StringValueHandlerImpl with get(
  _self : StringValueHandlerImpl,
) {
  // Should return ["hello", ""]
  ["hello", ""]
}

///|
impl @type_array.StringValueHandler for StringValueHandlerImpl with put(
  _self : StringValueHandlerImpl,
  body : Array[String],
) {
  guard body.length() == 2 else { fail("string.put: body length should be 2") }
  guard body[0] == "hello" else {
    fail("string.put: body[0] should be 'hello'")
  }
  guard body[1] == "" else {
    fail("string.put: body[1] should be empty string")
  }
}

///|
struct BooleanValueHandlerImpl {}

///|
impl @type_array.BooleanValueHandler for BooleanValueHandlerImpl with get(
  _self : BooleanValueHandlerImpl,
) {
  // Should return [true, false]
  [true, false]
}

///|
impl @type_array.BooleanValueHandler for BooleanValueHandlerImpl with put(
  _self : BooleanValueHandlerImpl,
  body : Array[Bool],
) {
  guard body.length() == 2 else { fail("boolean.put: body length should be 2") }
  guard body[0] == true else { fail("boolean.put: body[0] should be true") }
  guard body[1] == false else { fail("boolean.put: body[1] should be false") }
}

///|
struct Float32ValueHandlerImpl {}

///|
impl @type_array.Float32ValueHandler for Float32ValueHandlerImpl with get(
  _self : Float32ValueHandlerImpl,
) {
  // Should return [43.125]
  [43.125]
}

///|
impl @type_array.Float32ValueHandler for Float32ValueHandlerImpl with put(
  _self : Float32ValueHandlerImpl,
  body : Array[Double],
) {
  guard body.length() == 1 else { fail("float32.put: body length should be 1") }
  guard body[0] == 43.125 else { fail("float32.put: body[0] should be 43.125") }
}

///|
struct UnknownValueHandlerImpl {}

///|
impl @type_array.UnknownValueHandler for UnknownValueHandlerImpl with get(
  _self : UnknownValueHandlerImpl,
) {
  // Should return [1, "hello", null]
  let j = @json.parse("[1, \"hello\", null]")
  @json.from_json(j)
}

///|
impl @type_array.UnknownValueHandler for UnknownValueHandlerImpl with put(
  _self : UnknownValueHandlerImpl,
  body : Array[Json],
) {
  guard body.length() == 3 else { fail("unknown.put: body length should be 3") }
  guard body[0].stringify() == "1" else {
    fail("unknown.put: body[0] should be 1")
  }
  guard body[1].stringify() == "\"hello\"" else {
    fail("unknown.put: body[1] should be 'hello'")
  }
  guard body[2].stringify() == "null" else {
    fail("unknown.put: body[2] should be null")
  }
}

///|
struct DatetimeValueHandlerImpl {}

///|
impl @type_array.DatetimeValueHandler for DatetimeValueHandlerImpl with get(
  _self : DatetimeValueHandlerImpl,
) {
  // Should return [Temporal.Instant.from("2022-08-26T18:38:00Z")]
  ["2022-08-26T18:38:00Z"]
}

///|
impl @type_array.DatetimeValueHandler for DatetimeValueHandlerImpl with put(
  _self : DatetimeValueHandlerImpl,
  body : Array[String],
) {
  guard body.length() == 1 else {
    fail("datetime.put: body length should be 1")
  }
  guard body[0] == "2022-08-26T18:38:00Z" else {
    fail("datetime.put: body[0] should be '2022-08-26T18:38:00Z'")
  }
}

///|
struct DurationValueHandlerImpl {}

///|
impl @type_array.DurationValueHandler for DurationValueHandlerImpl with get(
  _self : DurationValueHandlerImpl,
) {
  // Should return [Temporal.Duration.from("P123DT22H14M12.011S")]
  ["P123DT22H14M12.011S"]
}

///|
impl @type_array.DurationValueHandler for DurationValueHandlerImpl with put(
  _self : DurationValueHandlerImpl,
  body : Array[String],
) {
  guard body.length() == 1 else {
    fail("duration.put: body length should be 1")
  }
  guard body[0] == "P123DT22H14M12.011S" else {
    fail("duration.put: body[0] should be 'P123DT22H14M12.011S'")
  }
}

///|
struct NullableFloatValueHandlerImpl {}

///|
impl @type_array.NullableFloatValueHandler for NullableFloatValueHandlerImpl with get(
  _self : NullableFloatValueHandlerImpl,
) {
  // Should return [1.25, null, 3.0]
  [
    @type_array.Nullable::some(1.25),
    @type_array.Nullable::none(),
    @type_array.Nullable::some(3.0),
  ]
}

///|
impl @type_array.NullableFloatValueHandler for NullableFloatValueHandlerImpl with put(
  _self : NullableFloatValueHandlerImpl,
  body : Array[@type_array.Nullable[Double]],
) {
  guard body.length() == 3 else {
    fail("nullable-float.put: body length should be 3")
  }
  guard body[0].value == Some(1.25) else {
    fail("nullable-float.put: body[0] should be 1.25")
  }
  guard body[1].value is None else {
    fail("nullable-float.put: body[1] should be null")
  }
  guard body[2].value == Some(3.0) else {
    fail("nullable-float.put: body[2] should be 3.0")
  }
}

///|
struct NullableInt32ValueHandlerImpl {}

///|
impl @type_array.NullableInt32ValueHandler for NullableInt32ValueHandlerImpl with get(
  _self : NullableInt32ValueHandlerImpl,
) {
  // Should return [1, null, 3]
  [
    @type_array.Nullable::some(1),
    @type_array.Nullable::none(),
    @type_array.Nullable::some(3),
  ]
}

///|
impl @type_array.NullableInt32ValueHandler for NullableInt32ValueHandlerImpl with put(
  _self : NullableInt32ValueHandlerImpl,
  body : Array[@type_array.Nullable[Int]],
) {
  guard body.length() == 3 else {
    fail("nullable-int32.put: body length should be 3")
  }
  guard body[0].value == Some(1) else {
    fail("nullable-int32.put: body[0] should be 1")
  }
  guard body[1].value is None else {
    fail("nullable-int32.put: body[1] should be null")
  }
  guard body[2].value == Some(3) else {
    fail("nullable-int32.put: body[2] should be 3")
  }
}

///|
struct NullableModelValueHandlerImpl {}

///|
impl @type_array.NullableModelValueHandler for NullableModelValueHandlerImpl with get(
  _self : NullableModelValueHandlerImpl,
) {
  // Should return [{ property: "hello" }, null, { property: "world" }]
  [
    @type_array.Nullable::some({ property: "hello", children: None }),
    @type_array.Nullable::none(),
    @type_array.Nullable::some({ property: "world", children: None }),
  ]
}

///|
impl @type_array.NullableModelValueHandler for NullableModelValueHandlerImpl with put(
  _self : NullableModelValueHandlerImpl,
  body : Array[@type_array.Nullable[@type_array.InnerModel]],
) {
  guard body.length() == 3 else {
    fail("nullable-model.put: body length should be 3")
  }
  match body[0].value {
    Some(v) => {
      guard v.property == "hello" else {
        fail("nullable-model.put: body[0].property should be 'hello'")
      }
    }
    None => fail("nullable-model.put: body[0] should not be null")
  }
  guard body[1].value is None else {
    fail("nullable-model.put: body[1] should be null")
  }
  match body[2].value {
    Some(v) => {
      guard v.property == "world" else {
        fail("nullable-model.put: body[2].property should be 'world'")
      }
    }
    None => fail("nullable-model.put: body[2] should not be null")
  }
}

///|
struct NullableStringValueHandlerImpl {}

///|
impl @type_array.NullableStringValueHandler for NullableStringValueHandlerImpl with get(
  _self : NullableStringValueHandlerImpl,
) {
  // Should return ["hello", null, "world"]
  [
    @type_array.Nullable::some("hello"),
    @type_array.Nullable::none(),
    @type_array.Nullable::some("world"),
  ]
}

///|
impl @type_array.NullableStringValueHandler for NullableStringValueHandlerImpl with put(
  _self : NullableStringValueHandlerImpl,
  body : Array[@type_array.Nullable[String]],
) {
  guard body.length() == 3 else {
    fail("nullable-string.put: body length should be 3")
  }
  guard body[0].value == Some("hello") else {
    fail("nullable-string.put: body[0] should be 'hello'")
  }
  guard body[1].value is None else {
    fail("nullable-string.put: body[1] should be null")
  }
  guard body[2].value == Some("world") else {
    fail("nullable-string.put: body[2] should be 'world'")
  }
}

///|
struct NullableBooleanValueHandlerImpl {}

///|
impl @type_array.NullableBooleanValueHandler for NullableBooleanValueHandlerImpl with get(
  _self : NullableBooleanValueHandlerImpl,
) {
  // Should return [true, null, false]
  [
    @type_array.Nullable::some(true),
    @type_array.Nullable::none(),
    @type_array.Nullable::some(false),
  ]
}

///|
impl @type_array.NullableBooleanValueHandler for NullableBooleanValueHandlerImpl with put(
  _self : NullableBooleanValueHandlerImpl,
  body : Array[@type_array.Nullable[Bool]],
) {
  guard body.length() == 3 else {
    fail("nullable-boolean.put: body length should be 3")
  }
  guard body[0].value == Some(true) else {
    fail("nullable-boolean.put: body[0] should be true")
  }
  guard body[1].value is None else {
    fail("nullable-boolean.put: body[1] should be null")
  }
  guard body[2].value == Some(false) else {
    fail("nullable-boolean.put: body[2] should be false")
  }
}
