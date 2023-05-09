FROM alpine:3.16

RUN apk add --no-cache \
  bash \
  xvfb x11vnc fluxbox xterm supertux

WORKDIR /app
COPY app .

COPY --from=ghcr.io/matti/tailer:824002811ee20a0dbb19501e77553b49ebdf5869 /tailer /usr/bin

ENV DISPLAY=:0
ENTRYPOINT ["/app/entrypoint.sh"]
