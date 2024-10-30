#!/usr/bin/env bash

layout_uv() {
  [[ $# -gt 0 ]] && shift
  unset PYTHONHOME
  python_path="$(uv python find)"
  python_version="$($python_path -V | cut -d' ' -f 2 | cut -d . -f 1-2)"
  if [[ -z $python_version ]]; then
    log_error "Could not find python's version"
    return 1
  fi

  if [ -n "${VIRTUAL_ENV:-}" ]; then
    local REPLY
    realpath.absolute "$VIRTUAL_ENV"
    VIRTUAL_ENV="$REPLY"
  else
    VIRTUAL_ENV="$(direnv_layout_dir)/python-$python_version"
  fi
  export UV_PROJECT_ENVIRONMENT="$VIRTUAL_ENV"
  if [ ! -d "$VIRTUAL_ENV" ]; then
    uv venv "$@" "$VIRTUAL_ENV"
  fi
  export VIRTUAL_ENV
  PATH_add "$VIRTUAL_ENV/bin"
}
