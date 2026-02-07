import { execSync } from "child_process";

const args = process.argv.slice(2);

const tspcompileCmd = ["node", ".scripts/tspcompile.js", ...args].join(" ");
execSync(tspcompileCmd, { stdio: "inherit" });

execSync("moon info -C tests --target native", { stdio: "inherit" });
