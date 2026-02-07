///|

///|
/// SSE events TaskEvents
pub(all) enum TaskEvents {
  MariaQueuedMessagesSynchronized(Json)
  Maria(Json)
} derive(Show)

///|

///|
/// Model Model0
pub(all) struct Model0 {
  error : Json
} derive(Show, ToJson, @json.FromJson)
