///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|
/// SSE events TaskEvents
pub(all) enum TaskEvents {
  MariaQueuedMessagesSynchronized(Json)
  Maria(Json)
} derive(Show)

///|
/// Model Model0
pub(all) struct Model0 {
  error : Json
} derive(Show, Default, ToJson)
