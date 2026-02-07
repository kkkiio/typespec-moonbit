///|

///|
/// 运行时验证：spector routes。
#cfg(target="native")
async test "runtime routes: fixed + path basic" {
  // 注意：本测试假设 tsp-spector server 已在本机启动（localhost:3000）。
  // 启动方式对齐 typespec-rust：
  //   npm run spector -- --start
  // 结束后：
  //   npm run spector -- --stop
  let client = @routes.RoutesClient::new("http://localhost:3000")
  client.get_routes_fixed()
  let client = @routes.InInterfaceClient::new("http://localhost:3000")
  client.get_routes_in_interface_fixed()
  let client = @routes.PathParametersClient::new("http://localhost:3000")
  client.get_routes_path_template_only__param_("a")
  client.get_routes_path_explicit__param_("a")
  client.get_routes_path_annotation_only__param_("a")

  // 关键：reserved expansion 不应编码 '/'，但应编码空格 -> %20。
  let client = @routes.ReservedExpansionClient::new("http://localhost:3000")
  client.get_routes_path_reserved_expansion_template___param_("foo/bar baz")
  client.get_routes_path_reserved_expansion_annotation___param_("foo/bar baz")
}

///|
async test "runtime routes: path simple/path/label/matrix expansions" {
  let standard_client = @routes.StandardClient::new("http://localhost:3000")
  let explode_client = @routes.ExplodeClient::new("http://localhost:3000")

  // simple - standard
  standard_client.get_routes_path_simple_standard_primitive_param_("a")
  standard_client.get_routes_path_simple_standard_array_param_(["a", "b"])
  standard_client.get_routes_path_simple_standard_record_param_(mk_record())

  // simple - explode
  explode_client.get_routes_path_simple_explode_primitive_param__("a")
  explode_client.get_routes_path_simple_explode_array_param__(["a", "b"])
  explode_client.get_routes_path_simple_explode_record_param__(mk_record())

  // path - standard
  standard_client.get_routes_path_path_standard_primitive__param_("a")
  standard_client.get_routes_path_path_standard_array__param_(["a", "b"])
  standard_client.get_routes_path_path_standard_record__param_(mk_record())

  // path - explode
  explode_client.get_routes_path_path_explode_primitive__param__("a")
  explode_client.get_routes_path_path_explode_array__param__(["a", "b"])
  explode_client.get_routes_path_path_explode_record__param__(mk_record())

  // label - standard
  standard_client.get_routes_path_label_standard_primitive__param_("a")
  standard_client.get_routes_path_label_standard_array__param_(["a", "b"])
  standard_client.get_routes_path_label_standard_record__param_(mk_record())

  // label - explode
  explode_client.get_routes_path_label_explode_primitive__param__("a")
  explode_client.get_routes_path_label_explode_array__param__(["a", "b"])
  explode_client.get_routes_path_label_explode_record__param__(mk_record())

  // matrix - standard
  standard_client.get_routes_path_matrix_standard_primitive__param_("a")
  standard_client.get_routes_path_matrix_standard_array__param_(["a", "b"])
  standard_client.get_routes_path_matrix_standard_record__param_(mk_record())

  // matrix - explode
  explode_client.get_routes_path_matrix_explode_primitive__param__("a")
  explode_client.get_routes_path_matrix_explode_array__param__(["a", "b"])
  explode_client.get_routes_path_matrix_explode_record__param__(mk_record())
}

///|
async test "runtime routes: query expansions" {
  let query_client = @routes.QueryParametersClient::new("http://localhost:3000")
  let standard_client = @routes.StandardClient::new("http://localhost:3000")
  let explode_client = @routes.ExplodeClient::new("http://localhost:3000")
  query_client.get_routes_query_template_only__param_("a")
  query_client.get_routes_query_explicit__param_("a")
  query_client.get_routes_query_annotation_only__param_("a")

  // query expansion - standard
  standard_client.get_routes_query_query_expansion_standard_primitive__param_(
    "a",
  )
  standard_client.get_routes_query_query_expansion_standard_array__param_([
    "a", "b",
  ])
  standard_client.get_routes_query_query_expansion_standard_record__param_(
    mk_record(),
  )

  // query expansion - explode
  explode_client.get_routes_query_query_expansion_explode_primitive__param__(
    "a",
  )
  explode_client.get_routes_query_query_expansion_explode_array__param__([
    "a", "b",
  ])
  explode_client.get_routes_query_query_expansion_explode_record__param__(
    mk_record(),
  )

  // query continuation - standard (fixed=true)
  standard_client.get_routes_query_query_continuation_standard_primitive_fixed_true__param_(
    "a",
  )
  standard_client.get_routes_query_query_continuation_standard_array_fixed_true__param_([
      "a", "b",
    ],
  )
  standard_client.get_routes_query_query_continuation_standard_record_fixed_true__param_(
    mk_record(),
  )

  // query continuation - explode (fixed=true)
  explode_client.get_routes_query_query_continuation_explode_primitive_fixed_true__param__(
    "a",
  )
  explode_client.get_routes_query_query_continuation_explode_array_fixed_true__param__([
      "a", "b",
    ],
  )
  explode_client.get_routes_query_query_continuation_explode_record_fixed_true__param__(
    mk_record(),
  )
}

///|
fn mk_record() -> Map[String, Int] {
  let m = Map::new()
  m["a"] = 1
  m["b"] = 2
  m
}
