///|
/// 由 TypeSpec 生成的 HTTP server 入口。
///
/// 启动后会在 stdout 输出一行：`BASE_URL=<url>`，供 e2e 测试读取。
async fn main {
  let args = @env.args()
  let listen = if args.length() > 1 { args[1] } else { "127.0.0.1:0" }
  let addr = @socket.Addr::parse(listen) catch { _ => @socket.Addr::parse("127.0.0.1:0") }
  let server = @http.Server::new(addr)
  let port = server.addr().port()
  println("BASE_URL=http://localhost:\{port}")
  server.run_forever((request, body, conn) => dispatch(request, body, conn))
}

///|
/// 请求分发：按 method + path 路由到具体操作。
pub async fn dispatch(
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
