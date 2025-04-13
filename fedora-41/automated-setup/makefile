# Default target
.DEFAULT_GOAL := help

# Configurable vars
SUDO_PASSWORD_FILE ?= .ansible_sudo_password
REQUIREMENTS_FILE ?= requirements.yml
PLAYBOOK ?= main.yml

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} \
	/^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } \
	/^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


.PHONY: setup
setup: ## Install required Ansible collections
	@echo "🔧 Installing Ansible collections..."
	ansible-galaxy collection install -r $(REQUIREMENTS_FILE) --force

.PHONY: password
password: ## Prompt for sudo password and store it securely
	@if [ ! -f $(SUDO_PASSWORD_FILE) ]; then \
		read -s -p "Enter your sudo password: " pass; echo $$pass > $(SUDO_PASSWORD_FILE); \
		echo "\n✅ Saved sudo password to $(SUDO_PASSWORD_FILE)"; \
	else \
		echo "🔐 Sudo password file already exists."; \
	fi
	@chmod 600 $(SUDO_PASSWORD_FILE)

.PHONY: run
run: ## Run the Ansible playbook with saved sudo password
	@if [ ! -f $(SUDO_PASSWORD_FILE) ]; then \
		echo "❌ Missing sudo password file. Run 'make password' first."; \
		exit 1; \
	fi
	@echo "🚀 Running Ansible playbook..."
	ANSIBLE_BECOME_PASS=$$(cat $(SUDO_PASSWORD_FILE)) \
	ansible-playbook -u jwhiteaker $(PLAYBOOK)


.PHONY: clean
clean: ## Remove stored sudo password file
	@echo "🧹 Cleaning up..."
	@rm -f $(SUDO_PASSWORD_FILE)
