///|
/// Model Pet
pub(all) struct Pet {
  id : String
  name : String
} derive(Show, ToJson, @json.FromJson)

///|
/// Model Model
pub(all) struct Model {
  pets : Array[Pet]
  next : String?
} derive(Show, ToJson, @json.FromJson)

///|
/// Model Model1
pub(all) struct Model1 {
  pets : Array[Pet]
} derive(Show, ToJson, @json.FromJson)

///|
/// Model Model2
pub(all) struct Model2 {
  pets : Array[Pet]
  next : String?
} derive(Show, ToJson, @json.FromJson)

///|
/// Model Model3
pub(all) struct Model3 {
  nested_items : Model6
  nested_next : Model4
} derive (
  Show,
  ToJson(
    fields(nested_items(rename="nestedItems"), nested_next(rename="nestedNext")),
  ),
  @json.FromJson(
    fields(nested_items(rename="nestedItems"), nested_next(rename="nestedNext")),
  ),
)

///|
/// Model Model4
pub(all) struct Model4 {
  next : String?
} derive(Show, ToJson, @json.FromJson)

///|
/// Model Model5
pub(all) struct Model5 {
  pets : Array[Pet]
} derive(Show, ToJson, @json.FromJson)

///|
/// Model Model6
pub(all) struct Model6 {
  pets : Array[Pet]
} derive(Show, ToJson, @json.FromJson)

///|
/// Model Model7
pub(all) struct Model7 {
  pets : Array[Pet]
  next_token : String?
} derive (
  Show,
  ToJson(fields(next_token(rename="nextToken"))),
  @json.FromJson(fields(next_token(rename="nextToken"))),
)

///|
/// Model Model8
pub(all) struct Model8 {
  pets : Array[Pet]
} derive(Show, ToJson, @json.FromJson)

///|
/// Model Model9
pub(all) struct Model9 {
  pets : Array[Pet]
  next_token : String?
} derive (
  Show,
  ToJson(fields(next_token(rename="nextToken"))),
  @json.FromJson(fields(next_token(rename="nextToken"))),
)

///|
/// Model Model10
pub(all) struct Model10 {
  pets : Array[Pet]
} derive(Show, ToJson, @json.FromJson)

///|
/// Model Model11
pub(all) struct Model11 {
  nested_items : Model14
  nested_next : Model13?
} derive (
  Show,
  ToJson(
    fields(nested_items(rename="nestedItems"), nested_next(rename="nestedNext")),
  ),
  @json.FromJson(
    fields(nested_items(rename="nestedItems"), nested_next(rename="nestedNext")),
  ),
)

///|
/// Model Model12
pub(all) struct Model12 {
  nested_items : Model16
  nested_next : Model15?
} derive (
  Show,
  ToJson(
    fields(nested_items(rename="nestedItems"), nested_next(rename="nestedNext")),
  ),
  @json.FromJson(
    fields(nested_items(rename="nestedItems"), nested_next(rename="nestedNext")),
  ),
)

///|
/// Model Model13
pub(all) struct Model13 {
  next_token : String?
} derive (
  Show,
  ToJson(fields(next_token(rename="nextToken"))),
  @json.FromJson(fields(next_token(rename="nextToken"))),
)

///|
/// Model Model14
pub(all) struct Model14 {
  pets : Array[Pet]
} derive(Show, ToJson, @json.FromJson)

///|
/// Model Model15
pub(all) struct Model15 {
  next_token : String?
} derive (
  Show,
  ToJson(fields(next_token(rename="nextToken"))),
  @json.FromJson(fields(next_token(rename="nextToken"))),
)

///|
/// Model Model16
pub(all) struct Model16 {
  pets : Array[Pet]
} derive(Show, ToJson, @json.FromJson)
