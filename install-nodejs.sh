#!/usr/bin/env bash
# Installs Node.js (LTS by default).
#
# Usage:
#   ./install-nodejs.sh [version]
#
#   version   Node.js major version to install (default: lts, e.g. "20", "22").
#
# Uses the system package manager when available (apt, dnf/yum, pacman, apk),
# falling back to nvm (https://github.com/nvm-sh/nvm) otherwise.

set -euo pipefail

NODE_VERSION="${1:-lts}"

install_via_nvm() {
  export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  fi
  # shellcheck disable=SC1091
  . "$NVM_DIR/nvm.sh"
  nvm install "$NODE_VERSION"
  nvm use "$NODE_VERSION"
}

main() {
  if command -v node >/dev/null 2>&1; then
    echo "Node.js is already installed: $(node --version)"
    exit 0
  fi

  if command -v apt-get >/dev/null 2>&1; then
    major="${NODE_VERSION#v}"
    [ "$major" = "lts" ] && major="20"
    curl -fsSL "https://deb.nodesource.com/setup_${major}.x" | sudo -E bash -
    sudo apt-get install -y nodejs
  elif command -v dnf >/dev/null 2>&1; then
    major="${NODE_VERSION#v}"
    [ "$major" = "lts" ] && major="20"
    curl -fsSL "https://rpm.nodesource.com/setup_${major}.x" | sudo -E bash -
    sudo dnf install -y nodejs
  elif command -v yum >/dev/null 2>&1; then
    major="${NODE_VERSION#v}"
    [ "$major" = "lts" ] && major="20"
    curl -fsSL "https://rpm.nodesource.com/setup_${major}.x" | sudo -E bash -
    sudo yum install -y nodejs
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --noconfirm nodejs npm
  elif command -v apk >/dev/null 2>&1; then
    sudo apk add --no-cache nodejs npm
  else
    echo "No supported system package manager found; installing via nvm instead."
    install_via_nvm
  fi

  if command -v node >/dev/null 2>&1; then
    echo "Node.js installed: $(node --version)"
  else
    echo "Node.js installation failed." >&2
    exit 1
  fi
}

main "$@"
