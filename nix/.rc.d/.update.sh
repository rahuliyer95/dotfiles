#!/usr/bin/env bash

# Load profile
for file in "$HOME/.rc.d/."{exports,path,aliases}; do
  # shellcheck source=/dev/null
  [ -f "$file" ] && source "$file"
done

# Ask sudo and keep-alive
sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done >/dev/null 2>&1 &

# Homebrew
if command -v brew >/dev/null; then
  echo ""
  echo "╭──────────────╮"
  echo "│ 🍺 Homebrew  │"
  echo "╰──────────────╯"
  echo ""
  brew update &&
    brew upgrade &&
    brew upgrade --cask
fi

# Aptitude
if command -v apt-get >/dev/null; then
  echo ""
  echo -e "╭──────────────╮"
  echo -e "│   Aptitude  │"
  echo -e "╰──────────────╯"
  echo ""
  sudo apt-get update -y &&
    sudo apt-get upgrade -y
fi

# pi-hole
if command -v pihole >/dev/null; then
  echo ""
  echo -ne "\e[31m"
  echo -e "╭────────────╮"
  echo -e "│   pihole  │"
  echo -e "╰────────────╯"
  echo -ne "\e[0m"
  echo ""
  pihole -up
fi

# npm
if command -v npm >/dev/null; then
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
if command -v yarnpkg >/dev/null; then
  echo ""
  echo -ne "\e[34m"
  echo -e "╭─────────────╮"
  echo -e "│   YarnPkg  │" # \uE6A7
  echo -e "╰─────────────╯"
  echo -ne "\e[0m"
  echo ""
  yarnpkg global upgrade
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

# pip3
if command -v pip3 >/dev/null; then
  echo ""
  echo -ne "\e[33m"
  echo -e "╭─────────╮"
  echo -e "│   pip  │" # \uE73C
  echo -e "╰─────────╯"
  echo -ne "\e[0m"
  echo ""
  pip3 install --upgrade pip || sudo pip3 install --upgrade pip
  if command -v pip-autoremove >/dev/null; then
    echo ""
    echo -ne "\e[33m"
    echo -e "╭──────────────────╮"
    echo -e "│   pip packages  │" # \uE73C
    echo -e "╰──────────────────╯"
    echo -ne "\e[0m"
    echo ""
    pip-autoremove -L |
      awk '{ printf "%s ", $1 }' |
      sort |
      xargs pip3 install --upgrade
  fi
fi

# antibody
if command -v antibody >/dev/null && [ -f "$HOME/.zshrc.d/.plugins" ]; then
  echo ""
  echo "╭────────────╮"
  echo "│  Antibody  │"
  echo "╰────────────╯"
  echo ""
  antibody bundle <"$HOME/.zshrc.d/.plugins" >"$HOME/.zshrc.d/.plugins.bundle" &&
    antibody update
fi

# neovim
if command -v nvim >/dev/null; then
  echo ""
  echo -ne "\e[32m"
  echo -e "╭────────────╮"
  echo -e "│   Neovim  │" # \uF36F
  echo -e "╰────────────╯"
  echo -ne "\e[0m"
  echo ""
  nvim +PlugUpgrade +PlugUpdate +qall &&
    nvim +CocUpdate +qall
fi

# rustup
if command -v rustup >/dev/null; then
  echo ""
  echo -ne "\e[31m"
  echo -e "╭────────────╮"
  echo -e "│   Rustup  │" # \uE7A8
  echo -e "╰────────────╯"
  echo -ne "\e[0m"
  echo ""
  rustup update
fi

# cleanup
[ -x "$HOME/.rc.d/.cleanup.sh" ] &&
  "$HOME/.rc.d/.cleanup.sh"
