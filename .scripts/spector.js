// Minimal wrapper aligned with typespec-rust's spector script.
import { execSync } from "child_process";
import { dirname } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const repoRoot = execSync("git rev-parse --show-toplevel").toString().trim();
const nodeModulesRoot = repoRoot + "/node_modules/";
const httpSpecs = nodeModulesRoot + "@typespec/http-specs/specs";
const azureHttpSpecs = nodeModulesRoot + "@azure-tools/azure-http-specs/specs";

const switches = [];
let execSyncOptions;

switch (process.argv[2]) {
  case "--serve":
    switches.push("serve", httpSpecs, azureHttpSpecs);
    execSyncOptions = { stdio: "inherit" };
    break;
  case "--start":
    switches.push("server", "start", httpSpecs, azureHttpSpecs);
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
