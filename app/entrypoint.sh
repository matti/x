#!/usr/bin/env bash

(
  exec Xvfb :0 -screen 0 1366x768x24 -listen tcp
) >/dev/xvfb.log 2>&1 &

while ! nc -z localhost 6000; do
  sleep 0.1
  echo "waiting for localhost:6000"
done

echo "x ready"

(
  exec fluxbox &
) >/dev/fluxbox.log 2>&1 &

(
  exec x11vnc -display :0 -passwd secret -forever
) >/dev/x11vnc.log 2>&1 &

echo "started"
tail -f /dev/null & wait
