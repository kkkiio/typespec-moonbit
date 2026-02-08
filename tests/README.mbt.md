# typespec-moonbit-tests

端到端/运行时验证模块（native target）。

## 测试结构

- **Server Emitter 测试** (`server/`)：启动 MoonBit HTTP server 并调用 `tsp-spector knock` 验证
- **Client Emitter 测试** (`client/`)：调用生成的 client 发起请求（mock server 由脚本启动）

## 运行

```bash
# 在 tests 目录直接运行全部测试
moon test

# 仅运行 Server E2E 测试
moon test -p kkkiio/typespec-tests/server

# 仅运行 Client Runtime 测试
moon test --target native -p kkkiio/typespec-tests/client/tests
```

如果你希望通过仓库根目录脚本串联生成流程（以下命令在仓库根目录执行），可以使用：

```bash
npm run spector -- --start
npm run test:client
npm run spector -- --stop
```
