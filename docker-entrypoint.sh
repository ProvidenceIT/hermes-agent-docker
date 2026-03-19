#!/bin/sh
set -eu

HERMES_HOME=${HERMES_HOME:-/home/agent/.hermes}
DEFAULTS_DIR=/usr/local/share/hermes-home
SEED_MARKER="$HERMES_HOME/.docker-defaults-seeded"

mkdir -p "$HERMES_HOME"

if [ ! -e "$SEED_MARKER" ] && [ -z "$(find "$HERMES_HOME" -mindepth 1 -maxdepth 1 -print -quit 2>/dev/null)" ]; then
  cp -a "$DEFAULTS_DIR"/. "$HERMES_HOME"/
  : > "$SEED_MARKER"
fi

exec "$@"
