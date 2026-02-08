///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model As
pub(all) struct As {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model If
pub(all) struct If {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model In
pub(all) struct In {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Is
pub(all) struct Is {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Or
pub(all) struct Or {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model And
pub(all) struct And {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Def
pub(all) struct Def {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Del
pub(all) struct Del {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model For
pub(all) struct For {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Not
pub(all) struct Not {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Try
pub(all) struct Try {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Elif
pub(all) struct Elif {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Else
pub(all) struct Else {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Exec
pub(all) struct Exec {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model From
pub(all) struct From {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Pass
pub(all) struct Pass {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model With
pub(all) struct With {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Async
pub(all) struct Async {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Await
pub(all) struct Await {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Break
pub(all) struct Break {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Class
pub(all) struct Class {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Raise
pub(all) struct Raise {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model While
pub(all) struct While {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Yield
pub(all) struct Yield {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Assert
pub(all) struct Assert {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Except
pub(all) struct Except {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Global
pub(all) struct Global {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Import
pub(all) struct Import {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Lambda
pub(all) struct Lambda {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Return
pub(all) struct Return {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Finally
pub(all) struct Finally {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Continue
pub(all) struct Continue {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Constructor
pub(all) struct Constructor {
  name : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model DictMethods
pub(all) struct DictMethods {
  keys : String
  items : String
  values : String
  popitem : String
  clear : String
  update : String
  setdefault : String
  pop : String
  get : String
  copy : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model SameAsModel
pub(all) struct SameAsModel {
  same_as_model : String
} derive (
  Show,
  ToJson(fields(same_as_model(rename="SameAsModel"))),
  @json.FromJson(fields(same_as_model(rename="SameAsModel"))),
)
