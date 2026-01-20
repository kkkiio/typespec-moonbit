# Project Agents.md Guide

本项目是一个 TypeSpec Emitter，核心逻辑完全由 MoonBit 编写并编译到 JS 后端。

由于 TypeSpec 要求导出 `$onEmit`，而 MoonBit 函数名不能以 `$` 开头，因此采用最小 JS shim：MoonBit 导出 `on_emit`，`index.js` 只做 `$onEmit` 的导出别名。

本仓库拆分为两个 MoonBit module（对齐 typespec-rust 的“生成+测试”分层），避免把测试依赖/目标污染 emitter 模块.

## typespec-moonbit

主模块（JS target），实现 TypeSpec emitter 核心逻辑与 JS FFI。

- `typespec-moonbit/emitter.mbt`：入口函数 `on_emit`（由 `index.js` 导出为 `$onEmit`）。
- `typespec-moonbit/config/`：Emitter 选项解析（`EmitterOptions`）与诊断上报封装（`program.reportDiagnostic`）。
- `typespec-moonbit/tcgcadapter/`：TypeSpec Program/TCGC 到 CodeModel 的适配层。
- `typespec-moonbit/codemodel/`：内部中间模型（Crate/Client/Method 等），与 TypeSpec AST 解耦。
- `typespec-moonbit/codegen/`：把 CodeModel 渲染成 MoonBit 源码文本与文件列表。
- `typespec-moonbit/ffi/`：Node.js 与 TypeSpec 编译器 API 的 JS FFI 包装（EmitContext 辅助）。

## typespec-moonbit-tests

E2E 测试模块（native target），负责运行时验证与维护生成用例。

命令

- `npm run spector`: 启动/停止 Spector 测试服务器。
- `npm run gen:client-test`: 生成 Client 端测试代码（基于 `tspcompile.js`）。
- `npm run gen:server-test`: 生成 Server 端测试代码（基于 `emit_e2e_server.js`）。
- `npm run test:server`: **Server 端 E2E 测试**（生成代码 -> 编译 server -> 运行验证）。
- `npm run test:client`: **Client 端运行时测试**（生成代码 -> 运行 `moon test`）。

- `typespec-moonbit-tests/server/`：server emitter 端到端测试。
  - `typespec-moonbit-tests/server/generated/`：从 http-specs 生成的 MoonBit server router package（生成物进入 git，便于 review）。
  - `typespec-moonbit-tests/server/main.mbt`：server-e2e 驱动（native 可执行），在同进程内启动 `moonbitlang/async/http` server，并 import 生成的 `dispatch` 后调用 `tsp-spector knock` 做运行时验证。
- `typespec-moonbit-tests/client/`：client emitter 测试。
  - `typespec-moonbit-tests/client/generated/`：从 http-specs/azure-http-specs 生成的 MoonBit client packages（生成物进入 git，便于 review）。
  - `typespec-moonbit-tests/client/tests/`：运行时验证（native target），调用生成的 client 并断言结果（mock server 由脚本启动）。
- `node_modules/@typespec/http-specs/specs` 与 `node_modules/@azure-tools/azure-http-specs/specs`：spector 用例来源。

## 提交规范

- 使用 Conventional Commits（例如 `feat: ...`、`fix: ...`、`chore: ...`）。

## Project Structure

- MoonBit packages are organized per directory, for each directory, there is a
  `moon.pkg.json` file listing its dependencies. Each package has its files and
  blackbox test files (common, ending in `_test.mbt`) and whitebox test files
  (ending in `_wbtest.mbt`).

- In the toplevel directory, this is a `moon.mod.json` file listing about the
  module and some meta information.

## Coding convention

- MoonBit code is organized in block style, each block is separated by `///|`,
  the order of each block is irrelevant. In some refactorings, you can process
  block by block independently.

- Try to keep deprecated blocks in file called `deprecated.mbt` in each
  directory.

## Tooling

- `moon fmt` is used to format your code properly.

- `moon info` is used to update the generated interface of the package, each
  package has a generated interface file `.mbti`, it is a brief formal
  description of the package. If nothing in `.mbti` changes, this means your
  change does not bring the visible changes to the external package users, it is
  typically a safe refactoring.

- In the last step, run `moon info && moon fmt` to update the interface and
  format the code. Check the diffs of `.mbti` file to see if the changes are
  expected.

- Run `moon test` to check the test is passed. MoonBit supports snapshot
  testing, so when your changes indeed change the behavior of the code, you
  should run `moon test --update` to update the snapshot.

- You can run `moon check` to check the code is linted correctly.

- When writing tests, you are encouraged to use `inspect` and run
  `moon test --update` to update the snapshots, only use assertions like
  `assert_eq` when you are in some loops where each snapshot may vary. You can
  use `moon coverage analyze > uncovered.log` to see which parts of your code
  are not covered by tests.

- agent-todo.md has some small tasks that are easy for AI to pick up, agent is
  welcome to finish the tasks and check the box when you are done
