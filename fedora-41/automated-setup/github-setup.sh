#!/bin/bash

# if gh is not installed, install it

if ! command -v gh &> /dev/null; then
    echo "🔍 GitHub CLI (gh) not found. Installing..."
    # DNF5 installation commands
    sudo dnf install dnf5-plugins
    sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
    sudo dnf install gh --repo gh-cli
fi



# Prompt for Git user info
read -rp "Enter your Git username: " git_username
read -rp "Enter your Git email: " git_email

# Set Git config
git config --global user.name "$git_username"
git config --global user.email "$git_email"

echo "✅ Git username and email configured."

# Generate SSH key
key_file="$HOME/.ssh/id_ed25519"

if [ -f "$key_file" ]; then
    echo "⚠️ SSH key already exists at $key_file"
else
    echo "🔐 Generating new SSH key..."
    ssh-keygen -t ed25519 -C "$git_email" -f "$key_file" -N ""
    echo "✅ SSH key generated at $key_file"
fi

# Start ssh-agent and add private key
eval "$(ssh-agent -s)"
ssh-add "$key_file"

# Authenticate GitHub CLI
echo "🔐 Authenticating with GitHub..."
gh auth login

# Read the public key
pub_key=$(cat "$key_file.pub")

# Add SSH key to GitHub
read -rp "Enter a name for your SSH key on GitHub (e.g. 'laptop', 'homelab'): " key_title
gh ssh-key add "$key_file.pub" --title "$key_title"

echo "🎉 SSH key added to GitHub and Git configured successfully!"
