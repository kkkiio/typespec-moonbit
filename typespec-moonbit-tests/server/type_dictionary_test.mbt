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
  _self,
) {
  // Should return { k1: 1, k2: 2 }
  { "k1": 1, "k2": 2 }
}

///|
impl @type_dictionary.Int32ValueHandler for DictInt32ValueHandlerImpl with put(
  _self,
  body,
) {
  guard body.length() == 2 else { fail("int32.put: body length should be 2") }
  guard body.get("k1") == Some(1) else {
    fail("int32.put: body.k1 should be 1")
  }
  guard body.get("k2") == Some(2) else {
    fail("int32.put: body.k2 should be 2")
  }
}

///|
struct DictInt64ValueHandlerImpl {}

///|
impl @type_dictionary.Int64ValueHandler for DictInt64ValueHandlerImpl with get(
  _self,
) {
  // Should return { k1: 0x7fffffffffffffff, k2: -0x7fffffffffffffff }
  { "k1": 0x7fffffffffffffffL, "k2": -0x7fffffffffffffffL }
}

///|
impl @type_dictionary.Int64ValueHandler for DictInt64ValueHandlerImpl with put(
  _self,
  body,
) {
  guard body.length() == 2 else { fail("int64.put: body length should be 2") }
  guard body.get("k1") == Some(0x7fffffffffffffffL) else {
    fail("int64.put: body.k1 should be max int64")
  }
  guard body.get("k2") == Some(-0x7fffffffffffffffL) else {
    fail("int64.put: body.k2 should be min int64")
  }
}

///|
struct DictModelValueHandlerImpl {}

///|
impl @type_dictionary.ModelValueHandler for DictModelValueHandlerImpl with get(
  _self,
) {
  // Should return { k1: { property: "hello" }, k2: { property: "world" } }
  {
    "k1": { property: "hello", children: None },
    "k2": { property: "world", children: None },
  }
}

///|
impl @type_dictionary.ModelValueHandler for DictModelValueHandlerImpl with put(
  _self,
  body,
) {
  guard body.length() == 2 else { fail("model.put: body length should be 2") }
  match body.get("k1") {
    Some(v) => {
      guard v.property == "hello" else {
        fail("model.put: body.k1.property should be 'hello'")
      }
    }
    None => fail("model.put: missing key k1")
  }
  match body.get("k2") {
    Some(v) => {
      guard v.property == "world" else {
        fail("model.put: body.k2.property should be 'world'")
      }
    }
    None => fail("model.put: missing key k2")
  }
}

///|
struct DictStringValueHandlerImpl {}

///|
impl @type_dictionary.StringValueHandler for DictStringValueHandlerImpl with get(
  _self,
) {
  // Should return { k1: "hello", k2: "" }
  { "k1": "hello", "k2": "" }
}

///|
impl @type_dictionary.StringValueHandler for DictStringValueHandlerImpl with put(
  _self,
  body,
) {
  guard body.length() == 2 else { fail("string.put: body length should be 2") }
  guard body.get("k1") == Some("hello") else {
    fail("string.put: body.k1 should be 'hello'")
  }
  guard body.get("k2") == Some("") else {
    fail("string.put: body.k2 should be ''")
  }
}

///|
struct DictBooleanValueHandlerImpl {}

///|
impl @type_dictionary.BooleanValueHandler for DictBooleanValueHandlerImpl with get(
  _self,
) {
  // Should return { k1: true, k2: false }
  { "k1": true, "k2": false }
}

///|
impl @type_dictionary.BooleanValueHandler for DictBooleanValueHandlerImpl with put(
  _self,
  body,
) {
  guard body.length() == 2 else { fail("boolean.put: body length should be 2") }
  guard body.get("k1") == Some(true) else {
    fail("boolean.put: body.k1 should be true")
  }
  guard body.get("k2") == Some(false) else {
    fail("boolean.put: body.k2 should be false")
  }
}

///|
struct DictFloat32ValueHandlerImpl {}

///|
impl @type_dictionary.Float32ValueHandler for DictFloat32ValueHandlerImpl with get(
  _self,
) {
  // Should return { k1: 43.125 }
  { "k1": 43.125 }
}

///|
impl @type_dictionary.Float32ValueHandler for DictFloat32ValueHandlerImpl with put(
  _self,
  body,
) {
  guard body.length() == 1 else { fail("float32.put: body length should be 1") }
  guard body.get("k1") == Some(43.125) else {
    fail("float32.put: body.k1 should be 43.125")
  }
}

///|
struct DictUnknownValueHandlerImpl {}

///|
impl @type_dictionary.UnknownValueHandler for DictUnknownValueHandlerImpl with get(
  _self,
) {
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
  body,
) {
  guard body.length() == 3 else { fail("unknown.put: body length should be 3") }
  match body.get("k1") {
    Some(v) => {
      guard v.stringify() == "1" else {
        fail("unknown.put: body.k1 should be 1")
      }
    }
    None => fail("unknown.put: missing key k1")
  }
  match body.get("k2") {
    Some(v) => {
      guard v.stringify() == "\"hello\"" else {
        fail("unknown.put: body.k2 should be 'hello'")
      }
    }
    None => fail("unknown.put: missing key k2")
  }
  match body.get("k3") {
    Some(v) => {
      guard v.stringify() == "null" else {
        fail("unknown.put: body.k3 should be null")
      }
    }
    None => fail("unknown.put: missing key k3")
  }
}

///|
struct DictDatetimeValueHandlerImpl {}

///|
impl @type_dictionary.DatetimeValueHandler for DictDatetimeValueHandlerImpl with get(
  _self,
) {
  // Should return { k1: Temporal.Instant.from("2022-08-26T18:38:00Z") }
  { "k1": "2022-08-26T18:38:00Z" }
}

///|
impl @type_dictionary.DatetimeValueHandler for DictDatetimeValueHandlerImpl with put(
  _self,
  body,
) {
  guard body.length() == 1 else {
    fail("datetime.put: body length should be 1")
  }
  guard body.get("k1") == Some("2022-08-26T18:38:00Z") else {
    fail("datetime.put: body.k1 should be '2022-08-26T18:38:00Z'")
  }
}

///|
struct DictDurationValueHandlerImpl {}

///|
impl @type_dictionary.DurationValueHandler for DictDurationValueHandlerImpl with get(
  _self,
) {
  // Should return { k1: Temporal.Duration.from("P123DT22H14M12.011S") }
  { "k1": "P123DT22H14M12.011S" }
}

///|
impl @type_dictionary.DurationValueHandler for DictDurationValueHandlerImpl with put(
  _self,
  body,
) {
  guard body.length() == 1 else {
    fail("duration.put: body length should be 1")
  }
  guard body.get("k1") == Some("P123DT22H14M12.011S") else {
    fail("duration.put: body.k1 should be 'P123DT22H14M12.011S'")
  }
}

///|
struct DictNullableFloatValueHandlerImpl {}

///|
impl @type_dictionary.NullableFloatValueHandler for DictNullableFloatValueHandlerImpl with get(
  _self,
) {
  // Should return { k1: 1.25, k2: 0.5, k3: null }
  {
    "k1": @type_dictionary.Nullable::some(1.25),
    "k2": @type_dictionary.Nullable::some(0.5),
    "k3": @type_dictionary.Nullable::none(),
  }
}

///|
impl @type_dictionary.NullableFloatValueHandler for DictNullableFloatValueHandlerImpl with put(
  _self,
  body,
) {
  guard body.length() == 3 else {
    fail("nullable-float.put: body length should be 3")
  }
  match body.get("k1") {
    Some(v) => {
      guard v.value == Some(1.25) else {
        fail("nullable-float.put: body.k1 should be 1.25")
      }
    }
    None => fail("nullable-float.put: missing key k1")
  }
  match body.get("k2") {
    Some(v) => {
      guard v.value == Some(0.5) else {
        fail("nullable-float.put: body.k2 should be 0.5")
      }
    }
    None => fail("nullable-float.put: missing key k2")
  }
  match body.get("k3") {
    Some(v) => {
      guard v.value is None else {
        fail("nullable-float.put: body.k3 should be null")
      }
    }
    None => fail("nullable-float.put: missing key k3")
  }
}

///|
struct DictRecursiveModelValueHandlerImpl {}

///|
impl @type_dictionary.RecursiveModelValueHandler for DictRecursiveModelValueHandlerImpl with get(
  _self,
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
  body,
) {
  guard body.length() == 2 else {
    fail("recursive-model.put: body length should be 2")
  }
  match body.get("k1") {
    Some(v) => {
      guard v.property == "hello" else {
        fail("recursive-model.put: body.k1.property should be 'hello'")
      }
      match v.children {
        Some(children) => {
          guard children.length() == 0 else {
            fail("recursive-model.put: body.k1.children should be {}")
          }
        }
        None => fail("recursive-model.put: body.k1.children should exist")
      }
    }
    None => fail("recursive-model.put: missing key k1")
  }
  match body.get("k2") {
    Some(v) => {
      guard v.property == "world" else {
        fail("recursive-model.put: body.k2.property should be 'world'")
      }
      match v.children {
        Some(children) => {
          guard children.length() == 1 else {
            fail("recursive-model.put: body.k2.children length should be 1")
          }
          match children.get("k2.1") {
            Some(inner) => {
              guard inner.property == "inner world" else {
                fail(
                  "recursive-model.put: body.k2.children['k2.1'].property should be 'inner world'",
                )
              }
            }
            None =>
              fail("recursive-model.put: missing key body.k2.children['k2.1']")
          }
        }
        None => fail("recursive-model.put: body.k2.children should exist")
      }
    }
    None => fail("recursive-model.put: missing key k2")
  }
}
