#!/usr/bin/env bash
set -euo pipefail

_term() {
  >&2 echo "TERM"
  exit 0
}
trap "_term" TERM

_err() {
  >&2 echo "err: $*"
  exit 1
}

Xvfb :0 -screen 0 320x240x24 -ac -listen tcp &
x11vnc -display :0 -passwd secret -forever &

echo "started"
tail -f /dev/null &
wait $!
