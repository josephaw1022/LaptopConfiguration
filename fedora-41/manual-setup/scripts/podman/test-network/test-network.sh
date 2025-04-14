#!/bin/bash
set -euo pipefail

CONTAINER_IP="192.168.4.100"
PORT=80

echo "Waiting for container to become reachable at http://${CONTAINER_IP}:${PORT}..."

# Wait for it to respond with a timeout loop
for i in {1..10}; do
  if curl -s --head "http://${CONTAINER_IP}:${PORT}" | grep -q "200 OK"; then
    echo "Container is up and responding!"
    exit 0
  else
    echo "Attempt $i: Not ready yet..."
    sleep 2
  fi
done

echo "Failed to reach container after multiple attempts."
exit 1
