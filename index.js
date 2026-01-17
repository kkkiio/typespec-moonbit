// Minimal shim: re-export MoonBit emitter entry as $onEmit for TypeSpec.
import { createRequire } from "module";

globalThis.require = createRequire(import.meta.url);

const mod = await import("./typespec-moonbit/_build/js/release/build/typespec-moonbit.js");
export const $onEmit = mod.on_emit;
