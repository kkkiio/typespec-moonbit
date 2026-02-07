// Regenerate TypeSpec spector test cases (aligned with typespec-rust's `tspcompile` idea).
//
// Output layout (committed to git):
//   tests/generated_cases/<case>/
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
execSync("node .scripts/build_emitters.js --all", { stdio: "inherit" });

const caseNames = [
  "authentication/api-key",
  "authentication/oauth2",
  "authentication/union",
  "encode/bytes",
  "encode/datetime",
  "encode/duration",
  "encode/numeric",
  "parameters/basic",
  "parameters/body-optionality",
  "parameters/collection-format",
  "parameters/spread",
  "payload/content-negotiation",
  "payload/json-merge-patch",
  "payload/media-type",
  "payload/multipart",
  "payload/pageable",
  "payload/xml",
  "routes",
  "serialization/encoded-name/json",
  "server/endpoint/not-defined",
  "server/path/multiple",
  "server/path/single",
  "server/versions/not-versioned",
  "server/versions/versioned",
  "special-headers/conditional-request",
  "special-headers/repeatability",
  "special-words",
  "type/array",
  "type/dictionary",
  "type/enum/extensible",
  "type/enum/fixed",
  "type/model/empty",
  "type/model/inheritance/enum-discriminator",
  "type/model/inheritance/nested-discriminator",
  "type/model/inheritance/not-discriminated",
  "type/model/inheritance/recursive",
  "type/model/inheritance/single-discriminator",
  "type/model/visibility",
  "type/property/additional-properties",
  "type/property/nullable",
  "type/property/optionality",
  "type/property/value-types",
  "type/scalar",
  "type/union",
  "versioning/added",
  "versioning/madeOptional",
  "versioning/removed",
  "versioning/renamedFrom",
  "versioning/returnTypeChangedFrom",
  "versioning/typeChangedFrom",
];

const outputDirOverrides = {
  "serialization/encoded-name/json": "serialization/encoded-name/json-model",
};

const cases = caseNames.map((name) => ({
  name: name.replaceAll("/", "_").replaceAll("-", "_"),
  input: path.join(repoRoot, `node_modules/@typespec/http-specs/specs/${name}/main.tsp`),
  outputDir: path.join(
    repoRoot,
    `tests/client/generated/${outputDirOverrides[name] ?? name}`,
  ),
  legacyOutputDir: outputDirOverrides[name]
    ? path.join(repoRoot, `tests/client/generated/${name}`)
    : null,
}));


const selected = cases.filter((c) => filter === "" || c.name.includes(filter));
const limited = limit > 0 ? selected.slice(0, limit) : selected;

if (limited.length === 0) {
  throw new Error(`未匹配任何用例: filter=${filter}`);
}

for (const c of limited) {
  if (!fs.existsSync(c.input)) {
    throw new Error(`缺少 TypeSpec 用例: ${c.input}`);
  }
  if (c.legacyOutputDir) {
    fs.rmSync(c.legacyOutputDir, { recursive: true, force: true });
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
