///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model Base64BytesProperty
pub(all) struct Base64BytesProperty {
  value : Bytes
} derive(Show)

///|
pub impl ToJson for Base64BytesProperty with to_json(self : Base64BytesProperty) -> Json {
  let obj : Map[String, Json] = {}
  obj.set(
    "value",
    Json::string(
      @runtime.encode_bytes(self.value, @runtime.BytesEncoding::Base64),
    ),
  )
  Json::object(obj)
}

///|
pub impl @json.FromJson for Base64BytesProperty with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Base64BytesProperty raise {
  let obj : Map[String, Json] = @json.from_json(json, path~)
  let __raw_value = obj.get("value").unwrap_or(Json::null())
  let __value_decoded_result : Result[Bytes, Error] = try? @runtime.decode_bytes(
    @json.from_json(__raw_value, path~),
    @runtime.BytesEncoding::Base64,
  )
  let __value : Bytes = match __value_decoded_result {
    Ok(decoded) => decoded
    Err(_) =>
      raise @json.JsonDecodeError((path, "invalid bytes value for field value"))
  }
  { value: __value }
}

///|

///|
/// Model DefaultBytesProperty
pub(all) struct DefaultBytesProperty {
  value : Bytes
} derive(Show)

///|
pub impl ToJson for DefaultBytesProperty with to_json(
  self : DefaultBytesProperty,
) -> Json {
  let obj : Map[String, Json] = {}
  obj.set(
    "value",
    Json::string(
      @runtime.encode_bytes(self.value, @runtime.BytesEncoding::Base64),
    ),
  )
  Json::object(obj)
}

///|
pub impl @json.FromJson for DefaultBytesProperty with from_json(
  json : Json,
  path : @json.JsonPath,
) -> DefaultBytesProperty raise {
  let obj : Map[String, Json] = @json.from_json(json, path~)
  let __raw_value = obj.get("value").unwrap_or(Json::null())
  let __value_decoded_result : Result[Bytes, Error] = try? @runtime.decode_bytes(
    @json.from_json(__raw_value, path~),
    @runtime.BytesEncoding::Base64,
  )
  let __value : Bytes = match __value_decoded_result {
    Ok(decoded) => decoded
    Err(_) =>
      raise @json.JsonDecodeError((path, "invalid bytes value for field value"))
  }
  { value: __value }
}

///|

///|
/// Model Base64UrlBytesProperty
pub(all) struct Base64UrlBytesProperty {
  value : Bytes
} derive(Show)

///|
pub impl ToJson for Base64UrlBytesProperty with to_json(
  self : Base64UrlBytesProperty,
) -> Json {
  let obj : Map[String, Json] = {}
  obj.set(
    "value",
    Json::string(
      @runtime.encode_bytes(self.value, @runtime.BytesEncoding::Base64Url),
    ),
  )
  Json::object(obj)
}

///|
pub impl @json.FromJson for Base64UrlBytesProperty with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Base64UrlBytesProperty raise {
  let obj : Map[String, Json] = @json.from_json(json, path~)
  let __raw_value = obj.get("value").unwrap_or(Json::null())
  let __value_decoded_result : Result[Bytes, Error] = try? @runtime.decode_bytes(
    @json.from_json(__raw_value, path~),
    @runtime.BytesEncoding::Base64Url,
  )
  let __value : Bytes = match __value_decoded_result {
    Ok(decoded) => decoded
    Err(_) =>
      raise @json.JsonDecodeError((path, "invalid bytes value for field value"))
  }
  { value: __value }
}

///|

///|
/// Model Base64UrlArrayBytesProperty
pub(all) struct Base64UrlArrayBytesProperty {
  value : Array[Bytes]
} derive(Show)

///|
pub impl ToJson for Base64UrlArrayBytesProperty with to_json(
  self : Base64UrlArrayBytesProperty,
) -> Json {
  let obj : Map[String, Json] = {}
  obj.set(
    "value",
    @runtime.encode_bytes_list(self.value, @runtime.BytesEncoding::Base64).to_json(),
  )
  Json::object(obj)
}

///|
pub impl @json.FromJson for Base64UrlArrayBytesProperty with from_json(
  json : Json,
  path : @json.JsonPath,
) -> Base64UrlArrayBytesProperty raise {
  let obj : Map[String, Json] = @json.from_json(json, path~)
  let __raw_value = obj.get("value").unwrap_or(Json::null())
  let __value_encoded : Array[String] = @json.from_json(__raw_value, path~)
  let __value : Array[Bytes] = []
  for s in __value_encoded {
    let decoded_result : Result[Bytes, Error] = try? @runtime.decode_bytes(
      s,
      @runtime.BytesEncoding::Base64,
    )
    match decoded_result {
      Ok(decoded_item) => __value.push(decoded_item)
      Err(_) =>
        raise @json.JsonDecodeError(
          (path, "invalid bytes array item for field value"),
        )
    }
  }
  { value: __value }
}
