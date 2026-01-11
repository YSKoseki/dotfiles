#!/bin/bash

# Exit immediately if a command fails, treat unset variables as errors, and fail on pipe errors
set -Eeuo pipefail

# Print a message with the script name and line number if any command fails
trap 'echo "❌ FAILED: ${BASH_SOURCE[0]} at line $LINENO"' ERR

# Print header for Xcode Command Line Tools check
printf "\n\033[1;36m=== Checking Xcode Command Line Tools ===\033[0m\n"

# Check if Xcode Command Line Tools are already installed
if xcode-select -p &>/dev/null; then
    printf "\033[1;33m⚠ Xcode Command Line Tools is already installed\033[0m\n"
else
    # Install Xcode Command Line Tools
    printf "\033[1;36mInstalling Xcode Command Line Tools...\033[0m\n"
    xcode-select --install || {
        # Exit if installation fails
        printf "\033[1;31m✗ Xcode Command Line Tools installation failed. Exiting...\033[0m\n"
        exit 1
    }

    # Wait until the installation completes
    printf "\033[1;36mWaiting for installation to complete...\033[0m\n"
    until xcode-select -p &>/dev/null; do
        sleep 5
    done
fi

# Final confirmation message
printf "\n\033[1;32m✓ Xcode Command Line Tools are ready\033[0m\n"