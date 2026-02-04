///|
/// 运行时验证：spector routes。
#cfg(target="native")
async test "runtime routes: fixed + path basic" {
  // 注意：本测试假设 tsp-spector server 已在本机启动（localhost:3000）。
  // 启动方式对齐 typespec-rust：
  //   npm run spector -- --start
  // 结束后：
  //   npm run spector -- --stop
  wait_server_ready()
  let client = @routes.RoutesClient::new("http://localhost:3000")
  assert_204(client.get_routes_fixed())
  let client = @routes.InInterfaceClient::new("http://localhost:3000")
  assert_204(client.get_routes_in_interface_fixed())
  let client = @routes.PathParametersClient::new("http://localhost:3000")
  assert_204(client.get_routes_path_template_only__param_("a"))
  assert_204(client.get_routes_path_explicit__param_("a"))
  assert_204(client.get_routes_path_annotation_only__param_("a"))

  // 关键：reserved expansion 不应编码 '/'，但应编码空格 -> %20。
  let client = @routes.ReservedExpansionClient::new("http://localhost:3000")
  assert_204(
    client.get_routes_path_reserved_expansion_template___param_("foo/bar baz"),
  )
  assert_204(
    client.get_routes_path_reserved_expansion_annotation___param_("foo/bar baz"),
  )
}

///|
async test "runtime routes: path simple/path/label/matrix expansions" {
  wait_server_ready()
  let standard_client = @routes.StandardClient::new("http://localhost:3000")
  let explode_client = @routes.ExplodeClient::new("http://localhost:3000")

  // simple - standard
  assert_204(
    standard_client.get_routes_path_simple_standard_primitive_param_("a"),
  )
  assert_204(
    standard_client.get_routes_path_simple_standard_array_param_(["a", "b"]),
  )
  assert_204(
    standard_client.get_routes_path_simple_standard_record_param_(mk_record()),
  )

  // simple - explode
  assert_204(
    explode_client.get_routes_path_simple_explode_primitive_param__("a"),
  )
  assert_204(
    explode_client.get_routes_path_simple_explode_array_param__(["a", "b"]),
  )
  assert_204(
    explode_client.get_routes_path_simple_explode_record_param__(mk_record()),
  )

  // path - standard
  assert_204(
    standard_client.get_routes_path_path_standard_primitive__param_("a"),
  )
  assert_204(
    standard_client.get_routes_path_path_standard_array__param_(["a", "b"]),
  )
  assert_204(
    standard_client.get_routes_path_path_standard_record__param_(mk_record()),
  )

  // path - explode
  assert_204(
    explode_client.get_routes_path_path_explode_primitive__param__("a"),
  )
  assert_204(
    explode_client.get_routes_path_path_explode_array__param__(["a", "b"]),
  )
  assert_204(
    explode_client.get_routes_path_path_explode_record__param__(mk_record()),
  )

  // label - standard
  assert_204(
    standard_client.get_routes_path_label_standard_primitive__param_("a"),
  )
  assert_204(
    standard_client.get_routes_path_label_standard_array__param_(["a", "b"]),
  )
  assert_204(
    standard_client.get_routes_path_label_standard_record__param_(mk_record()),
  )

  // label - explode
  assert_204(
    explode_client.get_routes_path_label_explode_primitive__param__("a"),
  )
  assert_204(
    explode_client.get_routes_path_label_explode_array__param__(["a", "b"]),
  )
  assert_204(
    explode_client.get_routes_path_label_explode_record__param__(mk_record()),
  )

  // matrix - standard
  assert_204(
    standard_client.get_routes_path_matrix_standard_primitive__param_("a"),
  )
  assert_204(
    standard_client.get_routes_path_matrix_standard_array__param_(["a", "b"]),
  )
  assert_204(
    standard_client.get_routes_path_matrix_standard_record__param_(mk_record()),
  )

  // matrix - explode
  assert_204(
    explode_client.get_routes_path_matrix_explode_primitive__param__("a"),
  )
  assert_204(
    explode_client.get_routes_path_matrix_explode_array__param__(["a", "b"]),
  )
  assert_204(
    explode_client.get_routes_path_matrix_explode_record__param__(mk_record()),
  )
}

///|
async test "runtime routes: query expansions" {
  wait_server_ready()
  let query_client = @routes.QueryParametersClient::new("http://localhost:3000")
  let standard_client = @routes.StandardClient::new("http://localhost:3000")
  let explode_client = @routes.ExplodeClient::new("http://localhost:3000")
  assert_204(query_client.get_routes_query_template_only__param_("a"))
  assert_204(query_client.get_routes_query_explicit__param_("a"))
  assert_204(query_client.get_routes_query_annotation_only__param_("a"))

  // query expansion - standard
  assert_204(
    standard_client.get_routes_query_query_expansion_standard_primitive__param_(
      "a",
    ),
  )
  assert_204(
    standard_client.get_routes_query_query_expansion_standard_array__param_([
      "a", "b",
    ]),
  )
  assert_204(
    standard_client.get_routes_query_query_expansion_standard_record__param_(
      mk_record(),
    ),
  )

  // query expansion - explode
  assert_204(
    explode_client.get_routes_query_query_expansion_explode_primitive__param__(
      "a",
    ),
  )
  assert_204(
    explode_client.get_routes_query_query_expansion_explode_array__param__([
      "a", "b",
    ]),
  )
  assert_204(
    explode_client.get_routes_query_query_expansion_explode_record__param__(
      mk_record(),
    ),
  )

  // query continuation - standard (fixed=true)
  assert_204(
    standard_client.get_routes_query_query_continuation_standard_primitive_fixed_true__param_(
      "a",
    ),
  )
  assert_204(
    standard_client.get_routes_query_query_continuation_standard_array_fixed_true__param_([
        "a", "b",
      ],
    ),
  )
  assert_204(
    standard_client.get_routes_query_query_continuation_standard_record_fixed_true__param_(
      mk_record(),
    ),
  )

  // query continuation - explode (fixed=true)
  assert_204(
    explode_client.get_routes_query_query_continuation_explode_primitive_fixed_true__param__(
      "a",
    ),
  )
  assert_204(
    explode_client.get_routes_query_query_continuation_explode_array_fixed_true__param__([
        "a", "b",
      ],
    ),
  )
  assert_204(
    explode_client.get_routes_query_query_continuation_explode_record_fixed_true__param__(
      mk_record(),
    ),
  )
}
