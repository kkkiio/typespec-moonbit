# typespec-moonbit-tests

端到端/运行时验证模块（native target）。

- 生成用例：`generated_cases/*`（生成物提交到 git）
- 运行时验证：`runtime/*`（启动 `tsp-spector` 并调用生成 client）

运行：

```bash
# 生成用例并跑 runtime 测试
npm run test:e2e
```
