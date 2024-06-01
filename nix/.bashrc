#!/usr/bin/env bash

if [[ $- == *i* ]]; then
  [ -n "${PS1}" ] && . "$HOME/.bashrc.d/.bash_profile"
fi
