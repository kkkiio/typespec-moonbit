///|
/// 生成器输出文件描述（相对路径 + 内容）。
pub struct OutputFile {
  path : String
  content : String
}

///|
/// 构建 OutputFile。
pub fn OutputFile::new(path : String, content : String) -> OutputFile {
  { path, content }
}

///|
/// 获取相对路径。
pub fn OutputFile::path(self : OutputFile) -> String {
  self.path
}

///|
/// 获取文件内容。
pub fn OutputFile::content(self : OutputFile) -> String {
  self.content
}
