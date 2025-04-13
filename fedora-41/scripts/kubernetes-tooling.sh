#!/bin/bash


# Download and install the latest versions of the following tools:
# - kubectl
# - Helm
# - kubectx & kubens
# - Kind
# - Argo CLI
# - istioctl
# - K9s



# kubectl
KUBECTL_URL="https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
if ! command -v kubectl &>/dev/null || [[ "$(kubectl version --client --short)" != "$(curl -L -s https://dl.k8s.io/release/stable.txt)"* ]]; then
    echo "Installing/updating kubectl..."
    curl -LO "$KUBECTL_URL"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm -f kubectl
else
    echo "kubectl is already installed and up-to-date."
fi

# Helm
if ! command -v helm &>/dev/null; then
    echo "Installing Helm..."
    sudo dnf install -y helm
else
    echo "Helm is already installed."
fi

# kubectx & kubens
if ! command -v kubectx &>/dev/null || ! command -v kubens &>/dev/null; then
    echo "Installing kubectx and kubens..."
    sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
    sudo ln -sf /opt/kubectx/kubectx /usr/local/bin/kubectx
    sudo ln -sf /opt/kubectx/kubens /usr/local/bin/kubens
else
    echo "kubectx and kubens are already installed."
fi

# Kind
go install sigs.k8s.io/kind@v0.27.0
go install sigs.k8s.io/cloud-provider-kind@latest

# Argo CLI
if ! command -v argocd &>/dev/null; then
    echo "Installing Argo CLI..."
    ARGOCD_URL="https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64"
    curl -sSL -o argocd-linux-amd64 "$ARGOCD_URL"
    sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
    rm -f argocd-linux-amd64
else
    echo "Argo CLI is already installed."
fi

# istioctl
if ! command -v istioctl &>/dev/null || [[ "$(istioctl version --remote=false --short)" != "${ISTIO_VERSION:-1.24.2}" ]]; then
    echo "Installing/updating istioctl..."
    ISTIO_VERSION="${ISTIO_VERSION:-1.24.2}"
    curl -L https://istio.io/downloadIstio | sh -
    sudo mv "istio-${ISTIO_VERSION}/bin/istioctl" /usr/local/bin
    rm -rf "istio-${ISTIO_VERSION}"
else
    echo "istioctl is already installed and up-to-date."
fi

# K9s
go install github.com/derailed/k9s@latest


echo "All tools are installed and up-to-date."