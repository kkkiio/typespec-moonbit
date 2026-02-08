///|

///|
/// 对齐上游：server/endpoint, server/path, server/versions（非 skip）
#cfg(target="native")
async test "runtime server specs" {
  let endpoint = @server_endpoint_not_defined.NotDefinedClient::new(
    "http://localhost:3000",
  )
  endpoint.head_server_endpoint_not_defined_valid()
  let single = @server_path_single.SingleClient::new("http://localhost:3000")
  single.head_server_path_single_myop()
  let multiple = @server_path_multiple.MultipleClient::new(
    "http://localhost:3000",
  )
  multiple.get_server_path_multiple__apiversion_("v1.0")
  multiple.get_server_path_multiple__apiversion___keyword_("v1.0", "test")
  let not_versioned = @server_versions_not_versioned.NotVersionedClient::new(
    "http://localhost:3000",
  )
  not_versioned.head_server_versions_not_versioned_without_api_version()
  not_versioned.head_server_versions_not_versioned_with_path_api_version__apiversion_(
    "v1.0",
  )
  let versioned = @server_versions_versioned.VersionedClient::new(
    "http://localhost:3000",
  )
  versioned.head_server_versions_versioned_without_api_version()
  versioned.head_server_versions_versioned_with_path_api_version__apiversion_(
    "2022-12-01-preview",
  )
}
