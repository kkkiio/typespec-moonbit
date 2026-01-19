# server

Server emitter 端到端测试。

## 测试流程

1. 先用 `tsp compile` 生成 server stub 工程到 `typespec-moonbit-tests/server/generated/`
2. 运行本目录的 `main.mbt`：
   - 在本进程内启动一个最小 `moonbitlang/async/http` server（用于承载被测场景）
   - 调用 `npx tsp-spector knock ... --baseUrl <url>` 跑场景并用退出码判定成功/失败

## 运行

仓库根目录执行：

```sh
npm run test:server
```
