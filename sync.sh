#!/bin/bash
DIRS=(nix common)
case "$(uname -s)" in
  Darwin*)
    DIRS+=(macos)
    ;;
esac
for DIR in "${DIRS[@]}"; do
  rsync -azvhrlP --exclude ".git" "./${DIR}/" "$HOME"
done
