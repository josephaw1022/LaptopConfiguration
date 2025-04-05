#!/bin/bash

# Download and install .NET
echo "Downloading and installing .NET..."
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh

# Remove the install script
echo "Cleaning up installation script..."
rm -f ./dotnet-install.sh

# Define the lines to add to the shell configuration files
DOTNET_PATH_EXPORT='export DOTNET_ROOT="$HOME/.dotnet"'
DOTNET_PATH_ADD='export PATH="$DOTNET_ROOT:$PATH"'
PWSH_PATH_EXPORT='$env:DOTNET_ROOT="$HOME/.dotnet"'
PWSH_PATH_ADD='$env:PATH="$env:DOTNET_ROOT;$env:PATH"'
PWSH_ALIAS='Set-Alias -Name dotnet -Value "$HOME/.dotnet/dotnet"'

# Shell configuration files
BASH_CONFIG_FILE="$HOME/.bashrc"
PWSH_CONFIG_FILE="$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1"

# Function to append a line if it doesn't already exist in the file
append_if_missing() {
  local line="$1"
  local file="$2"
  if [[ ! -f "$file" ]]; then
    mkdir -p "$(dirname "$file")"
    touch "$file"
  fi
  grep -qxF "$line" "$file" || echo "$line" >> "$file"
}

# Add to Bash configuration
echo "Updating Bash configuration..."
append_if_missing "$DOTNET_PATH_EXPORT" "$BASH_CONFIG_FILE"
append_if_missing "$DOTNET_PATH_ADD" "$BASH_CONFIG_FILE"

# Add to PowerShell profile
echo "Updating PowerShell profile..."
append_if_missing "$PWSH_PATH_EXPORT" "$PWSH_CONFIG_FILE"
append_if_missing "$PWSH_PATH_ADD" "$PWSH_CONFIG_FILE"
append_if_missing "$PWSH_ALIAS" "$PWSH_CONFIG_FILE"

# Reload the shell configuration for Bash
echo "Reloading Bash configuration..."
source "$BASH_CONFIG_FILE"

# Display confirmation messages
echo "DOTNET_ROOT and PATH updated for Bash. Current dotnet path in Bash:"
which dotnet

# Display confirmation messages for PowerShell
echo "DOTNET_ROOT and PATH updated for PowerShell with alias. Verify it in PowerShell with:"
echo "   pwsh -Command { \$env:DOTNET_ROOT; \$env:PATH }"

# Final message for confirmation
echo "Setup complete! Restart your shell to apply all changes."
