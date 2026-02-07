///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|

///|
/// Model DefaultDurationProperty
pub(all) struct DefaultDurationProperty {
  value : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Iso8601DurationProperty
pub(all) struct Iso8601DurationProperty {
  value : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatSecondsDurationProperty
pub(all) struct FloatSecondsDurationProperty {
  value : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Int32SecondsDurationProperty
pub(all) struct Int32SecondsDurationProperty {
  value : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Float64SecondsDurationProperty
pub(all) struct Float64SecondsDurationProperty {
  value : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatMillisecondsDurationProperty
pub(all) struct FloatMillisecondsDurationProperty {
  value : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatSecondsDurationArrayProperty
pub(all) struct FloatSecondsDurationArrayProperty {
  value : Array[String]
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Int32MillisecondsDurationProperty
pub(all) struct Int32MillisecondsDurationProperty {
  value : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Float64MillisecondsDurationProperty
pub(all) struct Float64MillisecondsDurationProperty {
  value : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatMillisecondsDurationArrayProperty
pub(all) struct FloatMillisecondsDurationArrayProperty {
  value : Array[String]
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatSecondsLargerUnitDurationProperty
pub(all) struct FloatSecondsLargerUnitDurationProperty {
  value : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Int32SecondsLargerUnitDurationProperty
pub(all) struct Int32SecondsLargerUnitDurationProperty {
  value : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatMillisecondsLargerUnitDurationProperty
pub(all) struct FloatMillisecondsLargerUnitDurationProperty {
  value : String
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Int32MillisecondsLargerUnitDurationProperty
pub(all) struct Int32MillisecondsLargerUnitDurationProperty {
  value : String
} derive(Show, ToJson, @json.FromJson)
