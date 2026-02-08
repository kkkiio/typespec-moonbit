const baseUrl = process.argv[2];

if (!baseUrl) {
  console.error("missing baseUrl argument");
  process.exit(2);
}

const target = `${baseUrl}/server/events/dotted-name/tasks`;

async function assertErrorResponse(url) {
  const res = await fetch(`${url}?mode=error`, {
    method: "GET",
    headers: { Accept: "application/json" },
  });
  if (res.status !== 400) {
    throw new Error(`unexpected error status: ${res.status}`);
  }
  const contentType = (res.headers.get("content-type") || "").toLowerCase();
  if (!contentType.includes("application/json")) {
    throw new Error(`unexpected error content-type: ${contentType}`);
  }
  const body = await res.json();
  if (body?.error !== "forced") {
    throw new Error(`unexpected error body: ${JSON.stringify(body)}`);
  }
}

function parseSseEvent(block) {
  const lines = block.split("\n");
  let event = "message";
  const data = [];
  for (const line of lines) {
    if (line.startsWith(":") || line.trim() === "") {
      continue;
    }
    if (line.startsWith("event:")) {
      event = line.slice("event:".length).trim();
      continue;
    }
    if (line.startsWith("data:")) {
      data.push(line.slice("data:".length).trimStart());
    }
  }
  return { event, data: data.join("\n") };
}

async function readSse(url) {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort("timeout"), 8000);
  const expected = new Set(["maria.queued_messages.synchronized", "maria"]);
  const received = new Map();

  try {
    const res = await fetch(url, {
      method: "GET",
      headers: { Accept: "text/event-stream" },
      signal: controller.signal,
    });
    if (!res.ok) {
      throw new Error(`unexpected status: ${res.status}`);
    }
    const contentType = (res.headers.get("content-type") || "").toLowerCase();
    if (!contentType.includes("text/event-stream")) {
      throw new Error(`unexpected content-type: ${contentType}`);
    }
    if (!res.body) {
      throw new Error("missing response body");
    }

    const reader = res.body.getReader();
    const decoder = new TextDecoder();
    let buffer = "";
    while (true) {
      const { done, value } = await reader.read();
      if (done) {
        break;
      }
      let txt = decoder.decode(value, { stream: true });
      buffer += txt.replace(/\r\n/g, "\n");
      while (true) {
        const sep = buffer.indexOf("\n\n");
        if (sep < 0) {
          break;
        }
        const block = buffer.slice(0, sep);
        buffer = buffer.slice(sep + 2);
        const evt = parseSseEvent(block);
        if (expected.has(evt.event)) {
          received.set(evt.event, evt.data);
          if (received.size === expected.size) {
            controller.abort("done");
            break;
          }
        }
      }
    }
  } catch (err) {
    if (String(err).includes("done")) {
      // expected early abort after collecting all events
    } else {
      throw err;
    }
  } finally {
    clearTimeout(timeout);
  }

  for (const name of expected) {
    if (!received.has(name)) {
      throw new Error(`missing expected event: ${name}`);
    }
  }
  if (received.get("maria.queued_messages.synchronized") !== "{\"seq\":1}") {
    throw new Error("unexpected data for maria.queued_messages.synchronized");
  }
  if (received.get("maria") !== "{\"seq\":2}") {
    throw new Error("unexpected data for maria");
  }
}

Promise.resolve()
  .then(() => assertErrorResponse(target))
  .then(() => readSse(target))
  .catch((err) => {
    console.error(`sse assertion failed: ${err}`);
    process.exit(1);
  });
