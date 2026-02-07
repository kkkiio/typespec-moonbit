import { execSync } from "child_process";
import fs from "fs";
import path from "path";

const repoRoot = process.cwd();
const args = new Set(process.argv.slice(2));

const buildClient = args.size === 0 || args.has("--all") || args.has("--client");
const buildServer = args.size === 0 || args.has("--all") || args.has("--server");

function buildOne(kind) {
  const config = kind === "client"
    ? {
      entryDir: path.join(repoRoot, "emitter", "http_client"),
      outDir: path.join(repoRoot, "emitter", "_build", "js", "release", "build", "http_client"),
      baseName: "http_client",
    }
    : kind === "server"
    ? {
      entryDir: path.join(repoRoot, "emitter", "http_server"),
      outDir: path.join(repoRoot, "emitter", "_build", "js", "release", "build", "http_server"),
      baseName: "http_server",
    }
    : {
      entryDir: path.join(repoRoot, "emitter", "emitters", kind),
      outDir: path.join(repoRoot, "emitter", "_build", "js", "release", "build", "emitters", kind),
      baseName: kind,
    };
  const jsFile = path.join(config.outDir, `${config.baseName}.js`);
  const dtsFile = path.join(config.outDir, `${config.baseName}.d.ts`);
  const moonbitDtsFile = path.join(config.outDir, "moonbit.d.ts");

  const pkgDir = path.join(repoRoot, "packages", `typespec-moonbit-${kind}`);
  const distDir = path.join(pkgDir, "dist");

  execSync(`moon build -C emitter --target js --release ${config.entryDir}`, { stdio: "inherit" });

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
