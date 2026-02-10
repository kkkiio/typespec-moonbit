///|

///|
/// Model InnerModel
pub(all) struct InnerModel {
  property : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model IntProperty
pub(all) struct IntProperty {
  property : Int
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model EnumProperty
pub(all) struct EnumProperty {
  property : Json
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model BytesProperty
pub(all) struct BytesProperty {
  property : Bytes
} derive(Show)

///|
pub impl ToJson for BytesProperty with to_json(self : BytesProperty) -> Json {
  let obj : Map[String, Json] = {}
  obj.set(
    "property",
    Json::string(
      @runtime.encode_bytes(self.property, @runtime.BytesEncoding::Base64),
    ),
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
  let __property_decoded_result : Result[Bytes, Error] = try? @runtime.decode_bytes(
    @json.from_json(__raw_property, path~),
    @runtime.BytesEncoding::Base64,
  )
  let __property : Bytes = match __property_decoded_result {
    Ok(decoded) => decoded
    Err(_) =>
      raise @json.JsonDecodeError(
        (path, "invalid bytes value for field property"),
      )
  }
  { property: __property }
}

///|

///|
/// Model FloatProperty
pub(all) struct FloatProperty {
  property : Double
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model ModelProperty
pub(all) struct ModelProperty {
  property : InnerModel
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model NeverProperty
pub(all) struct NeverProperty {
  property : Json
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model StringProperty
pub(all) struct StringProperty {
  property : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model BooleanProperty
pub(all) struct BooleanProperty {
  property : Bool
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model DecimalProperty
pub(all) struct DecimalProperty {
  property : Double
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model DatetimeProperty
pub(all) struct DatetimeProperty {
  property : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model DurationProperty
pub(all) struct DurationProperty {
  property : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Decimal128Property
pub(all) struct Decimal128Property {
  property : Double
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model IntLiteralProperty
pub(all) struct IntLiteralProperty {
  property : Double
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model UnknownIntProperty
pub(all) struct UnknownIntProperty {
  property : Json
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model UnknownDictProperty
pub(all) struct UnknownDictProperty {
  property : Json
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatLiteralProperty
pub(all) struct FloatLiteralProperty {
  property : Double
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model UnknownArrayProperty
pub(all) struct UnknownArrayProperty {
  property : Json
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model StringLiteralProperty
pub(all) struct StringLiteralProperty {
  property : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model UnknownStringProperty
pub(all) struct UnknownStringProperty {
  property : Json
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model BooleanLiteralProperty
pub(all) struct BooleanLiteralProperty {
  property : Bool
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model CollectionsIntProperty
pub(all) struct CollectionsIntProperty {
  property : Array[Int]
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model ExtensibleEnumProperty
pub(all) struct ExtensibleEnumProperty {
  property : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model UnionEnumValueProperty
pub(all) struct UnionEnumValueProperty {
  property : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model UnionIntLiteralProperty
pub(all) struct UnionIntLiteralProperty {
  property : Double
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model CollectionsModelProperty
pub(all) struct CollectionsModelProperty {
  property : Array[InnerModel]
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model DictionaryStringProperty
pub(all) struct DictionaryStringProperty {
  property : Map[String, String]
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model CollectionsStringProperty
pub(all) struct CollectionsStringProperty {
  property : Array[String]
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model UnionFloatLiteralProperty
pub(all) struct UnionFloatLiteralProperty {
  property : Double
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model UnionStringLiteralProperty
pub(all) struct UnionStringLiteralProperty {
  property : String
} derive(Show, ToJson, @json.FromJson)
