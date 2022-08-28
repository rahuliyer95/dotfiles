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
./brew.sh

# tpm
mkdir -p "$HOME/.tmux/plugins/tpm"
git clone "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"

# vim-anywhere
curl -fsSL "https://raw.github.com/cknadler/vim-anywhere/master/install" | bash

# sync dotfiles
./sync.sh

# antibody
antibody bundle < "$HOME/.zshrc.d/.plugins" > "$HOME/.zshrc.d/.plugins.bundle"

# macOS settings
./packages/setup-macos.sh
