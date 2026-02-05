// Minimal wrapper aligned with typespec-rust's spector script.
import { execSync } from "child_process";
import fs from "fs";
import { dirname } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const repoRoot = execSync("git rev-parse --show-toplevel").toString().trim();
const nodeModulesRoot = repoRoot + "/node_modules/";
const httpSpecs = nodeModulesRoot + "@typespec/http-specs/specs";
const azureHttpSpecs = nodeModulesRoot + "@azure-tools/azure-http-specs/specs";
const coverageDir = repoRoot + "/temp";
const coverageFile = coverageDir + "/tsp-spector-coverage-moonbit.json";

const switches = [];
let execSyncOptions;

const arg = process.argv.slice(2).find((a) => a != "--" && a.startsWith("--"));
switch (arg) {
  case "--serve":
    fs.mkdirSync(coverageDir, { recursive: true });
    switches.push("serve", httpSpecs, azureHttpSpecs, "--coverageFile", coverageFile);
    execSyncOptions = { stdio: "inherit" };
    break;
  case "--start":
    fs.mkdirSync(coverageDir, { recursive: true });
    switches.push("server", "start", httpSpecs, azureHttpSpecs, "--coverageFile", coverageFile);
    break;
  case "--stop":
    switches.push("server", "stop");
    break;
}

if (switches.length === 0) {
  throw new Error("missing arg: [--start] [--stop] [--serve]");
}

const cmdLine = "npx tsp-spector " + switches.join(" ");
console.log(cmdLine);
execSync(cmdLine, execSyncOptions);
