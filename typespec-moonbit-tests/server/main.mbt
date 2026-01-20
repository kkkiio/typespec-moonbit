///|
/// server e2e 测试入口。
///
/// 本程序会：
/// 1) 启动由 emitter 生成的 MoonBit server 路由包（在本进程内运行）；
/// 2) 调用 `npx tsp-spector knock ...` 对该 server 发起请求并验收；
/// 3) 若 spector 失败则直接终止（使 CI/脚本失败）。
// async fn main {
// let repo_root = find_repo_root()
// let specs_root = "\{repo_root}/node_modules/@typespec/http-specs/specs"
// run_one_case(
//   repo_root, specs_root, "server/endpoint/notdefined/*", @srv_endpoint_not_defined.dispatch,
// )
// run_one_case(
//   repo_root, specs_root, "server/path/multiple/*", @srv_path_multiple.dispatch,
// )
// run_one_case(
//   repo_root, specs_root, "server/path/single/*", @srv_path_single.dispatch,
// )
// run_one_case(
//   repo_root, specs_root, "server/versions/notversioned/*", @srv_versions_not_versioned.dispatch,
// )
// run_one_case(
//   repo_root, specs_root, "server/versions/versioned/*", @srv_versions_versioned.dispatch,
// )
// }

///|
/// parameters/body-optionality
test "parameters/body-optionality" {
  // 原测试: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/parameters/body-optionality/main.test.e2e.ts
  inspect(
    "TODO: implement parameters/body-optionality",
    content="TODO: implement parameters/body-optionality",
  )
}

///|
/// parameters/spread
test "parameters/spread" {
  // 原测试: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/parameters/spread/main.test.e2e.ts
  inspect(
    "TODO: implement parameters/spread",
    content="TODO: implement parameters/spread",
  )
}

///|
/// type/array
test "type/array" {
  // 原测试: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/array/main.test.e2e.ts
  inspect("TODO: implement type/array", content="TODO: implement type/array")
}

///|
/// type/dictionary
test "type/dictionary" {
  // 原测试: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/dictionary/main.test.e2e.ts
  inspect(
    "TODO: implement type/dictionary",
    content="TODO: implement type/dictionary",
  )
}

///|
/// type/enum/extensible
test "type/enum/extensible" {
  // 原测试: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/enum/extensible/main.test.e2e.ts
  inspect(
    "TODO: implement type/enum/extensible",
    content="TODO: implement type/enum/extensible",
  )
}

///|
/// type/model/empty
test "type/model/empty" {
  // 原测试: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/model/empty/main.test.e2e.ts
  inspect(
    "TODO: implement type/model/empty",
    content="TODO: implement type/model/empty",
  )
}

///|
/// type/model/inheritance/not-discriminated
test "type/model/inheritance/not-discriminated" {
  // 原测试: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/model/inheritance/not-discriminated/main.test.e2e.ts
  inspect(
    "TODO: implement type/model/inheritance/not-discriminated",
    content="TODO: implement type/model/inheritance/not-discriminated",
  )
}

///|
/// type/model/inheritance/recursive
test "type/model/inheritance/recursive" {
  // 原测试: .moonagent/repos/typespec/packages/http-server-js/test/e2e/http/type/model/inheritance/recursive/main.test.e2e.ts
  inspect(
    "TODO: implement type/model/inheritance/recursive",
    content="TODO: implement type/model/inheritance/recursive",
  )
}

///|
/// 执行单个 http-specs/server 用例：
/// - 在本进程内启动 server；
/// - 运行 `tsp-spector knock`；
/// - 停止 server。
type DispatchFn = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit
