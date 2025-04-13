# Add Go to PATH from /usr/local/go/bin if not already present
if [[ ":$PATH:" != *":/usr/local/go/bin:"* ]]; then
    export PATH="$PATH:/usr/local/go/bin"
fi
