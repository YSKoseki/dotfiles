.PHONY: all xcode link defaults brew gh

# Initialize macOS.
all: xcode link defaults brew gh

# Install xcode.
xcode:
	@printf "\n\033[1;34m========================================\033[0m\n"
	@printf "\033[1;34m  Run xcode.sh\033[0m\n"
	@printf "\033[1;34m========================================\033[0m\n"
	@common/xcode.sh

# Link common dotfiles.
link:
	@printf "\n\033[1;34m========================================\033[0m\n"
	@printf "\033[1;34m  Run link.sh\033[0m\n"
	@printf "\033[1;34m========================================\033[0m\n"
	@common/link.sh

# Set macOS system preferences.
defaults:
	@printf "\n\033[1;34m========================================\033[0m\n"
	@printf "\033[1;34m  Run defaults.sh\033[0m\n"
	@printf "\033[1;34m========================================\033[0m\n"
	@common/defaults.sh

# Install applications using Homebrew.
brew:
	@printf "\n\033[1;34m========================================\033[0m\n"
	@printf "\033[1;34m  Run brew.sh\033[0m\n"
	@printf "\033[1;34m========================================\033[0m\n"
	@common/brew.sh

# Install gh extensions.
gh:
	@printf "\n\033[1;34m========================================\033[0m\n"
	@printf "\033[1;34m  Run gh.sh\033[0m\n"
	@printf "\033[1;34m========================================\033[0m\n"
	@common/gh.sh