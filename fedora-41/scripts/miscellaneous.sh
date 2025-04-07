
# Install Dapr CLI if not already installed
if ! command -v dapr &> /dev/null; then
    echo "Installing Dapr CLI..."
    wget -q https://raw.githubusercontent.com/dapr/cli/master/install/install.sh -O - | /bin/bash
else
    echo "Dapr CLI is already installed."
fi



# install cfssl
go install github.com/cloudflare/cfssl/cmd/...@latest


# install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
rm -rf ./aws
rm -rf ./awscliv2.zip

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



# install tilt
curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
