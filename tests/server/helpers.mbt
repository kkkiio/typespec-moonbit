///|
pub fn[X] start_server(
  group : @async.TaskGroup[X],
  dispatch : async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit,
) -> String raise {
  let addr = @socket.Addr::parse("127.0.0.1:0")
  let server = @http.Server::new(addr)
  let port = server.addr().port()
  let base_url = "http://localhost:\{port}"
  group.spawn_bg(no_wait=true, () => { // see moonbitlang/async/src/websocket/external_client_test.mbt
    server.run_forever(
      (req, body, conn) => dispatch(req, body, conn),
      allow_failure=true,
    )
  })
  base_url
}
