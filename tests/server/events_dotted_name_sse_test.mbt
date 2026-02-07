///|
/// Test for local events/dotted-name SSE case.
async test "events/dotted-name/sse" {
  let handler = DottedNameHandlerImpl::{  }
  @async.with_task_group(fn(group) {
    let router = @events_dotted_name.create_router(
      dotted_name_handler=handler,
      group~,
    )
    let dispatch = @events_dotted_name.create_dispatch(router)
    let base_url = @server.start_server(group, dispatch)
    @server.run("node", ["tests/server/scripts/assert_sse.js", base_url])
    |> ignore
  })
}

///|
struct DottedNameHandlerImpl {}

///|
impl @events_dotted_name.DottedNameHandler for DottedNameHandlerImpl with watch_tasks(
  _self,
  group~,
  mode,
) -> @events_dotted_name.DottedNameWatchTasksResult {
  if mode == "error" {
    return @events_dotted_name.DottedNameWatchTasksResult::Status400({
      error: "forced",
    })
  }
  let stream = @events_dotted_name.TaskEventsStream::new()
  let writer = stream
  group.spawn_bg(fn() {
    defer writer.close()
    writer.write_event(
      @events_dotted_name.TaskEvents::MariaQueuedMessagesSynchronized({
        "seq": 1,
      }),
    )
    writer.write_event(@events_dotted_name.TaskEvents::Maria({ "seq": 2 }))
  })
  @events_dotted_name.DottedNameWatchTasksResult::Stream(stream)
}
