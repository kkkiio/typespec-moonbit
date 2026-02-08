///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model Resource
pub(all) struct Resource {
  name : String
  description : String?
  map : Map[String, InnerModel]?
  array : Array[InnerModel]?
  int_value : Int?
  float_value : Double?
  inner_model : InnerModel?
  int_array : Array[Int]?
} derive (
  Show,
  ToJson(
    fields(
      int_value(rename="intValue"),
      float_value(rename="floatValue"),
      inner_model(rename="innerModel"),
      int_array(rename="intArray"),
    ),
  ),
  @json.FromJson(
    fields(
      int_value(rename="intValue"),
      float_value(rename="floatValue"),
      inner_model(rename="innerModel"),
      int_array(rename="intArray"),
    ),
  ),
)

///|

///|
/// Model InnerModel
pub(all) struct InnerModel {
  name : String?
  description : String?
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model ResourcePatch
pub(all) struct ResourcePatch {
  description : String?
  map : Map[String, InnerModel]?
  array : Array[InnerModel]?
  int_value : Int?
  float_value : Double?
  inner_model : InnerModel?
  int_array : Array[Int]?
} derive (
  Show,
  ToJson(
    fields(
      int_value(rename="intValue"),
      float_value(rename="floatValue"),
      inner_model(rename="innerModel"),
      int_array(rename="intArray"),
    ),
  ),
  @json.FromJson(
    fields(
      int_value(rename="intValue"),
      float_value(rename="floatValue"),
      inner_model(rename="innerModel"),
      int_array(rename="intArray"),
    ),
  ),
)
