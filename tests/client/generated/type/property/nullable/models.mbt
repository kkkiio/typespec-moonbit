///|
/// Model InnerModel
pub(all) struct InnerModel {
  property : String
} derive(Show, ToJson, @json.FromJson)

///|
/// Model BytesProperty
pub(all) struct BytesProperty {
  required_property : String
  nullable_property : @runtime.Nullable[String]
} derive (
  Show,
  ToJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
  @json.FromJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
)

///|
/// Model StringProperty
pub(all) struct StringProperty {
  required_property : String
  nullable_property : @runtime.Nullable[String]
} derive (
  Show,
  ToJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
  @json.FromJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
)

///|
/// Model DatetimeProperty
pub(all) struct DatetimeProperty {
  required_property : String
  nullable_property : @runtime.Nullable[@runtime.UtcDateTime]
} derive (
  Show,
  ToJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
  @json.FromJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
)

///|
/// Model DurationProperty
pub(all) struct DurationProperty {
  required_property : String
  nullable_property : @runtime.Nullable[@runtime.Duration]
} derive (
  Show,
  ToJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
  @json.FromJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
)

///|
/// Model CollectionsByteProperty
pub(all) struct CollectionsByteProperty {
  required_property : String
  nullable_property : @runtime.Nullable[Array[String]]
} derive (
  Show,
  ToJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
  @json.FromJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
)

///|
/// Model CollectionsModelProperty
pub(all) struct CollectionsModelProperty {
  required_property : String
  nullable_property : @runtime.Nullable[Array[InnerModel]]
} derive (
  Show,
  ToJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
  @json.FromJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
)

///|
/// Model CollectionsStringProperty
pub(all) struct CollectionsStringProperty {
  required_property : String
  nullable_property : @runtime.Nullable[Array[String]]
} derive (
  Show,
  ToJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
  @json.FromJson(
    fields(
      required_property(rename="requiredProperty"),
      nullable_property(rename="nullableProperty"),
    ),
  ),
)
