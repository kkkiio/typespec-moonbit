# ffi

对 Node.js 与 TypeSpec 编译器 API 的最小封装层。

当前仅保留 `EmitContext` 相关辅助函数，文件系统与路径操作改用 `moonbitlang/x/fs` 与 `moonbitlang/x/path`。
