///|
extern "js" fn safe_exec_sync(
  cp : @js.Value,
  cmd : String,
  cwd : String,
) -> Unit =
  #| (cp, cmd, cwd) => { try { cp.execSync(cmd, { cwd: cwd }); } catch (e) { } }

///|
pub fn exec_moon_fmt(path : String) -> Unit {
  safe_exec_sync(@js.require("child_process"), "moon fmt", path)
}
