# lib

本包定义 TypeSpec emitter 的公共选项与诊断上报逻辑。
- `options.mbt`：解析 `context.options` 并提供默认值。
- `diagnostics.mbt`：封装 `program.reportDiagnostic` 的调用与诊断码枚举。
