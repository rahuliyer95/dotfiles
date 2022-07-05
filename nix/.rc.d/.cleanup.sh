#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive sudo until `clenaup.sh` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2> /dev/null &

old_available="$(df -k / | tail -1 | awk '{print $4}')"

echo "Empty the Trash on all mounted volumes and the main HDD..."
sudo rm -rfv "/Volumes/*/.Trashes/*" &> /dev/null
sudo rm -rfv "$HOME/.Trash/*" &> /dev/null

echo "Clear System Log Files..."
sudo rm -rfv "/private/var/log/asl/*.asl" &> /dev/null
sudo rm -rfv "/Library/Logs/DiagnosticReports/*" &> /dev/null
sudo rm -rfv "/Library/Logs/Adobe/*" &> /dev/null
rm -rfv "$HOME/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/*" &> /dev/null
rm -rfv "$HOME/Library/Logs/*" &> /dev/null

echo "Clear Adobe Cache Files..."
sudo rm -rfv "$HOME/Library/Application Support/Adobe/Common/Media Cache Files/*" &> /dev/null

echo "Cleanup iOS Applications..."
rm -rfv "$HOME/Music/iTunes/iTunes Media/Mobile Applications/*" &> /dev/null

echo "Remove iOS Device Backups..."
rm -rfv "$HOME/Library/Application Support/MobileSync/Backup/*" &> /dev/null

echo "Cleanup XCode Derived Data and Archives..."
rm -rfv "$HOME/Library/Developer/Xcode/DerivedData/*" &> /dev/null
rm -rfv "$HOME/Library/Developer/Xcode/Archives/*" &> /dev/null

if command -v brew > /dev/null; then
  echo "Cleanup Homebrew Cache..."
  brew cleanup &> /dev/null
  brew cleanup --prune -s &> /dev/null
  rm -rfv "$(brew --cache)" &> /dev/null
  brew tap --repair &> /dev/null
fi

if command -v docker > /dev/null; then
  echo "Cleanup Docker..."
  docker container prune -f
  docker image prune -f
  docker volume prune -f
  docker network prune -f
fi

if command -v gem > /dev/null; then
  echo "Cleanup gems..."
  gem cleanup
fi

for dir in "$HOME/.cache/pip" "$HOME/Library/Caches/pip" "$HOME/Library/Caches/pipenv"; do
  echo "Cleaning pip cache from $dir..."
  [ -d "$dir" ] && rm -rf "$dir"
done

if [ -n "$PYENV_VIRTUALENV_CACHE_PATH" ]; then
  echo "Removing Pyenv-VirtualEnv Cache..."
  rm -rfv "$PYENV_VIRTUALENV_CACHE_PATH" &> /dev/null
fi

if command -v npm > /dev/null; then
  echo "Cleanup npm cache..."
  npm cache clean --force
fi

if command -v yarnpkg &> /dev/null; then
  echo "Cleanup YarnPkg Cache..."
  yarnpkg cache clean --force
fi

declare -A CACHE_ALLOW_LIST=([antibody]=1)
for dir in "$HOME/Library/Caches" "/Library/Caches"; do
  echo "Cleanup files from $dir"
  if cd "$dir"; then
    while read -r file; do
      filename="$(basename "$file")"
      if [ "${CACHE_ALLOW_LIST[$filename]}0" != "0" ]; then
        echo "Skipping $(realpath "$dir"/"$file")..."
      else
        echo "Deleting $(realpath "$dir"/"$file")..."
        sudo rm -rf "$file"
      fi
    done < <(ls)
    cd - &> /dev/null || continue
  fi
done

echo "Purge inactive memory..."
sudo purge

echo "Success!"

new_available="$(df -k / | tail -1 | awk '{print $4}')"
if type "numfmt" &> /dev/null; then
  count="$((new_available - old_available))"
  [ $count -lt 0 ] && count="0"
  count="${count}K"
  echo "$(numfmt --from iec --to iec --suffix B $count) of space was cleaned up"
fi
