#!/usr/bin/env zsh

if [ -n "$ZSH_DEBUGRC" ]; then
  zmodload zsh/zprof
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ $- == *i* ]]; then
  [ -f "$HOME/.zshrc.d/.zsh_profile" ] && . "$HOME/.zshrc.d/.zsh_profile"
fi

# cargo
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# bun completions
[ -s "$HOME/.bun/_bun" ] && . "$HOME/.bun/_bun"

if [ -n "$ZSH_DEBUGRC" ]; then
  zprof
fi

# pnpm
export PNPM_HOME="/Users/rahuliyer/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
