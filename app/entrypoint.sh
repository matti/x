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

set +e
  rm /tmp/.X0-lock
set -e

(
  exec Xvfb :0 -screen 0 1366x768x24 -ac -listen tcp
) &

while ! nc -z localhost 6000; do
  echo "waiting for localhost:6000"
  sleep 0.1
done
echo "x ready"

(
  exec fluxbox
) &

(
  exec x11vnc -display :0 -passwd secret -forever
) &

echo "started"
tail -f /dev/null &
wait $!
