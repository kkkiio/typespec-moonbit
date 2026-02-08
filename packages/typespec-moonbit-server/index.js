// Minimal shim: re-export MoonBit emitter entry as $onEmit for TypeSpec.
const mod = await import("./dist/emitter.js");
export const $onEmit = mod.on_emit;
