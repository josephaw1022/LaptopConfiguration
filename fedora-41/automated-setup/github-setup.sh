#!/bin/bash

# Ensure GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "🔍 GitHub CLI (gh) not found. Installing..."
    sudo dnf install gh -y
fi

# Prompt for Git config only if unset
if ! git config --global user.name &> /dev/null; then
    read -rp "Enter your Git username: " git_username
    git config --global user.name "$git_username"
else
    echo "✅ Git username is already set: $(git config --global user.name)"
fi

if ! git config --global user.email &> /dev/null; then
    read -rp "Enter your Git email: " git_email
    git config --global user.email "$git_email"
else
    echo "✅ Git email is already set: $(git config --global user.email)"
fi

# SSH key setup
key_file="$HOME/.ssh/id_ed25519"

if [ -f "$key_file" ]; then
    echo "⚠️ SSH key already exists at $key_file"
else
    git_email=$(git config --global user.email)
    echo "🔐 Generating new SSH key for $git_email..."
    ssh-keygen -t ed25519 -C "$git_email" -f "$key_file" -N ""
    echo "✅ SSH key generated at $key_file"
fi

# Start ssh-agent and add key (safe to re-add)
eval "$(ssh-agent -s)"
ssh-add -q "$key_file" || true

# Authenticate with GitHub if not already authenticated
if gh auth status &> /dev/null; then
    echo "✅ GitHub CLI is already authenticated. Skipping SSH key upload."
else
    echo "🔐 Authenticating GitHub CLI..."
    gh auth login

    read -rp "Enter a name for your SSH key on GitHub (e.g. 'laptop', 'homelab'): " key_title
    gh ssh-key add "$key_file.pub" --title "$key_title"
    echo "🎉 SSH key uploaded to GitHub."
fi

echo "✅ Git and GitHub setup complete!"
