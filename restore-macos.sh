#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2> /dev/null &

# Homebrew
chmod +x brew.sh
./brew.sh

# tpm
mkdir -p "$HOME/.tmux/plugins/tpm"
git clone "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"

# vim-anywhere
curl -fsSL "https://raw.github.com/cknadler/vim-anywhere/master/install" | bash

# cht.sh
curl -sSLo "/usr/local/bin/cht.sh" "https://cht.sh/:cht.sh"
chmod +x "/usr/local/bin/cht.sh"

# sync dotfiles
chmod +x sync.sh
./sync.sh

# antibody
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
/usr/local/bin/antibody bundle < "$HOME/.zshrc.d/.plugins" > "$HOME/.zshrc.d/.plugins.bundle"

# macOS settings
chmod +x ./packages/.macos
./packages/.macos
