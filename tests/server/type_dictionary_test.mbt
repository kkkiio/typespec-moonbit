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
  @async.with_task_group(fn(group) {
    let router = @type_dictionary.create_router(
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
      recursive_model_value_handler=recursive_model_handler,
      group~,
    )
    let dispatch = @type_dictionary.create_dispatch(router)
    let base_url = @server.start_server(group, dispatch)
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
  _self,
  group~,
) {
  ignore(group)
  // Should return { k1: 1, k2: 2 }
  { "k1": 1, "k2": 2 }
}

///|
impl @type_dictionary.Int32ValueHandler for DictInt32ValueHandlerImpl with put(
  _self,
  group~,
  body,
) {
  ignore(group)
  assert_eq(body.length(), 2)
  assert_eq(body.get("k1"), Some(1))
  assert_eq(body.get("k2"), Some(2))
}

///|
struct DictInt64ValueHandlerImpl {}

///|
impl @type_dictionary.Int64ValueHandler for DictInt64ValueHandlerImpl with get(
  _self,
  group~,
) {
  ignore(group)
  // Should return { k1: 0x7fffffffffffffff, k2: -0x7fffffffffffffff }
  { "k1": 0x7fffffffffffffffL, "k2": -0x7fffffffffffffffL }
}

///|
impl @type_dictionary.Int64ValueHandler for DictInt64ValueHandlerImpl with put(
  _self,
  group~,
  body,
) {
  ignore(group)
  assert_eq(body.length(), 2)
  assert_eq(body.get("k1"), Some(0x7fffffffffffffffL))
  assert_eq(body.get("k2"), Some(-0x7fffffffffffffffL))
}

///|
struct DictModelValueHandlerImpl {}

///|
impl @type_dictionary.ModelValueHandler for DictModelValueHandlerImpl with get(
  _self,
  group~,
) {
  ignore(group)
  // Should return { k1: { property: "hello" }, k2: { property: "world" } }
  {
    "k1": { property: "hello", children: None },
    "k2": { property: "world", children: None },
  }
}

///|
impl @type_dictionary.ModelValueHandler for DictModelValueHandlerImpl with put(
  _self,
  group~,
  body,
) {
  ignore(group)
  assert_eq(body.length(), 2)
  match body.get("k1") {
    Some(v) => assert_eq(v.property, "hello")
    None => assert_true(false, msg="model.put: missing key k1")
  }
  match body.get("k2") {
    Some(v) => assert_eq(v.property, "world")
    None => assert_true(false, msg="model.put: missing key k2")
  }
}

///|
struct DictStringValueHandlerImpl {}

///|
impl @type_dictionary.StringValueHandler for DictStringValueHandlerImpl with get(
  _self,
  group~,
) {
  ignore(group)
  // Should return { k1: "hello", k2: "" }
  { "k1": "hello", "k2": "" }
}

///|
impl @type_dictionary.StringValueHandler for DictStringValueHandlerImpl with put(
  _self,
  group~,
  body,
) {
  ignore(group)
  assert_eq(body.length(), 2)
  assert_eq(body.get("k1"), Some("hello"))
  assert_eq(body.get("k2"), Some(""))
}

///|
struct DictBooleanValueHandlerImpl {}

///|
impl @type_dictionary.BooleanValueHandler for DictBooleanValueHandlerImpl with get(
  _self,
  group~,
) {
  ignore(group)
  // Should return { k1: true, k2: false }
  { "k1": true, "k2": false }
}

///|
impl @type_dictionary.BooleanValueHandler for DictBooleanValueHandlerImpl with put(
  _self,
  group~,
  body,
) {
  ignore(group)
  assert_eq(body.length(), 2)
  assert_eq(body.get("k1"), Some(true))
  assert_eq(body.get("k2"), Some(false))
}

///|
struct DictFloat32ValueHandlerImpl {}

///|
impl @type_dictionary.Float32ValueHandler for DictFloat32ValueHandlerImpl with get(
  _self,
  group~,
) {
  ignore(group)
  // Should return { k1: 43.125 }
  { "k1": 43.125 }
}

///|
impl @type_dictionary.Float32ValueHandler for DictFloat32ValueHandlerImpl with put(
  _self,
  group~,
  body,
) {
  ignore(group)
  assert_eq(body.length(), 1)
  assert_eq(body.get("k1"), Some(43.125))
}

///|
struct DictUnknownValueHandlerImpl {}

///|
impl @type_dictionary.UnknownValueHandler for DictUnknownValueHandlerImpl with get(
  _self,
  group~,
) {
  ignore(group)
  // Should return { k1: 1, k2: "hello", k3: null }
  {
    "k1": Json::number(1.0, repr="1"),
    "k2": Json::string("hello"),
    "k3": Json::null(),
  }
}

///|
impl @type_dictionary.UnknownValueHandler for DictUnknownValueHandlerImpl with put(
  _self,
  group~,
  body,
) {
  ignore(group)
  assert_eq(body.length(), 3)
  match body.get("k1") {
    Some(v) => assert_eq(v.stringify(), "1")
    None => assert_true(false, msg="unknown.put: missing key k1")
  }
  match body.get("k2") {
    Some(v) => assert_eq(v.stringify(), "\"hello\"")
    None => assert_true(false, msg="unknown.put: missing key k2")
  }
  match body.get("k3") {
    Some(v) => assert_eq(v.stringify(), "null")
    None => assert_true(false, msg="unknown.put: missing key k3")
  }
}

///|
struct DictDatetimeValueHandlerImpl {}

///|
impl @type_dictionary.DatetimeValueHandler for DictDatetimeValueHandlerImpl with get(
  _self,
  group~,
) {
  ignore(group)
  // Should return { k1: Temporal.Instant.from("2022-08-26T18:38:00Z") }
  { "k1": "2022-08-26T18:38:00Z" }
}

///|
impl @type_dictionary.DatetimeValueHandler for DictDatetimeValueHandlerImpl with put(
  _self,
  group~,
  body,
) {
  ignore(group)
  assert_eq(body.length(), 1)
  assert_eq(body.get("k1"), Some("2022-08-26T18:38:00Z"))
}

///|
struct DictDurationValueHandlerImpl {}

///|
impl @type_dictionary.DurationValueHandler for DictDurationValueHandlerImpl with get(
  _self,
  group~,
) {
  ignore(group)
  // Should return { k1: Temporal.Duration.from("P123DT22H14M12.011S") }
  { "k1": "P123DT22H14M12.011S" }
}

///|
impl @type_dictionary.DurationValueHandler for DictDurationValueHandlerImpl with put(
  _self,
  group~,
  body,
) {
  ignore(group)
  assert_eq(body.length(), 1)
  assert_eq(body.get("k1"), Some("P123DT22H14M12.011S"))
}

///|
struct DictNullableFloatValueHandlerImpl {}

///|
impl @type_dictionary.NullableFloatValueHandler for DictNullableFloatValueHandlerImpl with get(
  _self,
  group~,
) {
  ignore(group)
  // Should return { k1: 1.25, k2: 0.5, k3: null }
  {
    "k1": @runtime.Nullable(Some(1.25)),
    "k2": @runtime.Nullable(Some(0.5)),
    "k3": @runtime.Nullable(None),
  }
}

///|
impl @type_dictionary.NullableFloatValueHandler for DictNullableFloatValueHandlerImpl with put(
  _self,
  group~,
  body,
) {
  ignore(group)
  assert_eq(body.length(), 3)
  match body.get("k1") {
    Some(v) => assert_eq(v, @runtime.Nullable(Some(1.25)))
    None => assert_true(false, msg="nullable-float.put: missing key k1")
  }
  match body.get("k2") {
    Some(v) => assert_eq(v, @runtime.Nullable(Some(0.5)))
    None => assert_true(false, msg="nullable-float.put: missing key k2")
  }
  match body.get("k3") {
    Some(v) => assert_eq(v, @runtime.Nullable(None))
    None => assert_true(false, msg="nullable-float.put: missing key k3")
  }
}

///|
struct DictRecursiveModelValueHandlerImpl {}

///|
impl @type_dictionary.RecursiveModelValueHandler for DictRecursiveModelValueHandlerImpl with get(
  _self,
  group~,
) {
  ignore(group)
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
  let k1_children : Map[String, @type_dictionary.InnerModel] = Map::new()
  let k2_1 : @type_dictionary.InnerModel = {
    property: "inner world",
    children: None,
  }
  let k2_children : Map[String, @type_dictionary.InnerModel] = { "k2.1": k2_1 }
  {
    "k1": { property: "hello", children: Some(k1_children) },
    "k2": { property: "world", children: Some(k2_children) },
  }
}

///|
impl @type_dictionary.RecursiveModelValueHandler for DictRecursiveModelValueHandlerImpl with put(
  _self,
  group~,
  body,
) {
  ignore(group)
  assert_eq(body.length(), 2)
  match body.get("k1") {
    Some(v) => {
      assert_eq(v.property, "hello")
      match v.children {
        Some(children) => assert_eq(children.length(), 0)
        None =>
          assert_true(
            false,
            msg="recursive-model.put: body.k1.children should exist",
          )
      }
    }
    None => assert_true(false, msg="recursive-model.put: missing key k1")
  }
  match body.get("k2") {
    Some(v) => {
      assert_eq(v.property, "world")
      match v.children {
        Some(children) => {
          assert_eq(children.length(), 1)
          match children.get("k2.1") {
            Some(inner) => assert_eq(inner.property, "inner world")
            None =>
              assert_true(
                false,
                msg="recursive-model.put: missing key body.k2.children['k2.1']",
              )
          }
        }
        None =>
          assert_true(
            false,
            msg="recursive-model.put: body.k2.children should exist",
          )
      }
    }
    None => assert_true(false, msg="recursive-model.put: missing key k2")
  }
}
