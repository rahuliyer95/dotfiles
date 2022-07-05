#!/bin/bash
for DIR in nix common; do
  rsync -ahvu --exclude ".git" ./${DIR}/ ~
done
