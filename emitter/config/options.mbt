///|
/// Emitter 可配置选项集合。
pub struct EmitterOptions {
  package_name : String
  package_version : String
  module_name : String
  overwrite_moon_pkg : Bool
  overwrite_readme : Bool
  omit_doc_links : Bool
}

///|
/// 默认选项值。
pub fn EmitterOptions::defaults() -> EmitterOptions {
  {
    package_name: "typespec-moonbit",
    package_version: "0.1.0",
    module_name: "typespec_moonbit",
    overwrite_moon_pkg: false,
    overwrite_readme: false,
    omit_doc_links: false,
  }
}

///|
/// 从 EmitContext 读取 `options` 并构建 EmitterOptions。
pub fn EmitterOptions::from_context(
  context : @ffi.EmitContext,
) -> EmitterOptions {
  let defaults = EmitterOptions::defaults()
  let options : @ffi.JsValue = @ffi.get_value(context, "options")
  {
    package_name: @ffi.get_optional_string(
      options,
      "package-name",
      defaults.package_name,
    ),
    package_version: @ffi.get_optional_string(
      options,
      "package-version",
      defaults.package_version,
    ),
    module_name: @ffi.get_optional_string(
      options,
      "module-name",
      defaults.module_name,
    ),
    overwrite_moon_pkg: @ffi.get_optional_bool(
      options,
      "overwrite-moon-pkg",
      defaults.overwrite_moon_pkg,
    ),
    overwrite_readme: @ffi.get_optional_bool(
      options,
      "overwrite-readme",
      defaults.overwrite_readme,
    ),
    omit_doc_links: @ffi.get_optional_bool(
      options,
      "omit-doc-links",
      defaults.omit_doc_links,
    ),
  }
}

///|
/// 获取包名。
pub fn EmitterOptions::package_name(self : EmitterOptions) -> String {
  self.package_name
}

///|
/// 获取包版本。
pub fn EmitterOptions::package_version(self : EmitterOptions) -> String {
  self.package_version
}

///|
/// 获取 MoonBit module 名称。
pub fn EmitterOptions::module_name(self : EmitterOptions) -> String {
  self.module_name
}

///|
/// 是否允许覆盖 moon.pkg。
pub fn EmitterOptions::overwrite_moon_pkg(self : EmitterOptions) -> Bool {
  self.overwrite_moon_pkg
}

///|
/// 是否允许覆盖 README.mbt.md。
pub fn EmitterOptions::overwrite_readme(self : EmitterOptions) -> Bool {
  self.overwrite_readme
}

///|
/// 是否省略文档链接。
pub fn EmitterOptions::omit_doc_links(self : EmitterOptions) -> Bool {
  self.omit_doc_links
}
