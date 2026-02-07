///|
/// 基于“生成的 router 代码”的 match_route benchmark（linear cases）。
///
/// 这里只测纯匹配：`@type_array.match_route`，不包含 body 解析/handler/写响应。
///
test "bench/match_route" {
  let cases : Array[(@http.RequestMethod, String)] = [
    // 命中（静态）
    (@http.Get, "/type/array/int32"),
    (@http.Put, "/type/array/int32"),
    (@http.Get, "/type/array/nullable-model"),
    (@http.Put, "/type/array/nullable-model"),
    // 带 query（测试 strip_request_query 成本）
    (@http.Get, "/type/array/int32?x=1"),
    (@http.Put, "/type/array/int32?x=1&y=2"),
    // 405
    (@http.Post, "/type/array/int32"),
    // 404
    (@http.Get, "/type/array/not-exist"),
    (@http.Get, "/no/such/path"),
  ]

  // 放大单次 bench 的工作量，降低噪声。
  let repeat = 2000
  let mut saved = 0
  let summary : @bench.Summary = @bench.single_bench(
    name="generated_match_route_type_array",
    fn() {
      let mut acc = 0
      for _ in 0..<repeat {
        for c in cases {
          let (meth, path) = c
          let r : @type_array.MatchRouteResult = @type_array.match_route(
            meth, path,
          )
          match r {
            Matched(_) => acc += 1
            MethodNotAllowed => acc += 2
            NotMatched => acc += 3
          }
        }
      }
      saved = acc
    },
  )
  println(saved)
  println(summary.to_json().stringify(escape_slash=true, indent=2))
}
