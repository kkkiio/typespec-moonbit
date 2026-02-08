///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model BytesProperty
pub(all) struct BytesProperty {
  property : Bytes?
} derive(Show)

///|
pub impl ToJson for BytesProperty with to_json(self : BytesProperty) -> Json {
  let obj : Map[String, Json] = {}
  obj.set(
    "property",
    match self.property {
      Some(v) =>
        Json::string(@runtime.encode_bytes(v, @runtime.BytesEncoding::Base64))
      None => Json::null()
    },
  )
  Json::object(obj)
}

///|
pub impl @json.FromJson for BytesProperty with from_json(
  json : Json,
  path : @json.JsonPath,
) -> BytesProperty raise {
  let obj : Map[String, Json] = @json.from_json(json, path~)
  let __raw_property = obj.get("property").unwrap_or(Json::null())
  let __property : Bytes? = if Json::equal(__raw_property, Json::null()) {
    None
  } else {
    let decoded_result : Result[Bytes, Error] = try? @runtime.decode_bytes(
      @json.from_json(__raw_property, path~),
      @runtime.BytesEncoding::Base64,
    )
    match decoded_result {
      Ok(decoded) => Some(decoded)
      Err(_) =>
        raise @json.JsonDecodeError(
          (path, "invalid bytes value for field property"),
        )
    }
  }
  { property: __property }
}

///|

///|
/// Model StringProperty
pub(all) struct StringProperty {
  property : String?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model DatetimeProperty
pub(all) struct DatetimeProperty {
  property : String?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model DurationProperty
pub(all) struct DurationProperty {
  property : String?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model PlainDateProperty
pub(all) struct PlainDateProperty {
  property : String?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model PlainTimeProperty
pub(all) struct PlainTimeProperty {
  property : String?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model IntLiteralProperty
pub(all) struct IntLiteralProperty {
  property : Double?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatLiteralProperty
pub(all) struct FloatLiteralProperty {
  property : Double?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model StringLiteralProperty
pub(all) struct StringLiteralProperty {
  property : String?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model BooleanLiteralProperty
pub(all) struct BooleanLiteralProperty {
  property : Bool?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model CollectionsByteProperty
pub(all) struct CollectionsByteProperty {
  property : Array[Bytes]?
} derive(Show)

///|
pub impl ToJson for CollectionsByteProperty with to_json(
  self : CollectionsByteProperty,
) -> Json {
  let obj : Map[String, Json] = {}
  obj.set(
    "property",
    match self.property {
      Some(v) =>
        @runtime.encode_bytes_list(v, @runtime.BytesEncoding::Base64).to_json()
      None => Json::null()
    },
  )
  Json::object(obj)
}

///|
pub impl @json.FromJson for CollectionsByteProperty with from_json(
  json : Json,
  path : @json.JsonPath,
) -> CollectionsByteProperty raise {
  let obj : Map[String, Json] = @json.from_json(json, path~)
  let __raw_property = obj.get("property").unwrap_or(Json::null())
  let __property : Array[Bytes]? = if Json::equal(__raw_property, Json::null()) {
    None
  } else {
    let encoded : Array[String] = @json.from_json(__raw_property, path~)
    let decoded : Array[Bytes] = []
    for s in encoded {
      let decoded_result : Result[Bytes, Error] = try? @runtime.decode_bytes(
        s,
        @runtime.BytesEncoding::Base64,
      )
      match decoded_result {
        Ok(decoded_item) => decoded.push(decoded_item)
        Err(_) =>
          raise @json.JsonDecodeError(
            (path, "invalid bytes array item for field property"),
          )
      }
    }
    Some(decoded)
  }
  { property: __property }
}

///|

///|
/// Model UnionIntLiteralProperty
pub(all) struct UnionIntLiteralProperty {
  property : Double?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model CollectionsModelProperty
pub(all) struct CollectionsModelProperty {
  property : Array[StringProperty]?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model UnionFloatLiteralProperty
pub(all) struct UnionFloatLiteralProperty {
  property : Double?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model UnionStringLiteralProperty
pub(all) struct UnionStringLiteralProperty {
  property : String?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model RequiredAndOptionalProperty
pub(all) struct RequiredAndOptionalProperty {
  optional_property : String?
  required_property : Int
} derive (
  Show,
  ToJson(
    fields(
      optional_property(rename="optionalProperty"),
      required_property(rename="requiredProperty"),
    ),
  ),
  @json.FromJson(
    fields(
      optional_property(rename="optionalProperty"),
      required_property(rename="requiredProperty"),
    ),
  ),
)
