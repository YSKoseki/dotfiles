#!/bin/bash

# Exit immediately if a command fails, treat unset variables as errors, and fail on pipe errors
set -Eeuo pipefail

# Print a message with the script name and line number if any command fails
trap 'echo "❌ FAILED: ${BASH_SOURCE[0]} at line $LINENO"' ERR

# Determine the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "SCRIPT_DIR=${SCRIPT_DIR}"

# Print header for symbolic link creation
printf "\n\033[1;36m=== Creating symbolic links ===\033[0m\n"

# Loop over hidden files in the script directory
for dotfile in "${SCRIPT_DIR}"/.??* ; do
    # Skip certain files and directories
    [[ "$dotfile" == "${SCRIPT_DIR}/.git" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.github" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.gitignore" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.gitattributes" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.vscode" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.DS_Store" ]] && continue
    
    # Create a symbolic link in the home directory, force overwrite if exists, show verbose output
    ln -fnsv "$dotfile" "$HOME"
done

# Final confirmation message
printf "\n\033[1;32m✓ dotfiles linked successfully\033[0m\n"