// 生成 MoonBit server stub e2e 用例（对齐 TypeSpec 官方 http-server-* 的思路）：
//   1) 先 build 我们的 emitter（MoonBit -> JS）
//   2) 再 `tsp compile` 生成一个可运行的 MoonBit server 工程（包含 moon.mod.json）
//
import { execSync } from "child_process";
import fs from "fs";
import path from "path";

const repoRoot = process.cwd();
const compiler = path.join(repoRoot, "node_modules/@typespec/compiler/cmd/tsp.js");

if (!fs.existsSync(compiler)) {
  throw new Error(`tsp 未安装: 缺少 ${compiler}`);
}

// 1) build emitters (MoonBit -> JS)
execSync("node .scripts/build_emitters.js --all", { stdio: "inherit" });

const cases = [
  {
    name: "local_server_events_dotted_name",
    input: path.join(repoRoot, "e2e/server/specs/events/dotted-name/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/events/dotted-name"),
  },
  {
    name: "http-specs_server_endpoint_not_defined",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/server/endpoint/not-defined/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/endpoint/not-defined"),
  },
  {
    name: "http-specs_server_path_multiple",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/server/path/multiple/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/path/multiple"),
  },
  {
    name: "http-specs_server_path_single",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/server/path/single/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/path/single"),
  },
  {
    name: "http-specs_server_versions_not_versioned",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/server/versions/not-versioned/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/versions/not-versioned"),
  },
  {
    name: "http-specs_server_versions_versioned",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/server/versions/versioned/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/versions/versioned"),
  },
  {
    name: "http-specs_parameters_basic",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/parameters/basic/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/parameters/basic"),
  },
  {
    name: "http-specs_parameters_body_optionality",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/parameters/body-optionality/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/parameters/body-optionality"),
  },
  {
    name: "http-specs_parameters_spread",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/parameters/spread/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/parameters/spread"),
  },
  {
    name: "http-specs_type_array",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/type/array/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/type/array"),
  },
  {
    name: "http-specs_type_dictionary",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/type/dictionary/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/type/dictionary"),
  },
  {
    name: "http-specs_type_enum_extensible",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/type/enum/extensible/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/type/enum/extensible"),
  },
  {
    name: "http-specs_type_model_empty",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/type/model/empty/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/type/model/empty"),
  },
  {
    name: "http-specs_type_model_inheritance_not_discriminated",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/type/model/inheritance/not-discriminated/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/type/model/inheritance/not-discriminated"),
  },
  {
    name: "http-specs_type_model_inheritance_recursive",
    input: path.join(repoRoot, "node_modules/@typespec/http-specs/specs/type/model/inheritance/recursive/main.tsp"),
    outputDir: path.join(repoRoot, "e2e/server/generated/type/model/inheritance/recursive"),
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
    `--emit=${path.join(repoRoot, "packages/typespec-moonbit-server")}`,
    `--option=typespec-moonbit-server.package-name=${c.name}`,
    `--option=typespec-moonbit-server.emitter-output-dir=${c.outputDir}`,
    `--output-dir=${c.outputDir}`,
  ];
  console.log(`generating ${c.name}`);
  execSync(cmd.join(" "), { stdio: "inherit" });
}
