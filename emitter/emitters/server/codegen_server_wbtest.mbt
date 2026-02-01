///|
test "emit_server_files include sse" {
  let crate : @codemodel.Crate = {
    name: "test_crate",
    version: "0.1.0",
    clients: [
      @codemodel.Client::{
        name: "TestClient",
        methods: [
          @codemodel.Method::{
            name: "Stream",
            http_method: "GET",
            path: "/stream",
            status_code: 200,
            response_body: None,
            is_sse: true,
            parameters: [],
          },
        ],
      },
    ],
  }
  let files = emit_server_files(crate)
  let paths = files.map(fn(f) { f.path() })
  inspect(
    paths,
    content=(
      #|["moon.pkg.json", "README.mbt.md", "models.mbt", "router.mbt", "router_helpers.mbt", "event_stream.mbt"]
    ),
  )
}

///|
test "emit_server_router snapshot" {
  let crate : @codemodel.Crate = {
    name: "test_crate",
    version: "0.1.0",
    clients: [
      @codemodel.Client::{
        name: "TestClient",
        methods: [
          @codemodel.Method::{
            name: "GetItem",
            http_method: "GET",
            path: "/items/{itemId}",
            status_code: 200,
            response_body: None,
            is_sse: false,
            parameters: [
              @codemodel.Parameter::{
                name: "itemId",
                location: "path",
                type_: @codemodel.TypeRef::String,
              },
            ],
          },
          @codemodel.Method::{
            name: "CreateItem",
            http_method: "POST",
            path: "/items",
            status_code: 200,
            response_body: None,
            is_sse: false,
            parameters: [
              @codemodel.Parameter::{
                name: "body",
                location: "body",
                type_: @codemodel.TypeRef::Model(@codemodel.Model::{
                  name: "Item",
                  fields: [
                    @codemodel.ModelField::{
                      name: "name",
                      type_: @codemodel.TypeRef::String,
                      optional: false,
                    },
                  ],
                }),
              },
            ],
          },
        ],
      },
    ],
  }
  let router_code = emit_server_router(crate)
  inspect(
    router_code,
    content=(
      #|///|
      #|/// Traits for operation handlers
      #|pub(open) trait TestClientHandler {
      #|  async get_item(Self, group~ : @async.TaskGroup[Unit], item_id : String) -> Unit
      #|  async create_item(Self, group~ : @async.TaskGroup[Unit], body : Item) -> Unit
      #|  
      #|}
      #|///|
      #|/// 路由匹配结果。
      #|#warnings("-unused_constructor")
      #|pub enum RouteMatch {
      #|  /// 已命中并写入响应（或已开始 SSE）。
      #|  Handled
      #|  /// 路径完全不匹配。
      #|  NotMatched
      #|  /// 路径匹配但 method 不被支持（可用于返回 405）。
      #|  MethodNotAllowed
      #|}
      #|
      #|///|
      #|pub type Router = async (@http.Request, &@io.Reader, @http.ServerConnection) -> RouteMatch
      #|
      #|pub fn[H0 : TestClientHandler, ] create_router(
      #|  test_client_handler~ : H0,
      #|  
      #|  group~ : @async.TaskGroup[Unit],
      #|) -> Router {
      #|  async fn(req : @http.Request, body_stream : &@io.Reader, conn : @http.ServerConnection) -> RouteMatch {
      #|    let full_path = req.path
      #|    let path = strip_request_query(full_path)
      #|    
      #|    if req.meth == @http.Get && match_path_template("/items/{itemId}", path) {
      #|      ignore(body_stream)
      #|      
      #|      let p_1_item_id = get_path_param("/items/{itemId}", path, "itemId")
      #|      test_client_handler.get_item(group~, p_1_item_id,)
      #|      conn.send_response(200, "OK")
      #|      conn.end_response()
      #|      return RouteMatch::Handled
      #|    }
      #|    
      #|    if req.meth == @http.Post && match_path_template("/items", path) {
      #|      let body_bytes = body_stream.read_all()
      #|      let body_str = body_bytes.text()
      #|      
      #|      let p_2_body : Item = @json.from_json(@json.parse(body_str))
      #|      test_client_handler.create_item(group~, p_2_body,)
      #|      conn.send_response(200, "OK")
      #|      conn.end_response()
      #|      return RouteMatch::Handled
      #|    }
      #|    
      #|    // 未找到“method+path 完全匹配”的 handler。再判定是否是“path 匹配但 method 不支持”。
      #|    let mut path_matched = false
      #|    if match_path_template("/items/{itemId}", path) { path_matched = true }
      #|    if match_path_template("/items", path) { path_matched = true }
      #|    if path_matched { RouteMatch::MethodNotAllowed } else { RouteMatch::NotMatched }
      #|  }
      #|}
      #|
      #|///|
      #|/// 创建一个“带默认 fallback”的 dispatch（`async (...)->Unit`），便于直接挂到 http server。
      #|///
      #|/// - `Handled`：router 已写入响应
      #|/// - `MethodNotAllowed`：发送 405
      #|/// - `NotMatched`：发送 404
      #|pub fn create_dispatch(router : Router) -> async (@http.Request, &@io.Reader, @http.ServerConnection) -> Unit {
      #|  async fn(req : @http.Request, body_stream : &@io.Reader, conn : @http.ServerConnection) {
      #|    let result = router(req, body_stream, conn)
      #|    match result {
      #|      RouteMatch::Handled => ()
      #|      RouteMatch::MethodNotAllowed => {
      #|        conn.send_response(405, "Method Not Allowed")
      #|        conn.end_response()
      #|      }
      #|      RouteMatch::NotMatched => {
      #|        conn.send_response(404, "Not Found")
      #|        conn.write("not found")
      #|        conn.end_response()
      #|      }
      #|    }
      #|  }
      #|}
      #|
    ),
  )
}

///|
test "server codegen has no mustache markers" {
  let crate : @codemodel.Crate = {
    name: "test_crate",
    version: "0.1.0",
    clients: [
      @codemodel.Client::{
        name: "TestClient",
        methods: [
          @codemodel.Method::{
            name: "GetItem",
            http_method: "GET",
            path: "/items/{itemId}",
            status_code: 200,
            response_body: None,
            is_sse: false,
            parameters: [
              @codemodel.Parameter::{
                name: "itemId",
                location: "path",
                type_: @codemodel.TypeRef::String,
              },
            ],
          },
        ],
      },
    ],
  }
  let router_code = emit_server_router(crate)
  assert_false(router_code.contains("{{"))
  assert_false(router_code.contains("}}"))
}
