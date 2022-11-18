#!/usr/bin/env bash

(
  exec Xvfb :0 -screen 0 1366x768x24 -listen tcp
) >/tmp/xvfb.log 2>&1 &

while ! nc -z localhost 6000; do
  sleep 0.1
  echo "waiting for localhost:6000"
done

echo "x ready"

(
  exec fluxbox &
) >/tmp/fluxbox.log 2>&1 &

(
  exec x11vnc -display :0 -passwd secret -forever
) >/tmp/x11vnc.log 2>&1 &

# tailer is a model citizen of handling SIGINT and SIGTERM
exec tailer /tmp/xvfb.log /tmp/fluxbox.log /tmp/x11vnc.log
