.PHONY: all xcode link defaults brew gh

# Use bash explicitly for all commands (GitHub Actions compatible)
SHELL := /bin/bash

# =========================
# Main target
# =========================
all: xcode link defaults brew gh
	@echo "\033[1;36m▶▶ macOS initialization complete\033[0m"

# =========================
# Header / Footer function
# =========================
define HEADER
printf "\n\033[1;34m========================================\033[0m\n"
printf "\033[1;34m  [START] $1\033[0m\n"
printf "\033[1;34m========================================\033[0m\n"
endef

define FOOTER
printf "\033[1;34m========================================\033[0m\n"
printf "\033[1;34m  [DONE] $1\033[0m\n"
printf "\033[1;34m========================================\033[0m\n"
endef

# =========================
# Install Xcode CLI
# =========================
xcode:
	@$(call HEADER,xcode.sh)
	@bash common/xcode.sh || { \
		echo "\033[1;31m❌ FAILED: common/xcode.sh\033[0m"; \
		exit 1; \
	}
	@$(call FOOTER,xcode.sh)

# =========================
# Link dotfiles
# =========================
link:
	@$(call HEADER,link.sh)
	@bash common/link.sh || { \
		echo "\033[1;31m❌ FAILED: common/link.sh\033[0m"; \
		exit 1; \
	}
	@$(call FOOTER,link.sh)

# =========================
# Apply macOS defaults
# =========================
defaults:
	@$(call HEADER,defaults.sh)
	@bash common/defaults.sh || { \
		echo "\033[1;31m❌ FAILED: common/defaults.sh\033[0m"; \
		exit 1; \
	}
	@$(call FOOTER,defaults.sh)

# =========================
# Install Homebrew apps
# =========================
brew:
	@$(call HEADER,brew.sh)
	@bash common/brew.sh || { \
		echo "\033[1;31m❌ FAILED: common/brew.sh\033[0m"; \
		exit 1; \
	}
	@$(call FOOTER,brew.sh)

# =========================
# Install GitHub CLI extensions
# =========================
gh:
	@$(call HEADER,gh.sh)
	@bash common/gh.sh || { \
		echo "\033[1;31m❌ FAILED: common/gh.sh\033[0m"; \
		exit 1; \
	}
	@$(call FOOTER,gh.sh)