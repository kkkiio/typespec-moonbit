# Project Agents.md Guide

本项目是一个 TypeSpec Emitter，核心逻辑完全由 MoonBit 编写并编译到 JS 后端。

本仓库拆分为多个 MoonBit module（对齐 typespec-rust 的“生成+测试”分层），避免把测试依赖/目标污染 emitter 模块.

In the module toplevel directory, this is a `moon.mod.json` file listing about the module and some meta information.

本仓库使用 `npm` 管理 Node.js 依赖。

## emitter

主模块（JS target），实现 TypeSpec emitter 核心逻辑与 JS FFI。

由于 TypeSpec 要求导出 `$onEmit`，而 MoonBit 函数名不能以 `$` 开头，因此采用最小 JS shim：MoonBit 导出 `on_emit`，`index.js` 只做 `$onEmit` 的导出别名。

- `emitter/config/`：Emitter 选项解析（`EmitterOptions`）与诊断上报封装（`program.reportDiagnostic`）。
- `emitter/ffi/`：Node.js 与 TypeSpec 编译器 API 的 JS FFI 包装（EmitContext 辅助）。
- `emitter/typespec/`：TypeSpec Program/TCGC 的读取与类型解析适配层。
- `emitter/mbtgen/`：MoonBit 源码渲染辅助（函数、结构、语句拼装）。
- `emitter/http_client/`：client emitter 入口（导出 `on_emit`）。
- `emitter/http_server/`：server emitter 入口（导出 `on_emit`）。

## client-runtime

Client 运行时模块，给生成的 client 代码提供公共辅助函数与运行时支撑（如请求构建、响应处理、通用编解码/错误封装等）。

- `client-runtime/`：仅面向生成的 client 代码提供依赖。
- 生成的 client 代码可以依赖 `client-runtime`。
- 生成的 client 代码**不允许**依赖 `server-runtime`。

## server-runtime

Server 运行时模块，给生成的 server 代码提供公共辅助函数与运行时支撑（如路由分发、请求上下文适配、响应回写等）。

- `server-runtime/`：仅面向生成的 server 代码提供依赖。
- 生成的 server 代码可以依赖 `server-runtime`。
- 生成的 server 代码**不允许**依赖 `client-runtime`。

Run `moon test` to check the test is passed.
MoonBit supports snapshot testing, so when your changes indeed change the behavior of the code, you should run `moon test --update` to update the snapshot.

When writing tests, you are encouraged to use `inspect` and run `moon test --update` to update the snapshots, only use assertions like `assert_eq` when you are in some loops where each snapshot may vary. 
You can use `moon coverage analyze > uncovered.log` to see which parts of your code are not covered by tests.

### Coding convention

MoonBit code is organized in block style, each block is separated by `///|`, the order of each block is irrelevant. In some refactorings, you can process block by block independently.

不要写非规范的 fallback 代码，所有不支持的场景都应该报错.

生成的代码不使用 `catch`, 让使用者自行决定错误处理策略.

生成的代码不允许用 `try!`, 避免内部直接 panic.

使用多行字符串(前缀 `#|` 或 `$|`, 后者允许插值) 来简化代码生成.

## tests

E2E 测试模块（native target），负责运行时验证与维护生成用例。

命令

- `cd tests && moon test`: 直接在 `tests` 目录运行全部测试。
- `npm run spector`: 启动/停止 Spector 测试服务器。
- `npm run gen:client-test`: 生成 Client 端测试代码（基于 `tspcompile.js`）。
- `npm run gen:server-test`: 生成 Server 端测试代码（基于 `emit_e2e_server.js`）。
- `npm run test:server`: **Server 端 E2E 测试**（生成代码 -> 编译 server -> 运行验证）。
- `npm run test:client`: **Client 端运行时测试**（生成代码 -> 运行 `moon test`）。

- `tests/server/`：server emitter 端到端测试。
  - `tests/server/generated/`：从 http-specs 生成的 MoonBit server router package（生成物进入 git，便于 review）。
  - `tests/server/*.mbt`：server-e2e 用例入口（native test），在同进程内启动 `moonbitlang/async/http` server，并 import 生成的 `dispatch` 后调用 `tsp-spector knock` 做运行时验证。
- `tests/client/`：client emitter 测试。
  - `tests/client/generated/`：从 http-specs/azure-http-specs 生成的 MoonBit client packages（生成物进入 git，便于 review）。
  - `tests/client/tests/`：运行时验证（native target），调用生成的 client 并断言结果（mock server 由脚本启动）。
- `node_modules/@typespec/http-specs/specs` 与 `node_modules/@azure-tools/azure-http-specs/specs`：spector 用例来源。

## 提交规范

- 使用 Conventional Commits（例如 `feat: ...`、`fix: ...`、`chore: ...`）。

## Tooling

- `moon fmt` is used to format your code properly.

- `moon info` is used to update the generated interface of the package, each
  package has a generated interface file `.mbti`, it is a brief formal
  description of the package. If nothing in `.mbti` changes, this means your
  change does not bring the visible changes to the external package users, it is
  typically a safe refactoring.

- In the last step, run:
  - `moon info -C emitter --target js && moon fmt -C emitter`
  - `cd tests && moon info --target native && moon fmt`
  Check the diffs of `.mbti` file to see if the changes are expected.

- You can run `moon check` to check the code is linted correctly.
