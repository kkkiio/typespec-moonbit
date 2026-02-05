import { execSync } from "child_process";

execSync("node .scripts/emit_e2e_server.js", { stdio: "inherit" });
execSync("moon info -C e2e --target native", { stdio: "inherit" });

