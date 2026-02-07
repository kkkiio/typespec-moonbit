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
            success_responses: [
              { status: @codemodel.StatusMatcher::Code(200), body: None },
            ],
            is_sse: true,
            sse_event_union: Some(@codemodel.Union::{
              name: "TaskEvents",
              variants: [
                @codemodel.UnionVariant::{
                  name: "message",
                  type_: @codemodel.TypeRef::String,
                },
              ],
            }),
            sse_error_responses: [],
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
      #|["moon.pkg.json", "README.mbt.md", "models.mbt", "router.mbt"]
    ),
  )
}

///|
test "emit_server_router snapshot" (t : @test.Test) {
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
            success_responses: [
              { status: @codemodel.StatusMatcher::Code(200), body: None },
            ],
            is_sse: false,
            sse_event_union: None,
            sse_error_responses: [],
            parameters: [
              @codemodel.Parameter::{
                name: "itemId",
                location: "path",
                type_: @codemodel.TypeRef::String,
                optional: false,
                explode: false,
                array_encoding: None,
              },
            ],
          },
          @codemodel.Method::{
            name: "CreateItem",
            http_method: "POST",
            path: "/items",
            status_code: 200,
            response_body: None,
            success_responses: [
              { status: @codemodel.StatusMatcher::Code(200), body: None },
            ],
            is_sse: false,
            sse_event_union: None,
            sse_error_responses: [],
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
                optional: false,
                explode: false,
                array_encoding: None,
              },
            ],
          },
        ],
      },
    ],
  }
  let router_code = emit_server_router(crate)
  t.write(router_code)
  t.snapshot(filename="generate_router.mbt")
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
            success_responses: [
              { status: @codemodel.StatusMatcher::Code(200), body: None },
            ],
            is_sse: false,
            sse_event_union: None,
            sse_error_responses: [],
            parameters: [
              @codemodel.Parameter::{
                name: "itemId",
                location: "path",
                type_: @codemodel.TypeRef::String,
                optional: false,
                explode: false,
                array_encoding: None,
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
