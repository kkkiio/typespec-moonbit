///|
pub fn on_emit(context : @diagnostics.EmitContext) -> @js.Promise {
  @js.Promise::unsafe_new(async fn() { on_emit_async(context) })
}

///|
pub async fn on_emit_async(context : @diagnostics.EmitContext) -> Unit {
  let options = EmitterOptions::from_context(context)
  let program = @diagnostics.program(context)
  let http_services = @typespec.get_all_http_services_async(program)
  let services = collect_server_services(http_services)
  let files = emit_http_server_files(services, options)
  let out_dir = @diagnostics.emitter_output_dir(context)
  @fs.create_dir(out_dir)
  for file in files {
    let rel_path = file.path()
    let full_path = join_path(out_dir, rel_path)
    if @fs.path_exists(full_path) && !should_overwrite(rel_path, options) {
      @diagnostics.report_file_already_exists(context, full_path)
    } else {
      @fs.write_string_to_file(full_path, file.content())
    }
  }
  @mbtgen.exec_moon_fmt(out_dir)
}

///|
priv struct GeneratedFile {
  path : String
  content : String
}

///|
fn GeneratedFile::new(path : String, content : String) -> GeneratedFile {
  { path, content }
}

///|
fn GeneratedFile::path(self : GeneratedFile) -> String {
  self.path
}

///|
fn GeneratedFile::content(self : GeneratedFile) -> String {
  self.content
}

///|
fn should_overwrite(path : String, options : EmitterOptions) -> Bool {
  if path == "moon.pkg" {
    options.overwrite_moon_pkg()
  } else {
    true
  }
}

///|
fn emit_http_server_files(
  services : Array[ServerService],
  options : EmitterOptions,
) -> Array[GeneratedFile] raise {
  let pkg_name = options.package_name()
  guard pkg_name.length() > 0 else { fail("package-name cannot be empty") }
  let models = emit_models_file(services)
  let type_ctx = build_encode_type_context_for_server(
    collect_all_operations(services),
  )
  let router = emit_router_file(services, type_ctx)
  [
    GeneratedFile::new("moon.pkg", emit_server_moon_pkg(pkg_name)),
    GeneratedFile::new("models.mbt", models),
    GeneratedFile::new("router.mbt", router),
  ]
}

///|
fn emit_server_moon_pkg(package_name : String) -> String {
  ignore(package_name)
  (
    #|import {
    #|  "moonbitlang/core/json",
    #|  "moonbitlang/async",
    #|  "moonbitlang/async/http",
    #|  "moonbitlang/async/io",
    #|  "moonbitlang/async/aqueue",
    #|  "kkkiio/typespec-server-runtime" as @runtime,
    #|}
  )
}
