///|
#warnings("-unused_type_declaration")
pub using @runtime {type Nullable}

///|
/// Model EmptyInput
pub(all) struct EmptyInput {} derive(Show, Default, ToJson, @json.FromJson)

///|
/// Model EmptyOutput
pub(all) struct EmptyOutput {} derive(Show, Default, ToJson)

///|
/// Model EmptyInputOutput
pub(all) struct EmptyInputOutput {} derive(Show, Default, ToJson, @json.FromJson)
