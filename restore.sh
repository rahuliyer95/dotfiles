#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$0")"

# Xcode CLI tools
sudo xcode-select --install

# OS sepcific setup
case "$(uname -s)" in
Darwin*)
  # Homebrew
  echo "🍺 Homebrew"
  if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew doctor
  brew update
  brew bundle --file "$SCRIPT_DIR/packages/Brewfile"
  ;;
# Linux*)
#   ;;
esac

# uv
echo "Installing uv…"
curl -fsSL "https://astral.sh/uv/install.sh" | sh -
echo "Install python versions with 'uv python install <version>'"

# pnpm
echo "Installing pnpm…"
curl -fsSL "https://get.pnpm.io/install.sh" | sh -
echo "Install node versions with 'pnpm env -g add <version>'"

case "$(uname -s)" in
Darwin*)
  echo "Restart your shell and then run $SCRIPT_DIR/packages/setup_macos.sh"
  ;;
# Linux*)
#   ;;
esac
