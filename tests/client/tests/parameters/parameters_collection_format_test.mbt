///|
/// 运行时验证：http-specs parameters/collection-format
#cfg(target="native")
async test "runtime parameters/collection-format" {
  let query = @parameters_collection_format.QueryClient::new(
    "http://localhost:3000",
  )
  let colors = ["blue", "red", "green"]
  query.get_parameters_collection_format_query_multi__colors__(colors)
  query.get_parameters_collection_format_query_csv__colors_(colors)
  query.get_parameters_collection_format_query_ssv__colors_(colors)
  query.get_parameters_collection_format_query_pipes__colors_(colors)
  let header = @parameters_collection_format.HeaderClient::new(
    "http://localhost:3000",
  )
  header.get_parameters_collection_format_header_csv(colors)
}
