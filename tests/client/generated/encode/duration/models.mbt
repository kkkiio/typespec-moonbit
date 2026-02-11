///|

///|
/// Model DefaultDurationProperty
pub(all) struct DefaultDurationProperty {
  value : @runtime.Duration
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Iso8601DurationProperty
pub(all) struct Iso8601DurationProperty {
  value : @runtime.Duration
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatSecondsDurationProperty
pub(all) struct FloatSecondsDurationProperty {
  value : @runtime.Duration
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Int32SecondsDurationProperty
pub(all) struct Int32SecondsDurationProperty {
  value : @runtime.Duration
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Float64SecondsDurationProperty
pub(all) struct Float64SecondsDurationProperty {
  value : @runtime.Duration
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatMillisecondsDurationProperty
pub(all) struct FloatMillisecondsDurationProperty {
  value : @runtime.Duration
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatSecondsDurationArrayProperty
pub(all) struct FloatSecondsDurationArrayProperty {
  value : Array[@runtime.Duration]
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Int32MillisecondsDurationProperty
pub(all) struct Int32MillisecondsDurationProperty {
  value : @runtime.Duration
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Float64MillisecondsDurationProperty
pub(all) struct Float64MillisecondsDurationProperty {
  value : @runtime.Duration
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatMillisecondsDurationArrayProperty
pub(all) struct FloatMillisecondsDurationArrayProperty {
  value : Array[@runtime.Duration]
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatSecondsLargerUnitDurationProperty
pub(all) struct FloatSecondsLargerUnitDurationProperty {
  value : @runtime.Duration
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Int32SecondsLargerUnitDurationProperty
pub(all) struct Int32SecondsLargerUnitDurationProperty {
  value : @runtime.Duration
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model FloatMillisecondsLargerUnitDurationProperty
pub(all) struct FloatMillisecondsLargerUnitDurationProperty {
  value : @runtime.Duration
} derive(Show, ToJson, @json.FromJson)

///|

///|
/// Model Int32MillisecondsLargerUnitDurationProperty
pub(all) struct Int32MillisecondsLargerUnitDurationProperty {
  value : @runtime.Duration
} derive(Show, ToJson, @json.FromJson)
