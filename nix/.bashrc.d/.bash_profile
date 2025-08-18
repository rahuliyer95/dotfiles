# Load path
for file in $HOME/.rc.d/.{exports,path}; do
  # shellcheck source=/dev/null
  [ -f "$file" ] && . "$file" 2> /dev/null
done

# Load the common shell dotfiles
for file in $HOME/.rc.d/.{aliases,extras,functions}; do
  # shellcheck source=/dev/null
  [ -f "$file" ] && . "$file" 2> /dev/null
done

for file in $HOME/.bashrc.d/.{grc.bashrc,local,bash_prompt}; do
  # shellcheck source=/dev/null
  [ -f "$file" ] && . "$file" 2> /dev/null
done

unset file

# fzf goodness
# shellcheck source=/dev/null
[ -f "$HOME/.fzf.bash" ] && . "$HOME/.fzf.bash"

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
# * `nocaseglob` Case-insensitive globbing (used in pathname expansion)
# * `histappend` Append to the Bash history file, rather than overwriting it
# * `cdspell` Autocorrect typos in path names when using `cd`
for option in nocaseglob histappend cdspell autocd globstar; do
  shopt -s "$option" 2> /dev/null
done

# vi key bindings
set -o vi

# Add tab completion for many Bash commands
if [ -n "$(command -v brew 2> /dev/null)" ]; then
  PREFIX="$(brew --prefix bash-completion 2> /dev/null)"
  export BASH_COMPLETION_COMPAT_DIR="$PREFIX/etc/bash_completion.d"
  if [ -d "$PREFIX" ]; then
    # shellcheck source=/dev/null
    . "$PREFIX/etc/profile.d/bash_completion.sh" 2> /dev/null
  fi
  for file in "$PREFIX/etc/bash_completion.d/"*; do
    # shellcheck source=/dev/null
    . "$file" 2> /dev/null
  done
  # mcfly
  if [ -f "$(brew --prefix)/opt/mcfly/mcfly.bash" ]; then
    # shellcheck source=/dev/null
    . "$(brew --prefix)/opt/mcfly/mcfly.bash"
  fi
elif [ -d "/usr/local/etc/bash_completion.d/" ]; then
  [ -f "/usr/local/etc/bash_completion.d/.bash_completion" ] && . "/usr/local/etc/bash_completion.d/.bash_completion"
  for file in "/usr/local/etc/bash_completion.d/"*; do
    # shellcheck source=/dev/null
    [ -f "$file" ] && . "$file" 2> /dev/null
  done
fi
if [ -f "/etc/bash_completion" ]; then
  . "/etc/bash_completion" 2> /dev/null
fi

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults
