#!/usr/bin/env bash

# Exit immediately if a command fails, treat unset variables as errors, and fail on pipe errors
set -Eeuo pipefail

# Print a message with the script name and line number if any command fails
trap 'echo "❌ FAILED: ${BASH_SOURCE[0]} at line $LINENO"' ERR

# Skip gh setup on CI environments
if [[ -n "${CI:-}" ]]; then
    echo "⚠ Detected CI environment. Skipping gh extension setup."
    exit 0
fi

# Check if GitHub CLI (gh) is installed
printf "\n\033[1;36m=== Checking GitHub CLI (gh) ===\033[0m\n"

# Verify gh command availability
if command -v gh >/dev/null 2>&1; then
    printf "\033[1;33m⚠ GitHub CLI (gh) is already installed\033[0m\n"
else
    # Abort if gh is missing
    printf "\033[1;31m✗ GitHub CLI (gh) is not installed. Please install gh first.\033[0m\n"
    exit 1
fi

# Check and install gh extension: yusukebe/gh-markdown-preview
printf "\n\033[1;36m=== Checking gh extension: yusukebe/gh-markdown-preview ===\033[0m\n"

# Check whether the extension is already installed
if gh extension list | grep -q '^yusukebe/gh-markdown-preview'; then
    printf "\033[1;33m⚠ gh-markdown-preview is already installed\033[0m\n"
else
    # Install the extension if missing
    printf "\033[1;36mInstalling gh-markdown-preview...\033[0m\n"
    gh extension install yusukebe/gh-markdown-preview
    printf "\033[1;32m✓ gh-markdown-preview installed successfully\033[0m\n"
fi

# Final confirmation
printf "\n\033[1;32m✓ gh extensions are ready\033[0m\n"