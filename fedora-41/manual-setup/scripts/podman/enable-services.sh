#!/bin/bash
set -euo pipefail

sudo systemctl enable --now podman.socket

sudo systemctl enable --now netavark-dhcp-proxy.socket

sudo systemctl enable --now podman.service

sudo systemctl enable --now podman-auto-update.service

sudo systemctl enable --now podman-restart.service