#!/usr/bin/env bash

# Load profile
for file in "$HOME/.rc.d/"{.aliases,.exports,.path,.functions}; do
  [ -f "$file" ] && . "$file"
done

# Ask sudo and keep-alive
sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done > /dev/null 2>&1 &

# Homebrew
command -v brew > /dev/null \
  && brew update \
  && brew upgrade \
  && brew upgrade --cask

# NPM
command -v npm > /dev/null \
  && npm i -g --force npm \
  && npm up -g

# YarnPkg
command -v yarnpkg > /dev/null \
  && yarnpkg global upgrade

# ruby
command -v gem > /dev/null \
  && gem update

# pip3
pip-upgrade

# neovim
command -v nvim > /dev/null \
  && nvim +PlugUpgrade +PlugUpdate +qall \
  && nvim +CocUpdate +qall

# antibody
command -v antibody > /dev/null \
  && [ -f "$HOME/.zshrc.d/.plugins" ] \
  && antibody bundle < "$HOME/.zshrc.d/.plugins" > "$HOME/.zshrc.d/.plugins.bundle" \
  && antibody update

# cleanup
[ -x "$HOME/.rc.d/.cleanup.sh" ] \
  && "$HOME/.rc.d/.cleanup.sh"
