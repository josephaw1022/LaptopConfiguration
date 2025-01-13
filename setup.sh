#!/bin/bash

# Run DNF packages installation
echo "Running DNF packages installation..."
bash fedora-41/dnf-packages.sh

# Run Flatpak packages installation
echo "Running Flatpak packages installation..."
bash fedora-41/flatpaks.sh

# Run Kubernetes tooling installation
echo "Running Kubernetes tooling installation..."
bash fedora-41/kubernetes-tooling.sh

# Run Miscellaneous configurations
echo "Running miscellaneous configurations..."
bash fedora-41/miscellaneous.sh

echo "All setup scripts executed successfully!"
