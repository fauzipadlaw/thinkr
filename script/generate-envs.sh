#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXAMPLE="$ROOT_DIR/.env.example"

if [[ ! -f "$EXAMPLE" ]]; then
  echo "Missing .env.example at project root: $EXAMPLE" >&2
  exit 1
fi

copy_env() {
  local target="$1"
  if [[ -f "$target" ]]; then
    echo "Skipping $target (already exists)"
  else
    cp "$EXAMPLE" "$target"
    echo "Created $target from .env.example"
  fi
}

copy_env "$ROOT_DIR/.env.development"
copy_env "$ROOT_DIR/.env.staging"
copy_env "$ROOT_DIR/.env.production"
