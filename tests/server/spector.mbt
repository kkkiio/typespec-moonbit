///|
const CWD = ".."

///|
pub async fn run_scenario(
  scenario : String,
  base_url : String,
) -> Status noraise {
  try {
    run(
      "npx",
      [
        "tsp-spector", "knock",
        // "\{CWD}/node_modules/@typespec/http-specs/specs",
         "./node_modules/@typespec/http-specs/specs", "--filter", scenario, "--baseUrl",
        base_url,
      ],
      options=RunOptions::new(cwd=CWD),
    )
    |> ignore
    Status::Pass
  } catch {
    e => {
      println("run_scenario failed: \{e}")
      Status::Fail
    }
  }
}

///|
pub enum Status {
  Pass
  Fail
}

///|
/// Run the given command or throw CommandFailedError if the command returns non zero exit code.
pub async fn run(
  command : String,
  args : Array[String],
  options? : RunOptions = RunOptions::new(),
) -> ExecResult {
  if not(options.silent) {
    println("")
    let args_show = args.join(" ")
    println("> \{command} \{args_show}")
  }
  try {
    let exit_code = @process.run(
      command,
      args,
      stdout=@stdio.stdout,
      stderr=@stdio.stderr,
      cwd?=options.cwd.map(_.view()),
    )
    if options.throw_on_non_zero_exit && exit_code != 0 {
      raise CommandFailedError(command~, args~, exit_code~)
    }
    return { exit_code, }
  } catch {
    @os_error.OSError::OSError(_) as err if options.ignore_command_not_found &&
      err.is_ENOENT() => {
      println("Skipped: Command \"\{command}\" not found.")
      return { exit_code: 0 }
    }
    e => raise e
  }
}

///|
pub struct RunOptions {
  cwd : String?
  silent : Bool
  encoding : String?
  ignore_command_not_found : Bool
  throw_on_non_zero_exit : Bool
}

///|
pub fn RunOptions::new(
  cwd? : String,
  silent? : Bool = false,
  encoding? : String,
  ignore_command_not_found? : Bool = false,
  throw_on_non_zero_exit? : Bool = true,
) -> RunOptions {
  RunOptions::{
    cwd,
    silent,
    encoding,
    ignore_command_not_found,
    throw_on_non_zero_exit,
  }
}

///|
pub struct ExecResult {
  exit_code : Int
  // stdout : String
  // stderr : String
  // proc : Process
}

///|
pub suberror CommandFailedError {
  CommandFailedError(command~ : String, args~ : Array[String], exit_code~ : Int)
}

///|
pub impl Show for CommandFailedError with output(self, logger) noraise {
  guard self is CommandFailedError(command~, args~, exit_code~)
  let args_show = args.join(" ")
  logger.write_string(
    "Command `\{command} \{args_show}` failed with exit code \{exit_code}",
  )
}
