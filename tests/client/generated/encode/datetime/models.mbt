///|
/// Model DefaultDatetimeProperty
pub(all) struct DefaultDatetimeProperty {
  value : @runtime.UtcDateTime
} derive(Show, ToJson, @json.FromJson)

///|
/// Model Rfc3339DatetimeProperty
pub(all) struct Rfc3339DatetimeProperty {
  value : @runtime.UtcDateTime
} derive(Show, ToJson, @json.FromJson)

///|
/// Model Rfc7231DatetimeProperty
pub(all) struct Rfc7231DatetimeProperty {
  value : @runtime.UtcDateTime
} derive(Show, ToJson, @json.FromJson)

///|
/// Model UnixTimestampDatetimeProperty
pub(all) struct UnixTimestampDatetimeProperty {
  value : @runtime.UtcDateTime
} derive(Show, ToJson, @json.FromJson)

///|
/// Model UnixTimestampArrayDatetimeProperty
pub(all) struct UnixTimestampArrayDatetimeProperty {
  value : Array[@runtime.UtcDateTime]
} derive(Show, ToJson, @json.FromJson)
