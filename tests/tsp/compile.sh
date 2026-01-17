#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
TARGET=${1:-}

(
  cd "$ROOT_DIR"
  moon build --target js
  if [ ! -d node_modules ]; then
    npm install
  fi
)

run_case() {
  local dir="$1"
  local tsp="$dir/main.tsp"
  local out="$dir/_out"
  if [ ! -f "$tsp" ]; then
    echo "skip $dir (no main.tsp)"
    return 0
  fi
  echo "==> $dir"
  npx tsp compile "$tsp" --emit "$ROOT_DIR/index.js" --output-dir "$out"
}

if [ -n "$TARGET" ]; then
  run_case "$ROOT_DIR/tests/tsp/$TARGET"
else
  for dir in "$ROOT_DIR/tests/tsp"/*; do
    if [ -d "$dir" ]; then
      run_case "$dir"
    fi
  done
fi
