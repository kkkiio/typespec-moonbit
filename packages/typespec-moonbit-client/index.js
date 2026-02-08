// Minimal shim: re-export MoonBit emitter entry as $onEmit for TypeSpec.
import * as mod from "./dist/emitter.js";

export const $onEmit = mod.on_emit;
