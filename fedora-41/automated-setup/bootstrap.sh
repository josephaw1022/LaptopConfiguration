#!/bin/bash

set -euo pipefail

echo "📦 Updating system packages..."
sudo dnf update -y

echo "🧰 Installing system packages required for Ansible and collections..."
sudo dnf install -y \
  git \
  make \
  python3 \
  python3-pip \
  gcc \
  libffi-devel \
  python3-devel \
  openssl-devel \
  sshpass \
  python3-markupsafe

echo "🐍 Installing Ansible (user scope)..."
python3 -m pip install --user --upgrade pip setuptools wheel
python3 -m pip install --user ansible ansible-core ansible-dev-tools

echo "🐍 Installing python3-libdnf5...
sudo dnf install -y python3-libdnf5"

echo "📦 Installing community.general collection to user path..."
~/.local/bin/ansible-galaxy collection install community.general

echo "✅ Bootstrap complete. Make sure ~/.local/bin is in your PATH."
echo "   Then run: make"
