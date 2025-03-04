#!/usr/bin/env bash

DIRS=(nix common)

case "$(uname -s)" in
Darwin*)
  DIRS+=(macos)
  ;;
esac

for DIR in "${DIRS[@]}"; do
  while read -r file; do
    homepath="$(echo "$file" | sed "s/$DIR\///")"
    rm "$HOME/$homepath"
    ln -s "$PWD/$file" "$HOME/$homepath"
  done < <(find "$DIR" -type f)
done
