# kkkiio/typespec-moonbit

Typespec MoonBit Emitter. Writen in MoonBit.

## Features

### Http server emitter

- [x] Json Models. snake_case for MoonBit field names, keep JSON keys as original TypeSpec field names.
- [x] Router function. Match request method & path, dispatch to corresponding handler.
- [x] SSE Handler. Stream response supported by `moonbitlang/async/aqueue`.

### Http client emitter

- [x] Json Models. snake_case for MoonBit field names, keep JSON keys as original TypeSpec field names.

## Architecture

There are four main packages:
- `emitter/mbtgen`: Code generator for MoonBit.
- `emitter/typespec`: TypeSpec reader.
- `emitter/http_client`: Http client emitter.
- `emitter/http_server`: Http server emitter.
