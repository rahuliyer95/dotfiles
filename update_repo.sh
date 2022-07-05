#!/bin/bash
for DIR in nix common; do
  while read -r file; do
    homepath="$(echo "$file" | sed "s/$DIR\///")"
    cp "$HOME/$homepath" "./$file"
  done < <(find "$DIR" -type f)
done
