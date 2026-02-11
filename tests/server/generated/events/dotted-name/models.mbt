///|
/// SSE events TaskEvents
pub(all) enum TaskEvents {
  MariaQueuedMessagesSynchronized(Json)
  Maria(Json)
} derive(Show)

///|
/// Model Model
pub(all) struct Model {
  error : Json
} derive(Show, ToJson, @json.FromJson)
