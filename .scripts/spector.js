// Minimal wrapper aligned with typespec-rust's spector script.
import { execSync } from "child_process";
import fs from "fs";
import http from "http";
import { dirname } from "path";
import { fileURLToPath } from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const repoRoot = execSync("git rev-parse --show-toplevel").toString().trim();
const nodeModulesRoot = repoRoot + "/node_modules/";
const httpSpecs = nodeModulesRoot + "@typespec/http-specs/specs";
const azureHttpSpecs = nodeModulesRoot + "@azure-tools/azure-http-specs/specs";
const coverageDir = repoRoot + "/temp";
const coverageFile = coverageDir + "/tsp-spector-coverage-moonbit.json";
const readyUrl = "http://localhost:3000/routes/fixed";

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

if (arg == "--start") {
  await waitForReady(readyUrl);
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function probeStatus(url) {
  return new Promise((resolve, reject) => {
    const req = http.get(url, (res) => {
      res.resume();
      resolve(res.statusCode ?? 0);
    });
    req.on("error", reject);
    req.setTimeout(2000, () => {
      req.destroy(new Error("timeout"));
    });
  });
}

async function waitForReady(url, retries = 30, delayMs = 200) {
  let last = "unknown";
  for (let i = 0; i < retries; i++) {
    try {
      const code = await probeStatus(url);
      if (code >= 200 && code < 500) {
        console.log(`spector ready: ${url} -> ${code}`);
        return;
      }
      last = `status ${code}`;
    } catch (err) {
      last = err instanceof Error ? err.message : String(err);
    }
    await sleep(delayMs);
  }
  throw new Error(`spector server not ready: ${last}`);
}
