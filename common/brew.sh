#!/bin/bash

# Exit immediately if a command fails, treat unset variables as errors, and fail on pipe errors
set -Eeuo pipefail

# Print a message with the script name and line number if any command fails
trap 'echo "❌ FAILED: ${BASH_SOURCE[0]} at line $LINENO"' ERR

# Print header for Homebrew check
printf "\n\033[1;36m=== Checking Homebrew ===\033[0m\n"

# Check if Homebrew is already installed
if command -v brew >/dev/null 2>&1; then
    printf "\033[1;33m⚠ Homebrew is already installed\033[0m\n"
else
    # Install Homebrew
    printf "\033[1;36mInstalling Homebrew...\033[0m\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
        # Exit if installation fails
        printf "\033[1;31m✗ Homebrew installation failed. Exiting...\033[0m\n"
        exit 1
    }
fi

# Print header for mas check
printf "\n\033[1;36m=== Checking mas (Mac App Store CLI) ===\033[0m\n"

# Check if mas is already installed
if command -v mas >/dev/null 2>&1; then
    printf "\033[1;33m⚠ mas is already installed\033[0m\n"
else
    # Install mas
    printf "\033[1;36mInstalling mas...\033[0m\n"
    brew install mas || {
        printf "\033[1;31m✗ mas installation failed. Exiting...\033[0m\n"
        exit 1
    }
fi

# Check App Store sign-in status (mas has no "account" command)
if mas list >/dev/null 2>&1; then
    printf "\033[1;32m✓ Signed in to Mac App Store\033[0m\n"
else
    printf "\033[1;31m✗ Not signed in to Mac App Store\033[0m\n"
    printf "\033[1;31m  Please sign in via the App Store app before running brew bundle\033[0m\n"
    exit 1
fi

# Print header for package installation
printf "\n\033[1;36m=== Installing packages via brew bundle ===\033[0m\n"

# Install packages defined in the global Brewfile
brew bundle --global

# Final confirmation message
printf "\n\033[1;32m✓ Homebrew packages installed successfully\033[0m\n"