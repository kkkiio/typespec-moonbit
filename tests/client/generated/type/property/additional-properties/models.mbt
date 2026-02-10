///|

///|
/// Union Union0
pub(all) enum Union0 {
  String(String)
  Float32(Double)
} derive(Show)

///|
pub impl ToJson for Union0 with to_json(self : Union0) -> Json {
  match self {
    String(v) => v.to_json()
    Float32(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for Union0 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Union0 raise {
  let try_0 : Result[String, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return String(v)
  }
  let try_1 : Result[Double, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return Float32(v)
  }
  raise @json.JsonDecodeError((path, "cannot deserialize json as union Union0"))
}

///|

///|
/// Union Union1
pub(all) enum Union1 {
  String(String)
  Float32(Double)
} derive(Show)

///|
pub impl ToJson for Union1 with to_json(self : Union1) -> Json {
  match self {
    String(v) => v.to_json()
    Float32(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for Union1 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Union1 raise {
  let try_0 : Result[String, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return String(v)
  }
  let try_1 : Result[Double, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return Float32(v)
  }
  raise @json.JsonDecodeError((path, "cannot deserialize json as union Union1"))
}

///|

///|
/// Union Union2
pub(all) enum Union2 {
  WidgetData0(WidgetData0)
  WidgetData1(WidgetData1)
} derive(Show)

///|
pub impl ToJson for Union2 with to_json(self : Union2) -> Json {
  match self {
    WidgetData0(v) => v.to_json()
    WidgetData1(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for Union2 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Union2 raise {
  let try_0 : Result[WidgetData0, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return WidgetData0(v)
  }
  let try_1 : Result[WidgetData1, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return WidgetData1(v)
  }
  raise @json.JsonDecodeError((path, "cannot deserialize json as union Union2"))
}

///|

///|
/// Union Union3
pub(all) enum Union3 {
  WidgetData2(WidgetData2)
  WidgetData1(WidgetData1)
} derive(Show)

///|
pub impl ToJson for Union3 with to_json(self : Union3) -> Json {
  match self {
    WidgetData2(v) => v.to_json()
    WidgetData1(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for Union3 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Union3 raise {
  let try_0 : Result[WidgetData2, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return WidgetData2(v)
  }
  let try_1 : Result[WidgetData1, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return WidgetData1(v)
  }
  raise @json.JsonDecodeError((path, "cannot deserialize json as union Union3"))
}

///|

///|
/// Union Union4
pub(all) enum Union4 {
  Array(Array[WidgetData2])
  WidgetData1(WidgetData1)
} derive(Show)

///|
pub impl ToJson for Union4 with to_json(self : Union4) -> Json {
  match self {
    Array(v) => v.to_json()
    WidgetData1(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for Union4 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Union4 raise {
  let try_0 : Result[Array[WidgetData2], @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return Array(v)
  }
  let try_1 : Result[WidgetData1, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return WidgetData1(v)
  }
  raise @json.JsonDecodeError((path, "cannot deserialize json as union Union4"))
}

///|

///|
/// Model WidgetData0
pub(all) struct WidgetData0 {
  kind : String
  foo_prop : String
} derive (
  Show,
  ToJson(fields(foo_prop(rename="fooProp"))),
  @json.FromJson(fields(foo_prop(rename="fooProp"))),
)

///|

///|
/// Model WidgetData1
pub(all) struct WidgetData1 {
  kind : String
  start : String
  end : String?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model WidgetData2
pub(all) struct WidgetData2 {
  kind : String
  start : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model ModelForRecord
pub(all) struct ModelForRecord {
  state : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model DifferentSpreadFloatDerived
pub(all) struct DifferentSpreadFloatDerived {
  name : String
  derived_prop : Double
} derive (
  Show,
  ToJson(fields(derived_prop(rename="derivedProp"))),
  @json.FromJson(fields(derived_prop(rename="derivedProp"))),
)

///|

///|
/// Model DifferentSpreadModelDerived
pub(all) struct DifferentSpreadModelDerived {
  known_prop : String
  derived_prop : ModelForRecord
} derive (
  Show,
  ToJson(
    fields(known_prop(rename="knownProp"), derived_prop(rename="derivedProp")),
  ),
  @json.FromJson(
    fields(known_prop(rename="knownProp"), derived_prop(rename="derivedProp")),
  ),
)

///|

///|
/// Model DifferentSpreadStringDerived
pub(all) struct DifferentSpreadStringDerived {
  id : Double
  derived_prop : String
} derive (
  Show,
  ToJson(fields(derived_prop(rename="derivedProp"))),
  @json.FromJson(fields(derived_prop(rename="derivedProp"))),
)

///|

///|
/// Model DifferentSpreadModelArrayDerived
pub(all) struct DifferentSpreadModelArrayDerived {
  known_prop : String
  derived_prop : Array[ModelForRecord]
} derive (
  Show,
  ToJson(
    fields(known_prop(rename="knownProp"), derived_prop(rename="derivedProp")),
  ),
  @json.FromJson(
    fields(known_prop(rename="knownProp"), derived_prop(rename="derivedProp")),
  ),
)

///|

///|
/// Model ExtendsFloatAdditionalProperties
pub(all) struct ExtendsFloatAdditionalProperties {
  id : Double
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model ExtendsModelAdditionalProperties
pub(all) struct ExtendsModelAdditionalProperties {
  known_prop : ModelForRecord
} derive (
  Show,
  ToJson(fields(known_prop(rename="knownProp"))),
  @json.FromJson(fields(known_prop(rename="knownProp"))),
)

///|

///|
/// Model ExtendsStringAdditionalProperties
pub(all) struct ExtendsStringAdditionalProperties {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model ExtendsUnknownAdditionalProperties
pub(all) struct ExtendsUnknownAdditionalProperties {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model IsUnknownAdditionalPropertiesDerived
pub(all) struct IsUnknownAdditionalPropertiesDerived {
  name : String
  index : Int
  age : Double?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model ExtendsModelArrayAdditionalProperties
pub(all) struct ExtendsModelArrayAdditionalProperties {
  known_prop : Array[ModelForRecord]
} derive (
  Show,
  ToJson(fields(known_prop(rename="knownProp"))),
  @json.FromJson(fields(known_prop(rename="knownProp"))),
)

///|

///|
/// Model ExtendsUnknownAdditionalPropertiesDerived
pub(all) struct ExtendsUnknownAdditionalPropertiesDerived {
  name : String
  index : Int
  age : Double?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model ExtendsUnknownAdditionalPropertiesDiscriminated
pub(all) struct ExtendsUnknownAdditionalPropertiesDiscriminated {
  name : String
  kind : String
} derive(Show, ToJson, @json.FromJson)
