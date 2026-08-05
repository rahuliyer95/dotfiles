#!/usr/bin/env bash

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKED_UP=0
DRY_RUN=0
DIRS=(nix common)
LINKED=0
MANAGED_DIRS=()
PRUNED=0

case "$(uname -s)" in
  Darwin*)
    DIRS+=(macos)
    ;;
  Linux*)
    DIRS+=(linux)
    ;;
esac

usage() {
  cat << EOF
Usage: ${0##*/} [options]

Symlink dotfiles from this repository into \$HOME.
Real files are backed up to *.bak, and dangling links into this repo are removed.

Options:
  -n, --dry-run  Show what would change without touching the filesystem
  -h, --help     Show this help
EOF
}

run() {
  [ "$DRY_RUN" -eq 1 ] && return 0
  "$@"
}

# Walk up to $HOME so the scan can find leftovers from deleted files
track() {
  local path="$1"
  while [ -n "$path" ] && [ "$path" != "$HOME" ] && [ "$path" != "/" ]; do
    MANAGED_DIRS+=("$path")
    path="${path%/*}"
  done
  MANAGED_DIRS+=("$HOME")
}

link() {
  local src="$1" dest="$2"
  local dest_dir="${2%/*}"
  track "$dest_dir"
  # -ef compares inodes, so an already correct link costs no subprocess
  if [ -L "$dest" ] && [ "$dest" -ef "$src" ]; then
    return 0
  fi
  if [ -L "$dest" ]; then
    run rm -f "$dest"
  elif [ -e "$dest" ]; then
    echo "backup $dest -> $dest.bak"
    run mv -f "$dest" "$dest.bak"
    BACKED_UP=$((BACKED_UP + 1))
  fi
  echo "link   $dest -> $src"
  [ -d "$dest_dir" ] || run mkdir -p "$dest_dir"
  run ln -sfn "$src" "$dest"
  LINKED=$((LINKED + 1))
}

prune() {
  local dest path target
  local dirs=()
  while IFS= read -r path; do
    dirs+=("$path")
  done < <(printf '%s\n' "${MANAGED_DIRS[@]}" | sort -u)
  while IFS= read -r dest; do
    # -e follows the link, so an existing target means it is not dangling
    [ -e "$dest" ] && continue
    target="$(readlink "$dest")"
    case "$target" in
      "$REPO_DIR"/*)
        echo "prune  $dest -> $target"
        run rm -f "$dest"
        PRUNED=$((PRUNED + 1))
        ;;
    esac
  done < <(find "${dirs[@]}" -maxdepth 2 -type l 2> /dev/null | sort -u)
}

while [ $# -gt 0 ]; do
  case "$1" in
    -n | --dry-run)
      DRY_RUN=1
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    *)
      echo "unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

[ "$DRY_RUN" -eq 1 ] && echo "dry run, no changes will be made" >&2

for dir in "${DIRS[@]}"; do
  while IFS= read -r file; do
    link "$file" "$HOME/${file#"$REPO_DIR/$dir/"}"
  done < <(find "$REPO_DIR/$dir" \( -type f -o -type l \) ! -name '.DS_Store')
done

prune

echo "linked $LINKED, backed up $BACKED_UP, pruned $PRUNED"
