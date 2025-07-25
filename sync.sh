#!/usr/bin/env bash

DIRS=(nix common)

case "$(uname -s)" in
Darwin*)
  DIRS+=(macos)
  ;;
Linux*)
  DIRS+=(linux)
  ;;
esac

for DIR in "${DIRS[@]}"; do
  while read -r file; do
    homepath="$HOME/$(echo "$file" | sed "s/$DIR\///")"
    homedir="$(dirname "$homepath")"
    echo "$file -> $homepath"
    rm "$homepath"
    mkdir -p "$homedir"
    ln -s "$PWD/$file" "$homepath"
  done < <(find "$DIR" -type f -o -type l)
done
