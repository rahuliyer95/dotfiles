#!/usr/bin/env bash

DIRS=(nix common)

case "$(uname -s)" in
Darwin*)
  DIRS+=(macos)
  ;;
esac

for DIR in "${DIRS[@]}"; do
  while read -r file; do
    homepath="$HOME/$(echo "$file" | sed "s/$DIR\///")"
    homedir="$(dirname "$homepath")"
    rm "$homepath"
    mkdir -p "$homedir"
    ln -s "$PWD/$file" "$homepath"
  done < <(find "$DIR" -type f)
done
