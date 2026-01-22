///|
/// Test for type/dictionary
/// Reference: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/dictionary/main.test.e2e.ts
async test "type/dictionary" {
  let int32_handler = DictInt32ValueHandlerImpl::{  }
  let int64_handler = DictInt64ValueHandlerImpl::{  }
  let model_handler = DictModelValueHandlerImpl::{  }
  let string_handler = DictStringValueHandlerImpl::{  }
  let boolean_handler = DictBooleanValueHandlerImpl::{  }
  let float32_handler = DictFloat32ValueHandlerImpl::{  }
  let unknown_handler = DictUnknownValueHandlerImpl::{  }
  let datetime_handler = DictDatetimeValueHandlerImpl::{  }
  let duration_handler = DictDurationValueHandlerImpl::{  }
  let nullable_float_handler = DictNullableFloatValueHandlerImpl::{  }
  let recursive_model_handler = DictRecursiveModelValueHandlerImpl::{  }
  let router = @type_dictionary.create_router(
    int32_handler, int64_handler, model_handler, string_handler, boolean_handler,
    float32_handler, unknown_handler, datetime_handler, duration_handler, nullable_float_handler,
    recursive_model_handler,
  )
  @async.with_task_group(fn(group) {
    let base_url = @server.start_server(group, router)
    // Skip int64 value scenarios
    let status = @server.run_scenario(
      "type/dictionary/!(int64value)*/*", base_url,
    )
    assert_true(status is @server.Status::Pass)
  })
}

///|
struct DictInt32ValueHandlerImpl {}

///|
impl @type_dictionary.Int32ValueHandler for DictInt32ValueHandlerImpl with get(
  _self : DictInt32ValueHandlerImpl,
) {
  // Should return { k1: 1, k2: 2 }
}

///|
impl @type_dictionary.Int32ValueHandler for DictInt32ValueHandlerImpl with put(
  _self : DictInt32ValueHandlerImpl,
  _body : @type_dictionary.Record,
) {
  // TODO: verify body == { k1: 1, k2: 2 }
}

///|
struct DictInt64ValueHandlerImpl {}

///|
impl @type_dictionary.Int64ValueHandler for DictInt64ValueHandlerImpl with get(
  _self : DictInt64ValueHandlerImpl,
) {
  // Should return { k1: 0x7fffffffffffffff, k2: -0x7fffffffffffffff }
}

///|
impl @type_dictionary.Int64ValueHandler for DictInt64ValueHandlerImpl with put(
  _self : DictInt64ValueHandlerImpl,
  _body : @type_dictionary.Record,
) {
  // TODO: verify body
}

///|
struct DictModelValueHandlerImpl {}

///|
impl @type_dictionary.ModelValueHandler for DictModelValueHandlerImpl with get(
  _self : DictModelValueHandlerImpl,
) {
  // Should return { k1: { property: "hello" }, k2: { property: "world" } }
}

///|
impl @type_dictionary.ModelValueHandler for DictModelValueHandlerImpl with put(
  _self : DictModelValueHandlerImpl,
  _body : @type_dictionary.Record,
) {
  // TODO: verify body
}

///|
struct DictStringValueHandlerImpl {}

///|
impl @type_dictionary.StringValueHandler for DictStringValueHandlerImpl with get(
  _self : DictStringValueHandlerImpl,
) {
  // Should return { k1: "hello", k2: "" }
}

///|
impl @type_dictionary.StringValueHandler for DictStringValueHandlerImpl with put(
  _self : DictStringValueHandlerImpl,
  _body : @type_dictionary.Record,
) {
  // TODO: verify body == { k1: "hello", k2: "" }
}

///|
struct DictBooleanValueHandlerImpl {}

///|
impl @type_dictionary.BooleanValueHandler for DictBooleanValueHandlerImpl with get(
  _self : DictBooleanValueHandlerImpl,
) {
  // Should return { k1: true, k2: false }
}

///|
impl @type_dictionary.BooleanValueHandler for DictBooleanValueHandlerImpl with put(
  _self : DictBooleanValueHandlerImpl,
  _body : @type_dictionary.Record,
) {
  // TODO: verify body == { k1: true, k2: false }
}

///|
struct DictFloat32ValueHandlerImpl {}

///|
impl @type_dictionary.Float32ValueHandler for DictFloat32ValueHandlerImpl with get(
  _self : DictFloat32ValueHandlerImpl,
) {
  // Should return { k1: 43.125 }
}

///|
impl @type_dictionary.Float32ValueHandler for DictFloat32ValueHandlerImpl with put(
  _self : DictFloat32ValueHandlerImpl,
  _body : @type_dictionary.Record,
) {
  // TODO: verify body
}

///|
struct DictUnknownValueHandlerImpl {}

///|
impl @type_dictionary.UnknownValueHandler for DictUnknownValueHandlerImpl with get(
  _self : DictUnknownValueHandlerImpl,
) {
  // Should return { k1: 1, k2: "hello", k3: null }
}

///|
impl @type_dictionary.UnknownValueHandler for DictUnknownValueHandlerImpl with put(
  _self : DictUnknownValueHandlerImpl,
  _body : @type_dictionary.Record,
) {
  // TODO: verify body
}

///|
struct DictDatetimeValueHandlerImpl {}

///|
impl @type_dictionary.DatetimeValueHandler for DictDatetimeValueHandlerImpl with get(
  _self : DictDatetimeValueHandlerImpl,
) {
  // Should return { k1: Temporal.Instant.from("2022-08-26T18:38:00Z") }
}

///|
impl @type_dictionary.DatetimeValueHandler for DictDatetimeValueHandlerImpl with put(
  _self : DictDatetimeValueHandlerImpl,
  _body : @type_dictionary.Record,
) {
  // TODO: verify body
}

///|
struct DictDurationValueHandlerImpl {}

///|
impl @type_dictionary.DurationValueHandler for DictDurationValueHandlerImpl with get(
  _self : DictDurationValueHandlerImpl,
) {
  // Should return { k1: Temporal.Duration.from("P123DT22H14M12.011S") }
}

///|
impl @type_dictionary.DurationValueHandler for DictDurationValueHandlerImpl with put(
  _self : DictDurationValueHandlerImpl,
  _body : @type_dictionary.Record,
) {
  // TODO: verify body
}

///|
struct DictNullableFloatValueHandlerImpl {}

///|
impl @type_dictionary.NullableFloatValueHandler for DictNullableFloatValueHandlerImpl with get(
  _self : DictNullableFloatValueHandlerImpl,
) {
  // Should return { k1: 1.25, k2: 0.5, k3: null }
}

///|
impl @type_dictionary.NullableFloatValueHandler for DictNullableFloatValueHandlerImpl with put(
  _self : DictNullableFloatValueHandlerImpl,
  _body : @type_dictionary.Record,
) {
  // TODO: verify body
}

///|
struct DictRecursiveModelValueHandlerImpl {}

///|
impl @type_dictionary.RecursiveModelValueHandler for DictRecursiveModelValueHandlerImpl with get(
  _self : DictRecursiveModelValueHandlerImpl,
) {
  // Should return:
  // {
  //   k1: { property: "hello", children: {} },
  //   k2: {
  //     property: "world",
  //     children: {
  //       "k2.1": { property: "inner world" },
  //     },
  //   },
  // }
}

///|
impl @type_dictionary.RecursiveModelValueHandler for DictRecursiveModelValueHandlerImpl with put(
  _self : DictRecursiveModelValueHandlerImpl,
  _body : @type_dictionary.Record,
) {
  // TODO: verify body
}
