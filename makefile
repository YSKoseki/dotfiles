.PHONY: all xcode link defaults brew gh

# Initialize macOS.
all:
	@echo "\033[1;36m▶▶ Initialize macOS\033[0m"
	@$(MAKE) xcode
	@$(MAKE) link
	@$(MAKE) defaults
	@$(MAKE) brew
	@$(MAKE) gh

HEADER = \
	printf "\n\033[1;34m========================================\033[0m\n"; \
	printf "\033[1;34m  Run %s\033[0m\n"; \
	printf "\033[1;34m========================================\033[0m\n";
	
# Install xcode.
xcode:
	@$(HEADER) "xcode.sh"
	@common/xcode.sh || { \
		echo "\033[1;31m❌ FAILED: common/xcode.sh\033[0m"; \
		exit 1; \
	}
	
# Link common dotfiles.
link:
	@$(HEADER) "link.sh"
	@common/link.sh || { \
		echo "\033[1;31m❌ FAILED: common/link.sh\033[0m"; \
		exit 1; \
	}

# Set macOS system preferences.
defaults:
	@$(HEADER) "defaults.sh"
	@common/defaults.sh || { \
		echo "\033[1;31m❌ FAILED: common/defaults.sh\033[0m"; \
		exit 1; \
	}

# Install applications using Homebrew.
brew:
	@$(HEADER) "brew.sh"
	@common/brew.sh || { \
		echo "\033[1;31m❌ FAILED: common/brew.sh\033[0m"; \
		exit 1; \
	}

# Install gh extensions.
gh:
	@$(HEADER) "gh.sh"
	@common/gh.sh || { \
		echo "\033[1;31m❌ FAILED: common/gh.sh\033[0m"; \
		exit 1; \
	}