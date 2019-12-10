FROM alpine:3.10

RUN apk add --no-cache \
  bash \
  xvfb x11vnc fluxbox

WORKDIR /app
COPY app .

ENV DISPLAY=:0
ENTRYPOINT ["/app/entrypoint.sh"]
