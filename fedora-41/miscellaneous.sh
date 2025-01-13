# install vs-code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install code


# Install Dapr CLI if not already installed
if ! command -v dapr &> /dev/null; then
    echo "Installing Dapr CLI..."
    wget -q https://raw.githubusercontent.com/dapr/cli/master/install/install.sh -O - | /bin/bash
else
    echo "Dapr CLI is already installed."
fi

# Install NVM if not already installed
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

    # Load NVM for the current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
else
    echo "NVM is already installed."
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Ensure Node.js version 22 is installed and in use
if ! nvm ls 22 &> /dev/null; then
    echo "Installing Node.js 22..."
    nvm install 22
else
    echo "Node.js 22 is already installed."
fi

echo "Using Node.js 22..."
nvm use 22



# install cfssl
go install github.com/cloudflare/cfssl/cmd/...@latest


# install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
rm -rf aws
rm -rf awscliv2.zip

# install localstack
LOCALSTACK_VERSION="4.0.0"
TAR_FILE="localstack-cli-${LOCALSTACK_VERSION}-linux-amd64-onefile.tar.gz"
DOWNLOAD_URL="https://github.com/localstack/localstack-cli/releases/download/v${LOCALSTACK_VERSION}/${TAR_FILE}"

if ! command -v localstack &>/dev/null || [[ "$(localstack --version)" != "$LOCALSTACK_VERSION"* ]]; then
    curl --output "$TAR_FILE" --location "$DOWNLOAD_URL"
    sudo tar xvzf "$TAR_FILE" -C /usr/local/bin
    rm -f "$TAR_FILE"
else
    echo "LocalStack CLI is already installed and up-to-date."
fi



# install quarkus 
curl -Ls https://sh.jbang.dev | bash -s - trust add https://repo1.maven.org/maven2/io/quarkus/quarkus-cli/
curl -Ls https://sh.jbang.dev | bash -s - app install --fresh --force quarkus@quarkusio