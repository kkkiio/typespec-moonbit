# client/tests

运行时验证（native target），调用由 emitter 生成的 client。

- 使用 `client/generated/*` 下生成的 client 发起请求
- 运行前需启动 `tsp-spector`

## 运行

```bash
npm run spector -- --start
npm run test:client
npm run spector -- --stop
```

运行流程会先执行 `tsp compile`，把生成物写入并提交到 `tests/client/generated/*`（对齐 typespec-rust 的测试策略）。
