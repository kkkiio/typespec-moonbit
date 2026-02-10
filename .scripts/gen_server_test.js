import { execSync } from "child_process";

execSync("node .scripts/emit_e2e_server.js", { stdio: "inherit" });
execSync("moon info --target native", { stdio: "inherit", cwd: "tests" });
