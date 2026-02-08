// Minimal shim: re-export MoonBit emitter entry as $onEmit for TypeSpec.
import { createRequire } from "module";

globalThis.require = createRequire(import.meta.url);

import * as mod from "./dist/emitter.js";

export const $onEmit = mod.on_emit;
