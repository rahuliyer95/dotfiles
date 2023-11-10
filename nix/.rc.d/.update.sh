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
echo "############"
echo "Homebrew"
echo "############"
echo ""
command -v brew > /dev/null \
  && brew update \
  && brew upgrade \
  && brew upgrade --cask

# npm
echo ""
echo "############"
echo "npm"
echo "############"
echo ""
command -v npm > /dev/null \
  && npm up -g

# YarnPkg
echo ""
echo "############"
echo "YarnPkg"
echo "############"
echo ""
command -v yarnpkg > /dev/null \
  && yarnpkg global upgrade

# ruby
echo ""
echo "############"
echo "Ruby Gems"
echo "############"
echo ""
command -v gem > /dev/null \
  && gem update

# pip3
if command -v pip3 > /dev/null; then
  echo ""
  echo "############"
  echo "pip3"
  echo "############"
  echo ""
  pip3 install --upgrade pip || sudo pip3 install --upgrade pip
  if command -v pip-autoremove > /dev/null; then
    echo ""
    echo "############"
    echo "pip packages"
    echo "############"
    echo ""
    pip-autoremove -L \
      | awk '{ printf "%s ", $1 }' \
      | sort \
      | xargs pip3 install --upgrade
  fi
fi

# antibody
echo ""
echo "############"
echo "Antibody"
echo "############"
echo ""
command -v antibody > /dev/null \
  && [ -f "$HOME/.zshrc.d/.plugins" ] \
  && antibody bundle < "$HOME/.zshrc.d/.plugins" > "$HOME/.zshrc.d/.plugins.bundle" \
  && antibody update

# neovim
echo ""
echo "############"
echo "Neovim"
echo "############"
echo ""
command -v nvim > /dev/null \
  && nvim +PlugUpgrade +PlugUpdate +qall \
  && nvim +CocUpdate +qall

# rustup
echo ""
echo "############"
echo "Rustup"
echo "############"
echo ""
command -v rustup > /dev/null \
  && rustup update

# cleanup
[ -x "$HOME/.rc.d/.cleanup.sh" ] \
  && "$HOME/.rc.d/.cleanup.sh"
