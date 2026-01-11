#!/bin/bash

# Exit immediately if a command fails, treat unset variables as errors, and fail on pipe errors
set -Eeuo pipefail

# Print a message with the script name and line number if any command fails
trap 'echo "❌ FAILED: ${BASH_SOURCE[0]} at line $LINENO"' ERR

# Print header for GitHub CLI check
printf "\n\033[1;36m=== Checking GitHub CLI (gh) ===\033[0m\n"

# Check if GitHub CLI is installed
if command -v gh >/dev/null 2>&1; then
    printf "\033[1;33m⚠ GitHub CLI (gh) is already installed\033[0m\n"
else
    # Exit if GitHub CLI is missing
    printf "\033[1;31m✗ GitHub CLI (gh) is not installed. Please install gh first.\033[0m\n"
    exit 1
fi

# Print header for gh extension check
printf "\n\033[1;36m=== Checking gh extension: yusukebe/gh-markdown-preview ===\033[0m\n"

# Check if the gh-markdown-preview extension is installed
if gh extension list | grep -q '^yusukebe/gh-markdown-preview'; then
    printf "\033[1;33m⚠ gh-markdown-preview is already installed\033[0m\n"
else
    # Install the extension
    printf "\033[1;36mInstalling gh-markdown-preview...\033[0m\n"
    gh extension install yusukebe/gh-markdown-preview || {
        # Exit if installation fails
        printf "\033[1;31m✗ gh-markdown-preview installation failed. Exiting...\033[0m\n"
        exit 1
    }
    # Success message for the extension
    printf "\033[1;32m✓ gh-markdown-preview installed successfully\033[0m\n"
fi

# Final confirmation message
printf "\n\033[1;32m✓ gh extensions are ready\033[0m\n"