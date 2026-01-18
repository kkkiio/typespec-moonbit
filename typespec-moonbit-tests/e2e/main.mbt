///|
/// server e2e 测试入口。
///
/// 本程序会：
/// 1) 在本进程内启动一个最小的 HTTP server（用于承载 spector 场景）；
/// 2) 调用 `npx tsp-spector knock ...` 对该 server 发起请求并验收；
/// 3) 若 spector 失败则直接终止（使 CI/脚本失败）。
async fn main {
  let repo_root = find_repo_root()
  let specs_root = "\{repo_root}/node_modules/@typespec/http-specs/specs"

  // 先启动一个最小 server：目前只覆盖 `server/path/single` 用例。
  let addr = @socket.Addr::parse("127.0.0.1:0") catch {
    _ => abort("failed to parse listen addr")
  }
  let server = @http.Server::new(addr) catch {
    _ => abort("failed to create http server")
  }
  let port = server.addr().port()
  let base_url = "http://localhost:\{port}"

  @async.with_task_group(group => {
    // server.run_forever 会阻塞；作为后台任务运行，且不阻塞本组结束。
    group.spawn_bg(no_wait=true, fn() {
      server.run_forever((req, body, conn) => serve(req, body, conn))
    })

    let exit_code = @process.run(
      "npx",
      [
        "tsp-spector",
        "knock",
        specs_root,
        "--filter",
        "server/path/single/**/*",
        "--baseUrl",
        base_url,
      ],
      cwd=repo_root,
    )
    if exit_code != 0 {
      abort("tsp-spector failed: exit_code=\{exit_code}")
    }
  })
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
/// 最小 server 实现：用于 `server/path/single` spector 场景。
async fn serve(
  request : @http.Request,
  _body : &@io.Reader,
  conn : @http.ServerConnection,
) -> Unit {
  if request.meth == @http.Head && request.path == "/server/path/single/myOp" {
    let _ = conn.send_response(200, "OK")
    return
  }
  conn
    ..send_response(404, "NotFound")
    ..write("not found")
}
