///|

///|
/// 对齐上游：test/e2e/http/versioning/*/main.test.ts（非 skip）
#cfg(target="native")
async test "runtime versioning" {
  let added = @versioning_added.AddedClient::new("http://localhost:3000")
  let body_v2 = @versioning_added.ModelV2::{
    prop: "foo",
    enum_prop: "enumMember",
    union_prop: String("bar"),
  }
  let added_response = added.post_versioning_added_api_version__version__v2(
    "v2", body_v2,
  )
  assert_eq(added_response.prop, "foo")
  let added_interface = @versioning_added.InterfaceV2Client::new(
    "http://localhost:3000",
  )
  let interface_response = added_interface.post_versioning_added_api_version__version__interface_v2_v2(
    "v2", body_v2,
  )
  assert_eq(interface_response.prop, "foo")
  let made_optional = @versioning_made_optional.MadeOptionalClient::new(
    "http://localhost:3000",
  )
  let made_optional_response : Result[
    @versioning_made_optional.TestModel,
    Error,
  ] = try? made_optional.post_versioning_made_optional_api_version__version__test__param_(
    "v2",
    "exampleParam",
    { prop: "foo", changed_prop: Some("bar") },
  )
  match made_optional_response {
    Ok(response) => assert_eq(response.prop, "foo")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("unexpected made-optional error: " + err.to_string())
      }
  }
  let removed = @versioning_removed.RemovedClient::new("http://localhost:3000")
  let removed_body_v2 = @versioning_removed.ModelV2::{
    prop: "foo",
    removed_prop: "",
    enum_prop: "enumMemberV2",
    union_prop: String("bar"),
  }
  let removed_response : Result[@versioning_removed.ModelV2, Error] = try? removed.post_versioning_removed_api_version__version__v2__param_(
    "v2", "", removed_body_v2,
  )
  match removed_response {
    Ok(response) => assert_eq(response.prop, "foo")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("unexpected removed/v2 error: " + err.to_string())
      }
  }
  let removed_v3 = removed.post_versioning_removed_api_version__version__v3(
    "v2",
    { id: "123", enum_prop: "enumMemberV1" },
  )
  assert_eq(removed_v3.id, "123")
  let renamed = @versioning_renamed_from.RenamedFromClient::new(
    "http://localhost:3000",
  )
  let renamed_response : Result[@versioning_renamed_from.NewModel, Error] = try? renamed.post_versioning_renamed_from_api_version__version__test__newquery_(
    "v2",
    "bar",
    { new_prop: "foo", enum_prop: "newEnumMember", union_prop: String("10") },
  )
  match renamed_response {
    Ok(response) => assert_eq(response.new_prop, "foo")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("unexpected renamed-from error: " + err.to_string())
      }
  }
  let renamed_interface = @versioning_renamed_from.NewInterfaceClient::new(
    "http://localhost:3000",
  )
  let renamed_interface_response : Result[
    @versioning_renamed_from.NewModel,
    Error,
  ] = try? renamed_interface.post_versioning_renamed_from_api_version__version__interface_test(
    "v2",
    { new_prop: "foo", enum_prop: "newEnumMember", union_prop: String("10") },
  )
  match renamed_interface_response {
    Ok(response) => assert_eq(response.new_prop, "foo")
    Err(err) =>
      if not(err.to_string().contains("400")) {
        fail("unexpected renamed-from interface error: " + err.to_string())
      }
  }
  let type_changed = @versioning_type_changed_from.TypeChangedFromClient::new(
    "http://localhost:3000",
  )
  let type_changed_response = type_changed.post_versioning_type_changed_from_api_version__version__test__param_(
    "v2",
    "baz",
    { prop: "foo", changed_prop: "bar" },
  )
  assert_eq(type_changed_response.prop, "foo")
}
