#!/usr/bin/env bash
set -euo pipefail

docker rm -f vtfk-lab01 >/dev/null 2>&1 || true

docker run -d \
  --name vtfk-lab01 \
  ubuntu:24.04 \
  sleep infinity

docker exec vtfk-lab01 sh -c "printf '%s' \"${VTFK_NONCE:-}\" > /tmp/vtfk-nonce"

CONTAINER_PID=$(docker inspect -f '{{.State.Pid}}' vtfk-lab01)
CONTAINER_PROCS=$(docker exec vtfk-lab01 sh -c 'ls /proc/[0-9]* 2>/dev/null | cut -d/ -f3 | sort -u | wc -l')
HOST_PROCS=$(ls /proc/[0-9]* 2>/dev/null | cut -d/ -f3 | sort -u | wc -l)

echo "CONTAINER_PID=$CONTAINER_PID"
echo "CONTAINER_PROCS=$CONTAINER_PROCS"
echo "HOST_PROCS=$HOST_PROCS"