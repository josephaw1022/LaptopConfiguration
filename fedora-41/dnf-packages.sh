# Update dnf and install packages
sudo dnf update -y
sudo dnf install -y \
    go \
    openssl \
    dotnet-sdk-8.0 \
    go-task \
    java-latest-openjdk.x86_64 \
    vim \
    podman podman-docker

# Fix go path from dnf install
if [[ ":$PATH:" != *":$HOME/go/bin:"* ]]; then
    echo "Adding $HOME/go/bin to PATH..."
    SHELL_CONFIG="$HOME/.bashrc"
    if [ -f "$HOME/.bash_profile" ]; then
        SHELL_CONFIG="$HOME/.bash_profile"
    fi

    echo "export PATH=\$PATH:\$HOME/go/bin" >> "$SHELL_CONFIG"
    echo "Updated $SHELL_CONFIG. Please reload your shell or run 'source $SHELL_CONFIG'."
else
    echo "$HOME/go/bin is already in PATH."
fi


# Install PowerShell
sudo dnf install -y https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell-7.4.6-1.rh.x86_64.rpm

# Install Github Cli
sudo dnf install dnf5-plugins
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh --repo gh-cli


# Install tekton cli 
sudo dnf install -y https://github.com/tektoncd/cli/releases/download/v0.39.0/tektoncd-cli-0.39.0_Linux-64bit.rpm