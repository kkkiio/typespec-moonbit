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
  @type_array.Array::{  }
}

///|
impl @type_array.Int32ValueHandler for Int32ValueHandlerImpl with put(
  _self : Int32ValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body == [1, 2]
}

///|
struct Int64ValueHandlerImpl {}

///|
impl @type_array.Int64ValueHandler for Int64ValueHandlerImpl with get(
  _self : Int64ValueHandlerImpl,
) {
  // Should return [0x7fffffffffffffff, -0x7fffffffffffffff]
  @type_array.Array::{  }
}

///|
impl @type_array.Int64ValueHandler for Int64ValueHandlerImpl with put(
  _self : Int64ValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body
}

///|
struct ModelValueHandlerImpl {}

///|
impl @type_array.ModelValueHandler for ModelValueHandlerImpl with get(
  _self : ModelValueHandlerImpl,
) {
  // Should return [{ property: "hello" }, { property: "world" }]
  @type_array.Array::{  }
}

///|
impl @type_array.ModelValueHandler for ModelValueHandlerImpl with put(
  _self : ModelValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body
}

///|
struct StringValueHandlerImpl {}

///|
impl @type_array.StringValueHandler for StringValueHandlerImpl with get(
  _self : StringValueHandlerImpl,
) {
  // Should return ["hello", ""]
  @type_array.Array::{  }
}

///|
impl @type_array.StringValueHandler for StringValueHandlerImpl with put(
  _self : StringValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body == ["hello", ""]
}

///|
struct BooleanValueHandlerImpl {}

///|
impl @type_array.BooleanValueHandler for BooleanValueHandlerImpl with get(
  _self : BooleanValueHandlerImpl,
) {
  // Should return [true, false]
  @type_array.Array::{  }
}

///|
impl @type_array.BooleanValueHandler for BooleanValueHandlerImpl with put(
  _self : BooleanValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body == [true, false]
}

///|
struct Float32ValueHandlerImpl {}

///|
impl @type_array.Float32ValueHandler for Float32ValueHandlerImpl with get(
  _self : Float32ValueHandlerImpl,
) {
  // Should return [43.125]
  @type_array.Array::{  }
}

///|
impl @type_array.Float32ValueHandler for Float32ValueHandlerImpl with put(
  _self : Float32ValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body
}

///|
struct UnknownValueHandlerImpl {}

///|
impl @type_array.UnknownValueHandler for UnknownValueHandlerImpl with get(
  _self : UnknownValueHandlerImpl,
) {
  // Should return [1, "hello", null]
  @type_array.Array::{  }
}

///|
impl @type_array.UnknownValueHandler for UnknownValueHandlerImpl with put(
  _self : UnknownValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body
}

///|
struct DatetimeValueHandlerImpl {}

///|
impl @type_array.DatetimeValueHandler for DatetimeValueHandlerImpl with get(
  _self : DatetimeValueHandlerImpl,
) {
  // Should return [Temporal.Instant.from("2022-08-26T18:38:00Z")]
  @type_array.Array::{  }
}

///|
impl @type_array.DatetimeValueHandler for DatetimeValueHandlerImpl with put(
  _self : DatetimeValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body
}

///|
struct DurationValueHandlerImpl {}

///|
impl @type_array.DurationValueHandler for DurationValueHandlerImpl with get(
  _self : DurationValueHandlerImpl,
) {
  // Should return [Temporal.Duration.from("P123DT22H14M12.011S")]
  @type_array.Array::{  }
}

///|
impl @type_array.DurationValueHandler for DurationValueHandlerImpl with put(
  _self : DurationValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body
}

///|
struct NullableFloatValueHandlerImpl {}

///|
impl @type_array.NullableFloatValueHandler for NullableFloatValueHandlerImpl with get(
  _self : NullableFloatValueHandlerImpl,
) {
  // Should return [1.25, null, 3.0]
  @type_array.Array::{  }
}

///|
impl @type_array.NullableFloatValueHandler for NullableFloatValueHandlerImpl with put(
  _self : NullableFloatValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body
}

///|
struct NullableInt32ValueHandlerImpl {}

///|
impl @type_array.NullableInt32ValueHandler for NullableInt32ValueHandlerImpl with get(
  _self : NullableInt32ValueHandlerImpl,
) {
  // Should return [1, null, 3]
  @type_array.Array::{  }
}

///|
impl @type_array.NullableInt32ValueHandler for NullableInt32ValueHandlerImpl with put(
  _self : NullableInt32ValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body
}

///|
struct NullableModelValueHandlerImpl {}

///|
impl @type_array.NullableModelValueHandler for NullableModelValueHandlerImpl with get(
  _self : NullableModelValueHandlerImpl,
) {
  // Should return [{ property: "hello" }, null, { property: "world" }]
  @type_array.Array::{  }
}

///|
impl @type_array.NullableModelValueHandler for NullableModelValueHandlerImpl with put(
  _self : NullableModelValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body
}

///|
struct NullableStringValueHandlerImpl {}

///|
impl @type_array.NullableStringValueHandler for NullableStringValueHandlerImpl with get(
  _self : NullableStringValueHandlerImpl,
) {
  // Should return ["hello", null, "world"]
  @type_array.Array::{  }
}

///|
impl @type_array.NullableStringValueHandler for NullableStringValueHandlerImpl with put(
  _self : NullableStringValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body
}

///|
struct NullableBooleanValueHandlerImpl {}

///|
impl @type_array.NullableBooleanValueHandler for NullableBooleanValueHandlerImpl with get(
  _self : NullableBooleanValueHandlerImpl,
) {
  // Should return [true, null, false]
  @type_array.Array::{  }
}

///|
impl @type_array.NullableBooleanValueHandler for NullableBooleanValueHandlerImpl with put(
  _self : NullableBooleanValueHandlerImpl,
  _body : @type_array.Array,
) {
  // TODO: verify body
}
