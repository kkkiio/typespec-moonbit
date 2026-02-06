import "@typespec/http";
import "@typespec/events";
import "@typespec/sse";

using Http;
using TypeSpec.Events;
using TypeSpec.SSE;

@service
@route("/server/events/dotted-name")
namespace Server.Events.DottedName;

@events
union TaskEvents {
  `maria.queued_messages.synchronized`: unknown,
  maria: unknown,
}

@route("/tasks")
@get
op watchTasks(@query mode?: string): SSEStream<TaskEvents> | {
  @statusCode _: 400;
  @body error: {
    error: unknown;
  };
};
