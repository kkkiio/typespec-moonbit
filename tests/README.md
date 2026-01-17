# tests

端到端测试入口（对齐 typespec-rust 的 “生成用例进仓库 + 运行时验证” 模式）。

- 生成用例：`typespec-moonbit-tests/generated_cases/*`（由 `npm run tspcompile` 生成并提交到 git）。
- 运行时验证：`typespec-moonbit-tests/runtime/*`（native target，启动 `tsp-spector` 并调用生成的 client）。

## 运行方式

- 对齐 typespec-rust 的 spector 脚本：
  - `npm run spector -- --start`
  - `npm run spector -- --stop`
- 重新生成用例（默认跑全部）：
  - `npm run tspcompile`
- 运行时验证（native target，默认先生成用例；要求 spector server 已启动）：
  - `npm run test:e2e`
- 仅跑 routes 用例并做运行时验证：
  - `npm run test:runtime`
