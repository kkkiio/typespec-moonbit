///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model PngImageAsJson0
pub(all) struct PngImageAsJson0 {
  content : Bytes
} derive(Show)

///|
pub impl ToJson for PngImageAsJson0 with to_json(self : PngImageAsJson0) -> Json {
  let obj : Map[String, Json] = {}
  obj.set(
    "content",
    Json::string(
      @runtime.encode_bytes(self.content, @runtime.BytesEncoding::Base64),
    ),
  )
  Json::object(obj)
}

///|
pub impl @json.FromJson for PngImageAsJson0 with from_json(
  json : Json,
  path : @json.JsonPath,
) -> PngImageAsJson0 raise {
  let obj : Map[String, Json] = @json.from_json(json, path~)
  let __raw_content = obj.get("content").unwrap_or(Json::null())
  let __content_decoded_result : Result[Bytes, Error] = try? @runtime.decode_bytes(
    @json.from_json(__raw_content, path~),
    @runtime.BytesEncoding::Base64,
  )
  let __content : Bytes = match __content_decoded_result {
    Ok(decoded) => decoded
    Err(_) =>
      raise @json.JsonDecodeError(
        (path, "invalid bytes value for field content"),
      )
  }
  { content: __content }
}
