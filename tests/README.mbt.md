# typespec-tests

End-to-End / Runtime verification module (native target).

## Test Structure

- **Server Emitter Tests** (`server/`): Starts a MoonBit HTTP server and invokes `tsp-spector knock` for verification.
- **Client Emitter Tests** (`client/`): Invokes the generated client to send requests (mock server is started by script).

## Running Tests

```bash
# Run Server E2E tests only
moon test -p kkkiio/typespec-tests/server

# Run Client E2E tests only
# First run 'npm run spector -- --start' in the repository root
moon test --target native -p kkkiio/typespec-tests/client/tests
```
