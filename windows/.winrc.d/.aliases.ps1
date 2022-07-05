Set-Alias vim gvim
Set-Alias npp "C:\Program Files (x86)\Notepad++\notepad++.exe"
Set-Alias open explorer
function ..() {
  cd ..
}
function ...() {
  cd ..\\..    
}
function ....() {
  cd ..\\..\\..
}
function .....() {
  cd ..\\..\\..\\..    
}
function ip() {
  curl ip.appspot.com
}
function update() {
  iex "$env:USERPROFILE\.winrc.d\.update.ps1"
}
$env:PYTHONIOENCODING="utf-8"
Remove-Item alias:curl
Remove-Item alias:wget
