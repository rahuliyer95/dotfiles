if [[ $- == *i* ]]; then
  [ -n "${PS1}" ] && . "$HOME/.bashrc.d/.bash_profile"
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi
