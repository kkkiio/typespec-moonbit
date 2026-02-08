# typespec-moonbit

TypeSpec emitter（MoonBit 实现，输出 MoonBit 代码）。

- Client 入口：`http_client/emitter.mbt` 的 `on_emit`
- Server 入口：`http_server/emitter.mbt` 的 `on_emit`
- 生成逻辑：以 `typespec/` + `http_client/` + `http_server/` 为主

## 开发

```bash
moon build --target js
```
