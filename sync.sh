#!/bin/bash
for DIR in nix common; do
  rsync -azvhrlP --exclude ".git" ./${DIR}/ ~
done
