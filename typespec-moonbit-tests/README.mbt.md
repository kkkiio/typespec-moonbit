# typespec-moonbit-tests

端到端/运行时验证模块（native target）。

## 测试结构

- **Server Emitter 测试** (`server/`)：启动 MoonBit HTTP server 并调用 `tsp-spector knock` 验证
- **Client Emitter 测试** (`client/`)：调用生成的 client 发起请求（mock server 由脚本启动）

## 运行

```bash
# Server E2E 测试
npm run test:e2e-server

# Client Runtime 测试
npm run spector -- --start
npm run test:runtime
npm run spector -- --stop
```
