#!/bin/bash

# Exit on error
set -e

echo "Updating system packages..."
sudo dnf update -y

echo "Installing Cockpit..."
sudo dnf install -y cockpit

echo "Enabling and starting Cockpit service..."
sudo systemctl enable --now cockpit.socket

echo "Checking firewall status..."
if sudo firewall-cmd --state &>/dev/null; then
    echo "Adding firewall rule for Cockpit (port 9090)..."
    sudo firewall-cmd --permanent --add-service=cockpit
    sudo firewall-cmd --reload
else
    echo "FirewallD not running or not installed, skipping firewall configuration."
fi

echo "Cockpit installation complete!"
echo "You can now access Cockpit via: https://<your-server-ip>:9090"
