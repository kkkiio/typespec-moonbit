// 生成 MoonBit server stub e2e 用例（对齐 TypeSpec 官方 http-server-* 的思路）：
//   1) 先 build 我们的 emitter（MoonBit -> JS）
//   2) 再 `tsp compile` 生成一个可运行的 MoonBit server 工程（包含 moon.mod.json）
//
import fs from "fs";
import path from "path";
import { execSync } from "child_process";

const repoRoot = process.cwd();
const compiler = path.join(repoRoot, "node_modules/@typespec/compiler/cmd/tsp.js");

if (!fs.existsSync(compiler)) {
  throw new Error(`tsp 未安装: 缺少 ${compiler}`);
}

// 1) build emitter (MoonBit -> JS)
execSync("moon build -C typespec-moonbit --target js", { stdio: "inherit" });

const cases = [
  {
    name: "http-specs_server_endpoint_not_defined",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/server/endpoint/not-defined/main.tsp"),
    outputDir: path.join(repoRoot, "typespec-moonbit-tests/e2e/generated/server/endpoint/not-defined"),
  },
  {
    name: "http-specs_server_path_multiple",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/server/path/multiple/main.tsp"),
    outputDir: path.join(repoRoot, "typespec-moonbit-tests/e2e/generated/server/path/multiple"),
  },
  {
    name: "http-specs_server_path_single",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/server/path/single/main.tsp"),
    outputDir: path.join(repoRoot, "typespec-moonbit-tests/e2e/generated/server/path/single"),
  },
  {
    name: "http-specs_server_versions_not_versioned",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/server/versions/not-versioned/main.tsp"),
    outputDir: path.join(repoRoot, "typespec-moonbit-tests/e2e/generated/server/versions/not-versioned"),
  },
  {
    name: "http-specs_server_versions_versioned",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/server/versions/versioned/main.tsp"),
    outputDir: path.join(repoRoot, "typespec-moonbit-tests/e2e/generated/server/versions/versioned"),
  },
];

for (const c of cases) {
  if (!fs.existsSync(c.input)) {
    throw new Error(`缺少 TypeSpec 用例: ${c.input}`);
  }
  fs.rmSync(c.outputDir, { recursive: true, force: true });
  fs.mkdirSync(c.outputDir, { recursive: true });

  const cmd = [
    "node",
    compiler,
    "compile",
    c.input,
    `--emit=${repoRoot}`,
    `--option=typespec-moonbit.package-name=${c.name}`,
    `--option=typespec-moonbit.emit-kind=server`,
    `--output-dir=${c.outputDir}`,
  ];
  console.log(`generating ${c.name}`);
  execSync(cmd.join(" "), { stdio: "inherit" });
}
