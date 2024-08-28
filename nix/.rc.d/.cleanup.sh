#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive sudo until `clenaup.sh` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2> /dev/null &

echo ""
echo "╭─────────────╮"
echo "│ 🗑️ Cleanup  │"
echo "╰─────────────╯"
echo ""

old_available="$(df -k / | tail -1 | awk '{print $4}')"

echo -en "ℹ️ Empty the Trash on all mounted volumes and the main HDD"
sudo rm -rfv "/Volumes/*/.Trashes/*" &> /dev/null
sudo rm -rfv "$HOME/.Trash/*" &> /dev/null
echo -en "\r✅ Empty the Trash on all mounted volumes and the main HDD\n"

echo -en "ℹ️ Clear System Log Files"
sudo rm -rfv "/private/var/log/asl/*.asl" &> /dev/null
sudo rm -rfv "/Library/Logs/DiagnosticReports/*" &> /dev/null
sudo rm -rfv "/Library/Logs/Adobe/*" &> /dev/null
rm -rfv "$HOME/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/*" &> /dev/null
rm -rfv "$HOME/Library/Logs/*" &> /dev/null
echo -en "\r✅ Clear System Log Files\n"

echo -en "ℹ️ Clear Adobe Cache Files"
sudo rm -rfv "$HOME/Library/Application Support/Adobe/Common/Media Cache Files/*" &> /dev/null
echo -en "\r✅ Clear Adobe Cache Files\n"

echo -en "ℹ️ Cleanup iOS Applications"
rm -rfv "$HOME/Music/iTunes/iTunes Media/Mobile Applications/*" &> /dev/null
echo -en "\r✅ Cleanup iOS Applications\n"

echo -en "ℹ️ Remove iOS Device Backups"
rm -rfv "$HOME/Library/Application Support/MobileSync/Backup/*" &> /dev/null
echo -en "\r✅ Remove iOS Device Backups\n"

echo -en "ℹ️ Cleanup XCode Derived Data and Archives"
rm -rfv "$HOME/Library/Developer/Xcode/DerivedData/*" &> /dev/null
rm -rfv "$HOME/Library/Developer/Xcode/Archives/*" &> /dev/null
echo -en "\r✅ Cleanup XCode Derived Data and Archives\n"

if command -v brew > /dev/null; then
  echo -en "ℹ️ Cleanup Homebrew Cache"
  brew cleanup &> /dev/null
  brew cleanup --prune -s &> /dev/null
  rm -rfv "$(brew --cache)" &> /dev/null
  brew tap --repair &> /dev/null
  echo -en "\r✅ Cleanup Homebrew Cache\n"
fi

if command -v apt-get > /dev/null; then
  echo -en "ℹ️ Cleanup apt Cache"
  sudo apt-get autoclean -y &> /dev/null
  sudo apt autoclean -y &> /dev/null
  echo -en "\r✅ Cleanup apt Cache\n"
fi

if command -v docker > /dev/null; then
  echo -en "ℹ️ Cleanup Docker"
  docker container prune -f &> /dev/null
  docker image prune -f &> /dev/null
  docker volume prune -f &> /dev/null
  docker network prune -f &> /dev/null
  echo -en "\r✅ Cleanup Docker\n"
fi

if command -v gem > /dev/null; then
  echo -en "ℹ️ Cleanup Ruby Gems"
  gem cleanup &> /dev/null
  echo -en "\r✅ Cleanup Ruby Gems\n"
fi

for dir in "$HOME/.cache/pip" "$HOME/Library/Caches/pip" "$HOME/Library/Caches/pipenv"; do
  echo -en "ℹ️ Cleaning pip cache from $dir"
  [ -d "$dir" ] && rm -rf "$dir" && echo -en "\r✅" || printf "\r❌"
  echo -en " Cleaning pip cache from $dir\n"
done

if [ -n "$PYENV_VIRTUALENV_CACHE_PATH" ]; then
  echo "Removing Pyenv-VirtualEnv Cache..."
  rm -rfv "$PYENV_VIRTUALENV_CACHE_PATH" &> /dev/null
fi

if command -v npm > /dev/null; then
  echo -en "ℹ️ Cleanup npm cache"
  npm cache clean --force &> /dev/null
  echo -en "\r✅ Cleanup npm cache\n"
fi

if command -v yarnpkg &> /dev/null; then
  echo -en "ℹ️ Cleanup YarnPkg cache"
  yarnpkg cache clean --force &> /dev/null
  echo -en "\r✅ Cleanup YarnPkg cache\n"
fi

declare -A CACHE_ALLOW_LIST=([antibody]=1)
for dir in "$HOME/Library/Caches" "/Library/Caches"; do
  if cd "$dir"; then
    while read -r file; do
      filename="$(basename "$file")"
      fullpath="$(sudo realpath "$dir/$filename" 2>/dev/null)"
      if [ -z "$fullpath" ]; then
        continue
      fi
      if [ "${CACHE_ALLOW_LIST[$filename]}0" != "0" ]; then
        echo -en "\r⏭️ Deleting $fullpath\n"
      else
        echo -en "ℹ️ $fullpath"
        if sudo rm -rf "$file" &>/dev/null; then
          echo -en "\r✅"
        else
          echo -en "\r❌"
        fi
        echo -en " Deleting $fullpath\n"
      fi
    done < <(ls)
    cd - &> /dev/null || continue
  else
    echo -en "\r❌ Cleanup files from $dir\n"
  fi
done

echo -en "ℹ️ Purge inactive memory"
sudo purge
echo -en "\r✅ Purge inactive memory\n"

new_available="$(df -k / | tail -1 | awk '{print $4}')"
if type "numfmt" &> /dev/null; then
  count="$((new_available - old_available))"
  [ $count -lt 0 ] && count="0"
  count="${count}K"
  echo "🚀 $(numfmt --from iec --to iec --suffix B $count) of space was cleaned up"
fi
