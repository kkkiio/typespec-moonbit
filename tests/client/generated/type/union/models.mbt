///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Union Union0
pub(all) enum Union0 {
  Lr(Json)
  Ud(Json)
} derive(Show)

///|
pub impl ToJson for Union0 with to_json(self : Union0) -> Json {
  match self {
    Lr(v) => v.to_json()
    Ud(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for Union0 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Union0 raise {
  let try_0 : Result[Json, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return Lr(v)
  }
  let try_1 : Result[Json, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return Ud(v)
  }
  raise @json.JsonDecodeError((path, "cannot deserialize json as union Union0"))
}

///|

///|
/// Union Union1
pub(all) enum Union1 {
  Ud(Json)
  Ud2(Json)
} derive(Show)

///|
pub impl ToJson for Union1 with to_json(self : Union1) -> Json {
  match self {
    Ud(v) => v.to_json()
    Ud2(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for Union1 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Union1 raise {
  let try_0 : Result[Json, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return Ud(v)
  }
  let try_1 : Result[Json, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return Ud2(v)
  }
  raise @json.JsonDecodeError((path, "cannot deserialize json as union Union1"))
}

///|

///|
/// Union Union2
pub(all) enum Union2 {
  Cat(Cat)
  Variant(String)
  Int32(Int)
  Boolean(Bool)
} derive(Show)

///|
pub impl ToJson for Union2 with to_json(self : Union2) -> Json {
  match self {
    Cat(v) => v.to_json()
    Variant(v) => v.to_json()
    Int32(v) => v.to_json()
    Boolean(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for Union2 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Union2 raise {
  let try_0 : Result[Cat, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return Cat(v)
  }
  let try_1 : Result[String, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return Variant(v)
  }
  let try_2 : Result[Int, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_2 is Ok(v) {
    return Int32(v)
  }
  let try_3 : Result[Bool, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_3 is Ok(v) {
    return Boolean(v)
  }
  raise @json.JsonDecodeError((path, "cannot deserialize json as union Union2"))
}

///|

///|
/// Union Union3
pub(all) enum Union3 {
  Cat(Cat)
  Dog(Dog)
} derive(Show)

///|
pub impl ToJson for Union3 with to_json(self : Union3) -> Json {
  match self {
    Cat(v) => v.to_json()
    Dog(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for Union3 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Union3 raise {
  let try_0 : Result[Cat, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return Cat(v)
  }
  let try_1 : Result[Dog, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return Dog(v)
  }
  raise @json.JsonDecodeError((path, "cannot deserialize json as union Union3"))
}

///|

///|
/// Union Union4
pub(all) enum Union4 {
  Variant(String)
  Variant2(Double)
  Variant3(Double)
  Variant4(Bool)
} derive(Show)

///|
pub impl ToJson for Union4 with to_json(self : Union4) -> Json {
  match self {
    Variant(v) => v.to_json()
    Variant2(v) => v.to_json()
    Variant3(v) => v.to_json()
    Variant4(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for Union4 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Union4 raise {
  let try_0 : Result[String, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return Variant(v)
  }
  let try_1 : Result[Double, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return Variant2(v)
  }
  let try_2 : Result[Double, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_2 is Ok(v) {
    return Variant3(v)
  }
  let try_3 : Result[Bool, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_3 is Ok(v) {
    return Variant4(v)
  }
  raise @json.JsonDecodeError((path, "cannot deserialize json as union Union4"))
}

///|

///|
/// Union Union5
pub(all) enum Union5 {
  String(String)
  Array(Array[String])
} derive(Show)

///|
pub impl ToJson for Union5 with to_json(self : Union5) -> Json {
  match self {
    String(v) => v.to_json()
    Array(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for Union5 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Union5 raise {
  let try_0 : Result[String, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return String(v)
  }
  let try_1 : Result[Array[String], @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return Array(v)
  }
  raise @json.JsonDecodeError((path, "cannot deserialize json as union Union5"))
}

///|

///|
/// Union Union6
pub(all) enum Union6 {
  String(String)
  Array(Array[String])
} derive(Show)

///|
pub impl ToJson for Union6 with to_json(self : Union6) -> Json {
  match self {
    String(v) => v.to_json()
    Array(v) => v.to_json()
  }
}

///|
pub impl @json.FromJson for Union6 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Union6 raise {
  let try_0 : Result[String, @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_0 is Ok(v) {
    return String(v)
  }
  let try_1 : Result[Array[String], @json.JsonDecodeError] = try? @json.FromJson::from_json(
    json, path,
  )
  if try_1 is Ok(v) {
    return Array(v)
  }
  raise @json.JsonDecodeError((path, "cannot deserialize json as union Union6"))
}

///|

///|
/// Model Cat
pub(all) struct Cat {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Dog
pub(all) struct Dog {
  bark : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model0
pub(all) struct Model0 {
  prop : Double
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model1
pub(all) struct Model1 {
  prop : EnumsOnlyCases
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model2
pub(all) struct Model2 {
  prop : Double
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model3
pub(all) struct Model3 {
  prop : EnumsOnlyCases
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model4
pub(all) struct Model4 {
  prop : MixedTypesCases
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model5
pub(all) struct Model5 {
  prop : Double
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model6
pub(all) struct Model6 {
  prop : Union3
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model7
pub(all) struct Model7 {
  prop : Double
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model8
pub(all) struct Model8 {
  prop : MixedTypesCases
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model9
pub(all) struct Model9 {
  prop : Union3
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model10
pub(all) struct Model10 {
  prop : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model11
pub(all) struct Model11 {
  prop : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model12
pub(all) struct Model12 {
  prop : MixedLiteralsCases
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model13
pub(all) struct Model13 {
  prop : MixedLiteralsCases
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model14
pub(all) struct Model14 {
  prop : StringAndArrayCases
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model15
pub(all) struct Model15 {
  prop : StringAndArrayCases
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model16
pub(all) struct Model16 {
  prop : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model17
pub(all) struct Model17 {
  prop : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model18
pub(all) struct Model18 {
  prop : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model19
pub(all) struct Model19 {
  prop : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model EnumsOnlyCases
pub(all) struct EnumsOnlyCases {
  lr : Union0
  ud : Union1
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model MixedTypesCases
pub(all) struct MixedTypesCases {
  model : Union2
  literal : Union2
  int : Union2
  boolean : Union2
  array : Array[Union2]
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model MixedLiteralsCases
pub(all) struct MixedLiteralsCases {
  string_literal : Union4
  int_literal : Union4
  float_literal : Union4
  boolean_literal : Union4
} derive (
  Show,
  ToJson(
    fields(
      string_literal(rename="stringLiteral"),
      int_literal(rename="intLiteral"),
      float_literal(rename="floatLiteral"),
      boolean_literal(rename="booleanLiteral"),
    ),
  ),
  @json.FromJson(
    fields(
      string_literal(rename="stringLiteral"),
      int_literal(rename="intLiteral"),
      float_literal(rename="floatLiteral"),
      boolean_literal(rename="booleanLiteral"),
    ),
  ),
)

///|

///|
/// Model StringAndArrayCases
pub(all) struct StringAndArrayCases {
  string : Union5
  array : Union6
} derive(Show, ToJson, @json.FromJson)
