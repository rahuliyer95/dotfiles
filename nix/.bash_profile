# shellcheck source=/dev/null
[[ -s "$HOME/.profile" ]] && . "$HOME/.profile"

# Login shells need to source .bashrc for the full interactive config
# shellcheck source=/dev/null
[[ -s "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
