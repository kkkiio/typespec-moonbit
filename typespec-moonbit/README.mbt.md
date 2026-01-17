# typespec-moonbit

TypeSpec emitter（MoonBit 实现，输出 MoonBit 代码）。

- 入口：`emitter.mbt` 的 `on_emit`（由仓库根 `index.js` 导出为 `$onEmit`）
- 生成逻辑：`tcgcadapter/` + `codemodel/` + `codegen/`

开发：

```bash
moon build --target js
```
