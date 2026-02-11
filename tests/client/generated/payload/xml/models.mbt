///|
/// Model SimpleModel
pub(all) struct SimpleModel {
  name : String
  age : Int
} derive(Show, ToJson, @json.FromJson)

///|
/// Model ModelWithText
pub(all) struct ModelWithText {
  language : String
  content : String
} derive(Show, ToJson, @json.FromJson)

///|
/// Model ModelWithAttributes
pub(all) struct ModelWithAttributes {
  id_1 : Int
  id_2 : String
  enabled : Bool
} derive (
  Show,
  ToJson(fields(id_1(rename="id1"), id_2(rename="id2"))),
  @json.FromJson(fields(id_1(rename="id1"), id_2(rename="id2"))),
)

///|
/// Model ModelWithDictionary
pub(all) struct ModelWithDictionary {
  metadata : Map[String, String]
} derive(Show, ToJson, @json.FromJson)

///|
/// Model ModelWithEmptyArray
pub(all) struct ModelWithEmptyArray {
  items : Array[SimpleModel]
} derive(Show, ToJson, @json.FromJson)

///|
/// Model ModelWithArrayOfModel
pub(all) struct ModelWithArrayOfModel {
  items : Array[SimpleModel]
} derive(Show, ToJson, @json.FromJson)

///|
/// Model ModelWithEncodedNames
pub(all) struct ModelWithEncodedNames {
  model_data : SimpleModel
  colors : Array[String]
} derive (
  Show,
  ToJson(fields(model_data(rename="modelData"))),
  @json.FromJson(fields(model_data(rename="modelData"))),
)

///|
/// Model ModelWithSimpleArrays
pub(all) struct ModelWithSimpleArrays {
  colors : Array[String]
  counts : Array[Int]
} derive(Show, ToJson, @json.FromJson)

///|
/// Model ModelWithOptionalField
pub(all) struct ModelWithOptionalField {
  item : String
  value : Int?
} derive(Show, ToJson, @json.FromJson)

///|
/// Model ModelWithRenamedArrays
pub(all) struct ModelWithRenamedArrays {
  colors : Array[String]
  counts : Array[Int]
} derive(Show, ToJson, @json.FromJson)

///|
/// Model ModelWithRenamedFields
pub(all) struct ModelWithRenamedFields {
  input_data : SimpleModel
  output_data : SimpleModel
} derive (
  Show,
  ToJson(
    fields(input_data(rename="inputData"), output_data(rename="outputData")),
  ),
  @json.FromJson(
    fields(input_data(rename="inputData"), output_data(rename="outputData")),
  ),
)

///|
/// Model ModelWithUnwrappedArray
pub(all) struct ModelWithUnwrappedArray {
  colors : Array[String]
  counts : Array[Int]
} derive(Show, ToJson, @json.FromJson)
