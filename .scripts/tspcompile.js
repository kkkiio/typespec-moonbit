// Regenerate TypeSpec spector test cases (aligned with typespec-rust's `tspcompile` idea).
//
// Output layout (committed to git):
//   e2e/generated_cases/<case>/
//
import { execSync } from "child_process";
import fs from "fs";
import path from "path";

const repoRoot = process.cwd();
const args = process.argv.slice(2);

let filter = "";
let limit = -1;
let verbose = false;

for (const arg of args) {
  const filterArg = arg.match(/--filter=(?<filter>.+)/);
  if (filterArg?.groups?.filter) {
    filter = filterArg.groups.filter;
  }
  const limitArg = arg.match(/--limit=(?<limit>\d+)/);
  if (limitArg?.groups?.limit) {
    limit = Number.parseInt(limitArg.groups.limit, 10);
  }
  if (arg === "--verbose") {
    verbose = true;
  }
}

const compiler = path.join(repoRoot, "node_modules/@typespec/compiler/cmd/tsp.js");
const emitterDir = path.join(repoRoot, "packages/typespec-moonbit-client");

if (!fs.existsSync(compiler)) {
  throw new Error(`tsp 未安装: 缺少 ${compiler}`);
}
if (!fs.existsSync(emitterDir)) {
  throw new Error(`缺少 client emitter 目录: ${emitterDir}`);
}

// 1) build emitters (MoonBit -> JS)
execSync("npm run build:emitters", { stdio: "inherit" });

const cases = [
  {
    name: "spector_routes",
    input: path.join(
      repoRoot,
      "node_modules/@typespec/http-specs/specs/routes/main.tsp",
    ),
    outputDir: path.join(
      repoRoot,
      "e2e/client/generated/routes",
    ),
  },
  {
    name: "parameters_basic",
    input: path.join(
      repoRoot,
      "node_modules/@typespec/http-specs/specs/parameters/basic/main.tsp",
    ),
    outputDir: path.join(
      repoRoot,
      "e2e/client/generated/parameters/basic",
    ),
  },
  {
    name: "parameters_body_optionality",
    input: path.join(
      repoRoot,
      "node_modules/@typespec/http-specs/specs/parameters/body-optionality/main.tsp",
    ),
    outputDir: path.join(
      repoRoot,
      "e2e/client/generated/parameters/body-optionality",
    ),
  },
  {
    name: "parameters_collection_format",
    input: path.join(
      repoRoot,
      "node_modules/@typespec/http-specs/specs/parameters/collection-format/main.tsp",
    ),
    outputDir: path.join(
      repoRoot,
      "e2e/client/generated/parameters/collection-format",
    ),
  },
  {
    name: "parameters_spread",
    input: path.join(
      repoRoot,
      "node_modules/@typespec/http-specs/specs/parameters/spread/main.tsp",
    ),
    outputDir: path.join(
      repoRoot,
      "e2e/client/generated/parameters/spread",
    ),
  },
];


const selected = cases.filter((c) => filter === "" || c.name.includes(filter));
const limited = limit > 0 ? selected.slice(0, limit) : selected;

if (limited.length === 0) {
  throw new Error(`未匹配任何用例: filter=${filter}`);
}

for (const c of limited) {
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
    "--emit",
    emitterDir,
    "--option",
    `typespec-moonbit-client.emitter-output-dir=${c.outputDir}`,
    "--output-dir",
    c.outputDir,
  ];

  if (verbose) {
    console.log(cmd.join(" "));
  } else {
    console.log(`generating ${c.name}`);
  }
  execSync(cmd.join(" "), { stdio: "inherit" });
}
