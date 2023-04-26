#!/usr/bin/env bash

# Load profile
for file in "$HOME/.rc.d/"{.aliases,.exports,.path}; do
  # shellcheck  source=/dev/null
  [ -f "$file" ] && source "$file"
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
if command -v pip3 > /dev/null; then
  pip3 install --upgrade pip || sudo pip3 install --upgrade pip
  if command -v pip-autoremove > /dev/null; then
    while read -r package; do
      pip3 install --upgrade "$package"
    done < <(pip-autoremove -L | awk '{ print $1 }')
  fi
fi

# antibody
command -v antibody > /dev/null \
  && [ -f "$HOME/.zshrc.d/.plugins" ] \
  && antibody bundle < "$HOME/.zshrc.d/.plugins" > "$HOME/.zshrc.d/.plugins.bundle" \
  && antibody update

# neovim
command -v nvim > /dev/null \
  && nvim +PlugUpgrade +PlugUpdate +qall \
  && nvim +CocUpdate +qall

# cleanup
[ -x "$HOME/.rc.d/.cleanup.sh" ] \
  && "$HOME/.rc.d/.cleanup.sh"
