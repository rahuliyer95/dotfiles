#!/bin/bash
DIRS=(nix common)
case "$(uname -s)" in
  Darwin*)
    DIRS+=(macos)
    ;;
esac
for DIR in "${DIRS[@]}"; do
  while read -r file; do
    homepath="$(echo "$file" | sed "s/$DIR\///")"
    cp "$HOME/$homepath" "./$file"
  done < <(find "$DIR" -type f)
done
