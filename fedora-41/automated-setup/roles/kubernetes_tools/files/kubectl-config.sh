# Enable kubectl autocompletion
source <(kubectl completion bash)

# Alias for kubectl
alias k=kubectl
complete -o default -F __start_kubectl k
