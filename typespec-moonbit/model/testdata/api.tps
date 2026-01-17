import "@typespec/http";

using TypeSpec.Http;

@service(#{ title: "demo" })
namespace Demo {
  @get @route("/ping")
  op ping(): string;
}
