///|
test "client type name is PascalCase" {
  inspect(
    [
      make_client_type_name("routes"),
      make_client_type_name("routes_client"),
      make_client_type_name("routesClient"),
      make_client_type_name("RoutesClient"),
      make_client_type_name(""),
    ],
    content=(
      #|["RoutesClient", "RoutesClient", "RoutesClient", "RoutesClient", "Client"]
    ),
  )
}
