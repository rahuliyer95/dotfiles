#!/usr/bin/env zsh

# Load profile
for file in $HOME/.rc.d/.{exports,path,aliases}; do
  # shellcheck source=/dev/null
  [ -f "$file" ] && source "$file"
done
for file in $HOME/.rc.d/.{local.pre.sh,local.post.sh}; do
  # shellcheck source=/dev/null
  [ -f "$file" ] && source "$file"
done

# Homebrew
if command -v brew > /dev/null; then
  echo ""
  echo "╭──────────────╮"
  echo "│ 🍺 Homebrew  │"
  echo "╰──────────────╯"
  echo ""
  brew update \
    && brew upgrade \
    && brew upgrade --cask
fi

# Aptitude
if command -v apt-get > /dev/null; then
  echo ""
  echo -e "╭──────────────╮"
  echo -e "│   Aptitude  │"
  echo -e "╰──────────────╯"
  echo ""
  sudo apt-get update -y \
    && sudo apt-get upgrade -y
fi

# pi-hole
if command -v pihole > /dev/null; then
  echo ""
  echo -ne "\e[31m"
  echo -e "╭────────────╮"
  echo -e "│   pihole  │"
  echo -e "╰────────────╯"
  echo -ne "\e[0m"
  echo ""
  sudo pihole -up
fi

# npm
if command -v npm > /dev/null; then
  echo ""
  echo -ne "\e[32m"
  echo -e "╭─────────╮"
  echo -e "│   npm  │" # \uE71E
  echo -e "╰─────────╯"
  echo -ne "\e[0m"
  echo ""
  npm up -g
fi

# YarnPkg
if command -v yarnpkg > /dev/null; then
  echo ""
  echo -ne "\e[34m"
  echo -e "╭─────────────╮"
  echo -e "│   YarnPkg  │" # \uE6A7
  echo -e "╰─────────────╯"
  echo -ne "\e[0m"
  echo ""
  yarnpkg global upgrade
fi

# pnpm
if command -v pnpm > /dev/null; then
  echo ""
  echo -ne "\e[33m"
  echo -e "╭──────────╮"
  echo -e "│   pnpm  │" # \ue865
  echo -e "╰──────────╯"
  echo -ne "\e[0m"
  echo ""
  pnpm self-update
  pnpm up -LPgy
  pnpm completion zsh > "$(realpath "$HOME/.zsh.d/_pnpm")"
fi

# ruby
# if command -v gem >/dev/null; then
#   echo ""
#   echo -ne "\e[31m"
#   echo -e "╭───────────────╮"
#   echo -e "│   Ruby Gems  │" # \uE21E
#   echo -e "╰───────────────╯"
#   echo -ne "\e[0m"
#   echo ""
#   gem update
# fi

# uv
if command -v uv > /dev/null; then
  echo ""
  echo -ne "\e[33m"
  echo -e "╭────────╮"
  echo -e "│   uv  │" # \uE73C
  echo -e "╰────────╯"
  echo -ne "\e[0m"
  echo ""
  uv self update
  uv tool upgrade --all
  uv generate-shell-completion zsh > "$(realpath "$HOME/.zsh.d/_uv")"
  uvx --generate-shell-completion zsh > "$(realpath "$HOME/.zsh.d/_uvx")"
fi

# antidote
if command -v antidote > /dev/null && [ -f "$HOME/.zshrc.d/.plugins" ]; then
  echo ""
  echo "╭──────────────╮"
  echo "│  💉Antidote  │"
  echo "╰──────────────╯"
  echo ""
  antidote update
fi

# neovim
if command -v nvim > /dev/null; then
  echo ""
  echo -ne "\e[32m"
  echo -e "╭────────────╮"
  echo -e "│   Neovim  │" # \uF36F
  echo -e "╰────────────╯"
  echo -ne "\e[0m"
  echo ""
  nvim --headless "+Lazy! sync" +qall \
    && nvim --headless +MasonUpdate +qall \
    && nvim --headless +TSUpdateSync +qall
fi

# rustup
if command -v rustup > /dev/null; then
  echo ""
  echo -ne "\e[31m"
  echo -e "╭────────────╮"
  echo -e "│   Rustup  │" # \uE7A8
  echo -e "╰────────────╯"
  echo -ne "\e[0m"
  echo ""
  rustup update
  rustup completions zsh > "$(realpath "$HOME/.zsh.d/_rustup")"
fi

# Regenerate completion scripts
# 1Password
if command -v op > /dev/null; then
  op completion zsh > "$(realpath "$HOME/.zsh.d/_op")"
fi

# cleanup
if command -v mole > /dev/null; then
  mole clean
fi
