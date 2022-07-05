# Chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
refreshenv

# Install packages
foreach ($package in Get-Content .\packages\chocolatey.list) {
  choco install -y $package
}
refreshenv

# PSGet
(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
refreshenv
foreach ($module in Get-Content .\packages\psmodules.list) {
  install-module $module
}

# sync
.\sync.ps1

# VSCode extensions
foreach ($extension in Get-Content .\packages\vscode.extensions.list) {
  code --install-extension "$extension"
}

# Node
# npm
echo "prefix=$env:APPDATA\npm" > ~/.npmrc
foreach ($pkg in Get-Content .\packages\npm.list) {
  yarn global add "$pkg"
}

# aria2 webui
git clone 'https://github.com/ziahamza/webui-aria2' "$env:USERPROFILE\webui-aria2"

# Install services
.\install_services.ps1
