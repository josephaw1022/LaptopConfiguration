#!/usr/bin/env bash

set -euo pipefail

echo "[*] Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "[*] Creating ~/.bashrc.d/starship.bash..."
mkdir -p ~/.bashrc.d
echo 'eval "$(starship init bash)"' > ~/.bashrc.d/starship.bash

if ! grep -q '.bashrc.d' ~/.bashrc; then
  echo "[*] Adding modular source logic to ~/.bashrc..."
  cat << 'EOF' >> ~/.bashrc

# Load modular shell configs
if [ -d "$HOME/.bashrc.d" ]; then
  for file in "$HOME/.bashrc.d"/*.bash; do
    [ -r "$file" ] && source "$file"
  done
fi
EOF
fi

echo "[*] Fixing ~/.cache permissions..."
sudo mkdir -p ~/.cache
sudo chown -R "$USER:$USER" ~/.cache

echo "[*] Writing ~/.config/starship.toml..."
mkdir -p ~/.config
cat > ~/.config/starship.toml << 'EOF'
format = """
$username$hostname$directory$git_branch$git_status$time
$character
"""

[username]
style_user = "bold blue"
show_always = true

[hostname]
ssh_only = false
style = "bold cyan"
format = "[$hostname](bold cyan) "

[directory]
style = "bold yellow"
truncation_length = 3
truncation_symbol = "…/"
read_only = " "
read_only_style = "red"

[git_branch]
symbol = " "
style = "bold green"

[git_status]
style = "green"
format = '([$all_status$ahead_behind](green) )'

[time]
disabled = false
format = "[$time](bold magenta) "
time_format = "%T"
style = "bold magenta"

[character]
success_symbol = "[➜](green)"
error_symbol = "[➜](red)"
EOF

echo "[✓] Setup complete."

echo
echo "👉 Now run: source ~/.bashrc"
echo "👉 And make sure your terminal is using a Nerd Font (like JetBrainsMono Nerd Font)"
