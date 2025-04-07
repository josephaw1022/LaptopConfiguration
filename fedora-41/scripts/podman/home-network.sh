#!/bin/bash
set -euo pipefail

# Define required variables
NETWORK_NAME="homelabnetwork"
PARENT_INTERFACE="eth0"
HOST_MACVLAN_INTERFACE="macvlan0"
SUBNET="192.168.0.0/21"
GATEWAY="192.168.2.1"
HOST_MACVLAN_IP="192.168.0.3/21"


# Recreate macvlan network
if sudo podman network exists "$NETWORK_NAME"; then
  echo "Network '$NETWORK_NAME' already exists, deleting it..."
  sudo sudo podman network rm "$NETWORK_NAME" -f
fi

echo "Creating network: $NETWORK_NAME"
sudo podman network create -d macvlan \
  -o parent="$PARENT_INTERFACE" \
  --subnet="$SUBNET" \
  --gateway="$GATEWAY" \
  "$NETWORK_NAME"

# Recreate macvlan interface on the host
if sudo ip link show "$HOST_MACVLAN_INTERFACE" &> /dev/null; then
  echo "Host macvlan interface '$HOST_MACVLAN_INTERFACE' already exists, deleting it..."
  sudo ip link delete "$HOST_MACVLAN_INTERFACE"
fi

echo "Creating macvlan interface '$HOST_MACVLAN_INTERFACE' on host"
sudo ip link add "$HOST_MACVLAN_INTERFACE" link "$PARENT_INTERFACE" type macvlan mode bridge
sudo ip addr add "$HOST_MACVLAN_IP" dev "$HOST_MACVLAN_INTERFACE"
sudo ip link set "$HOST_MACVLAN_INTERFACE" up
