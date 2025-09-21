#!/usr/bin/env bash

SCRIPT_DIR="$(realpath "$(dirname "$0")")"

# OS sepcific setup
case "$(uname -s)" in
Darwin*)
  # Homebrew
  echo "🍺 Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew doctor
  brew update
  brew bundle --file "$SCRIPT_DIR/packages/Brewfile"
  # macOS settings
  "$SCRIPT_DIR/packages/setup_macos.sh"
  ;;
# Linux*)
#   ;;
esac

# uv
echo "Installing uv…"
curl -fsSL "https://astral.sh/uv/install.sh" | sh -

# pnpm
echo "Installing pnpm…"
curl -fsSL "https://get.pnpm.io/install.sh" | sh -

