#!/usr/bin/env bash

# Exit immediately if a command fails, treat unset variables as errors, and fail on pipe errors
set -Eeuo pipefail

# Print a message with the script name and line number if any command fails
trap 'echo "❌ FAILED: ${BASH_SOURCE[0]} at line $LINENO"' ERR

# Print header for macOS default settings
printf "\n\033[1;36m=== Applying macOS default settings ===\033[0m\n"

# Array to store failed items
failed_items=()

# Function to execute a command and print result
print_result() {
	local description="$1"
	shift
	if "$@" 2>/dev/null; then
		printf "\033[1;32m✓\033[0m %s\n" "$description"
	else
		printf "\033[1;31m✗\033[0m %s\n" "$description"
		failed_items+=("$description")
	fi
}

# Apply macOS settings
print_result "Enable Dock auto-hide" defaults write com.apple.dock autohide -bool true
print_result "Set Dock animation speed to fastest" defaults write com.apple.dock autohide-time-modifier -int 0
print_result "Set Dock auto-hide delay to minimum" defaults write com.apple.dock autohide-delay -int 0
print_result "Set Dock window minimization effect to scale" defaults write com.apple.dock mineffect -string "scale"
print_result "Disable Trash empty warning in Finder" defaults write com.apple.finder WarnOnEmptyTrash -bool false
#print_result "Show full POSIX path in Finder window title" defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
print_result "Show Finder status bar" defaults write com.apple.finder ShowStatusBar -bool true
print_result "Show ~/Library folder in Finder" chflags nohidden ~/Library
print_result "Reduce initial key repeat delay" defaults write -g InitialKeyRepeat -int 25
print_result "Increase key repeat rate" defaults write -g KeyRepeat -int 2
print_result "Increase mouse tracking speed" defaults write -g com.apple.mouse.scaling 3
print_result "Increase trackpad tracking speed" defaults write -g com.apple.trackpad.scaling 2.5
print_result "Enable dragging for built-in trackpad" defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
print_result "Enable dragging for Bluetooth trackpad" defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true
print_result "Enable drag lock for built-in trackpad" defaults write com.apple.AppleMultitouchTrackpad DragLock -bool true
print_result "Enable drag lock for Bluetooth trackpad" defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool true
print_result "Disable application open confirmation dialog" defaults write com.apple.LaunchServices LSQuarantine -bool false
print_result "Disable live conversion for input method" defaults write com.apple.inputmethod.Kotoeri JIMPrefLiveConversionKey -bool false
print_result "Disable .DS_Store creation on network volumes" defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
print_result "Disable .DS_Store creation on USB volumes" defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Restart affected applications
printf "\n\033[1;36m=== Restarting affected applications ===\033[0m\n"
for app in "Dock" "Finder" "SystemUIServer" "ControlCenter"; do
	if killall "${app}" 2>/dev/null; then
		printf "\033[1;32m✓ %s restarted\033[0m\n" "${app}"
	else
		printf "\033[1;33m⚠ %s was not running or could not be restarted\033[0m\n" "${app}"
		failed_items+=("$app restart failed")
	fi
done

# Print final result
printf "\n"
if [ ${#failed_items[@]} -eq 0 ]; then
	printf "\033[1;32m✓ All macOS default settings applied successfully\033[0m\n"
else
	printf "\033[1;31m✗ Some settings or restarts failed:\033[0m\n"
	for item in "${failed_items[@]}"; do
		printf "  - %s\n" "$item"
	done
fi