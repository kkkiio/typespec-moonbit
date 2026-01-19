///|
/// server e2e 测试入口。
///
/// 本程序会：
/// 1) 启动由 emitter 生成的 MoonBit server 路由包（在本进程内运行）；
/// 2) 调用 `npx tsp-spector knock ...` 对该 server 发起请求并验收；
/// 3) 若 spector 失败则直接终止（使 CI/脚本失败）。
async fn main {
  let repo_root = find_repo_root()
  let specs_root = "\{repo_root}/node_modules/@typespec/http-specs/specs"

  run_one_case(
    repo_root,
    specs_root,
    "server/endpoint/notdefined/*",
    @srv_endpoint_not_defined.dispatch,
  )
  run_one_case(
    repo_root,
    specs_root,
    "server/path/multiple/*",
    @srv_path_multiple.dispatch,
  )
  run_one_case(
    repo_root,
    specs_root,
    "server/path/single/*",
    @srv_path_single.dispatch,
  )
  run_one_case(
    repo_root,
    specs_root,
    "server/versions/notversioned/*",
    @srv_versions_not_versioned.dispatch,
  )
  run_one_case(
    repo_root,
    specs_root,
    "server/versions/versioned/*",
    @srv_versions_versioned.dispatch,
  )
}

///|
/// 发现仓库根目录（以 `package.json` 为锚点）。
fn find_repo_root() -> String {
  let cwd = match @env.current_dir() {
    Some(dir) => dir
    None => "."
  }
  let mut p : @path.Path = cwd
  for _ in 0..<16 {
    let candidate : @path.Path = p.join("package.json")
    if @fs.path_exists(candidate.to_string()) {
      return p.to_string()
    }
    let parent : @path.Path = p.dirname()
    if parent == p {
      break
    }
    p = parent
  }
  "."
}

///|
/// 执行单个 http-specs/server 用例：
/// - 在本进程内启动 server；
/// - 运行 `tsp-spector knock`；
/// - 停止 server。
type DispatchFn = async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit

///|
async fn run_one_case(
  repo_root : String,
  specs_root : String,
  filter : String,
  dispatch : DispatchFn,
) -> Unit {
  let addr = @socket.Addr::parse("127.0.0.1:0") catch {
    _ => abort("failed to parse listen addr")
  }
  let server = @http.Server::new(addr) catch {
    _ => abort("failed to create http server")
  }
  let port = server.addr().port()
  let base_url = "http://localhost:\{port}"

  @async.with_task_group(fn(group) {
    group.spawn_bg(no_wait=true, fn() {
      server.run_forever((req, body, conn) => dispatch(req, body, conn), allow_failure=true)
    })
    // 给 accept loop 一点启动时间，避免极小概率的 race。
    @async.sleep(50)

    let exit_code = @process.run(
      "npx",
      [
        "tsp-spector",
        "knock",
        specs_root,
        "--filter",
        filter,
        "--baseUrl",
        base_url,
      ],
      cwd=repo_root,
    )
    server.close()
    if exit_code != 0 {
      abort("tsp-spector failed: filter=\{filter} exit_code=\{exit_code}")
    }
  })
}
