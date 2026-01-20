// export function startServer(router: BasicRouter, abortSignal: AbortSignal): Promise<string> {
//   return new Promise<string>((resolve, reject) => {
//     if (abortSignal.aborted) {
//       return reject(new Error("Server start cancelled"));
//     }
//     const server = createServer((req, res) => router.dispatch(req, res));
//     const stop = () => {
//       return new Promise<void>((r) => {
//         server.close(() => r);
//         server.closeAllConnections();
//       });
//     };
//     abortSignal.addEventListener("abort", () => {
//       stop().catch(() => {});
//     });
//     server.listen(function (this: Server) {
//       const address = this.address();
//       if (!address) {
//         reject(new Error("Server address not available"));
//         stop().catch(() => {});
//         return;
//       }

//       resolve(typeof address === "string" ? address : `http://localhost:${address.port}`);
//     });
//     server.on("error", reject);
//   });
// }

///|
pub fn[X] start_server(
  group : @async.TaskGroup[X],
  dispatch : DispatchFn,
) -> String raise {
  let addr = @socket.Addr::parse("127.0.0.1:0")
  let server = @http.Server::new(addr)
  let port = server.addr().port()
  let base_url = "http://localhost:\{port}"
  group.spawn_bg(no_wait=true, fn() { // see moonbitlang/async/src/websocket/external_client_test.mbt
    server.run_forever(
      (req, body, conn) => dispatch(req, body, conn),
      allow_failure=true,
    )
  })
  base_url
}
