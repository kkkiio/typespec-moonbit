///|

///|
/// Model Model0
pub(all) struct Model0 {
  temperature : HttpPart4
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Model1
pub(all) struct Model1 {
  profile_image : HttpPart7
} derive (
  Show,
  ToJson(fields(profile_image(rename="profileImage"))),
  @json.FromJson(fields(profile_image(rename="profileImage"))),
)

///|

///|
/// Model HttpPart
pub(all) struct HttpPart {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart1
pub(all) struct HttpPart1 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart2
pub(all) struct HttpPart2 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart3
pub(all) struct HttpPart3 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart4
pub(all) struct HttpPart4 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart5
pub(all) struct HttpPart5 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart6
pub(all) struct HttpPart6 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart7
pub(all) struct HttpPart7 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart8
pub(all) struct HttpPart8 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart9
pub(all) struct HttpPart9 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart10
pub(all) struct HttpPart10 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart11
pub(all) struct HttpPart11 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart12
pub(all) struct HttpPart12 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart13
pub(all) struct HttpPart13 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart14
pub(all) struct HttpPart14 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart15
pub(all) struct HttpPart15 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart16
pub(all) struct HttpPart16 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart17
pub(all) struct HttpPart17 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart18
pub(all) struct HttpPart18 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart19
pub(all) struct HttpPart19 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart20
pub(all) struct HttpPart20 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart21
pub(all) struct HttpPart21 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart22
pub(all) struct HttpPart22 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart23
pub(all) struct HttpPart23 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart24
pub(all) struct HttpPart24 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model HttpPart25
pub(all) struct HttpPart25 {} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model JsonPartRequest
pub(all) struct JsonPartRequest {
  address : HttpPart2
  profile_image : HttpPart3
} derive (
  Show,
  ToJson(fields(profile_image(rename="profileImage"))),
  @json.FromJson(fields(profile_image(rename="profileImage"))),
)

///|

///|
/// Model MultiPartRequest
pub(all) struct MultiPartRequest {
  id : HttpPart
  profile_image : HttpPart1
} derive (
  Show,
  ToJson(fields(profile_image(rename="profileImage"))),
  @json.FromJson(fields(profile_image(rename="profileImage"))),
)

///|

///|
/// Model ComplexPartsRequest
pub(all) struct ComplexPartsRequest {
  id : HttpPart8
  address : HttpPart9
  profile_image : HttpPart10
  pictures : Array[HttpPart11]
} derive (
  Show,
  ToJson(fields(profile_image(rename="profileImage"))),
  @json.FromJson(fields(profile_image(rename="profileImage"))),
)

///|

///|
/// Model BinaryArrayPartsRequest
pub(all) struct BinaryArrayPartsRequest {
  id : HttpPart12
  pictures : Array[HttpPart13]
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model MultiBinaryPartsRequest
pub(all) struct MultiBinaryPartsRequest {
  profile_image : HttpPart14
  picture : HttpPart15?
} derive (
  Show,
  ToJson(fields(profile_image(rename="profileImage"))),
  @json.FromJson(fields(profile_image(rename="profileImage"))),
)

///|

///|
/// Model MultiPartOptionalRequest
pub(all) struct MultiPartOptionalRequest {
  id : HttpPart5?
  profile_image : HttpPart6?
} derive (
  Show,
  ToJson(fields(profile_image(rename="profileImage"))),
  @json.FromJson(fields(profile_image(rename="profileImage"))),
)

///|

///|
/// Model ComplexHttpPartsModelRequest
pub(all) struct ComplexHttpPartsModelRequest {
  id : HttpPart18
  address : HttpPart19
  profile_image : HttpPart20
  previous_addresses : HttpPart21
  pictures : Array[HttpPart22]
} derive (
  Show,
  ToJson(
    fields(
      profile_image(rename="profileImage"),
      previous_addresses(rename="previousAddresses"),
    ),
  ),
  @json.FromJson(
    fields(
      profile_image(rename="profileImage"),
      previous_addresses(rename="previousAddresses"),
    ),
  ),
)

///|

///|
/// Model MultiPartRequestWithWireName
pub(all) struct MultiPartRequestWithWireName {
  identifier : HttpPart16
  image : HttpPart17
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FileWithHttpPartOptionalContentTypeRequest
pub(all) struct FileWithHttpPartOptionalContentTypeRequest {
  profile_image : HttpPart23
} derive (
  Show,
  ToJson(fields(profile_image(rename="profileImage"))),
  @json.FromJson(fields(profile_image(rename="profileImage"))),
)

///|

///|
/// Model FileWithHttpPartRequiredContentTypeRequest
pub(all) struct FileWithHttpPartRequiredContentTypeRequest {
  profile_image : HttpPart24
} derive (
  Show,
  ToJson(fields(profile_image(rename="profileImage"))),
  @json.FromJson(fields(profile_image(rename="profileImage"))),
)

///|

///|
/// Model FileWithHttpPartSpecificContentTypeRequest
pub(all) struct FileWithHttpPartSpecificContentTypeRequest {
  profile_image : HttpPart25
} derive (
  Show,
  ToJson(fields(profile_image(rename="profileImage"))),
  @json.FromJson(fields(profile_image(rename="profileImage"))),
)
