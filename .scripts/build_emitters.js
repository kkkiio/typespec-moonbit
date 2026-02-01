import { execSync } from "child_process";
import fs from "fs";
import path from "path";

const repoRoot = process.cwd();
const args = new Set(process.argv.slice(2));

const buildClient = args.size === 0 || args.has("--all") || args.has("--client");
const buildServer = args.size === 0 || args.has("--all") || args.has("--server");

// Keep the legacy `emitter/_build/js/release/build/typespec-moonbit.js` up to date.
if (buildClient || buildServer) {
  execSync("moon build -C emitter --target js --release", { stdio: "inherit" });
}

function buildOne(kind) {
  const entryDir = path.join(repoRoot, "emitter", "emitters", kind);
  const outDir = path.join(repoRoot, "emitter", "_build", "js", "release", "build", "emitters", kind);
  const jsFile = path.join(outDir, `${kind}.js`);
  const dtsFile = path.join(outDir, `${kind}.d.ts`);
  const moonbitDtsFile = path.join(outDir, "moonbit.d.ts");

  const pkgDir = path.join(repoRoot, "packages", `typespec-moonbit-${kind}`);
  const distDir = path.join(pkgDir, "dist");

  execSync(`moon build -C emitter --target js --release ${entryDir}`, { stdio: "inherit" });

  fs.mkdirSync(distDir, { recursive: true });
  fs.copyFileSync(jsFile, path.join(distDir, "emitter.js"));
  if (fs.existsSync(dtsFile)) {
    fs.copyFileSync(dtsFile, path.join(distDir, "emitter.d.ts"));
  }
  if (fs.existsSync(moonbitDtsFile)) {
    fs.copyFileSync(moonbitDtsFile, path.join(distDir, "moonbit.d.ts"));
  }
}

if (buildClient) buildOne("client");
if (buildServer) buildOne("server");
