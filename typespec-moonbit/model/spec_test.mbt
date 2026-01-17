///|
test "read spec fixture" {
  let s = @fs.read_file_to_string("src/model/testdata/api.tps")
  inspect(
    s,
    content=(
      #|import "@typespec/http";
      #|
      #|using TypeSpec.Http;
      #|
      #|@service(#{ title: "demo" })
      #|namespace Demo {
      #|  @get @route("/ping")
      #|  op ping(): string;
      #|}
      #|
    ),
  )
}
