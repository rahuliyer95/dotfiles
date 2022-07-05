# Chocolatey
Start-Process choco -Wait -Verb runAs "upgrade all -y"
# Python
if ((Get-Command pip 2>$null).Source) { 
  pip install --upgrade pip 
  pip list --format=legacy --outdated | sed 's/\ .*//g' | ForEach-Object { pip install --upgrade $_ }
}
# npm
if ((Get-Command npm 2>$null).Source) {
  npm i -g npm
  npm up -g
}
# Yarn
if ((Get-Command yarn 2>$null).Source) {
  yarn global upgrade
  yarn cache clean
}
# tldr
if ((Get-Command tldr 2>$null).Source) {
  tldr --update
}
