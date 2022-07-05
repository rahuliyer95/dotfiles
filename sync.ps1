robocopy windows "$env:USERPROFILE" /E /XO
robocopy common "$env:USERPROFILE" /E /XO /XD .git

if ((Test-Path "$env:USERPROFILE\vimfiles") -eq $False) {
    cmd /c mklink /J "$env:USERPROFILE\vimfiles" "$env:USERPROFILE\.vim" 
}

if ((Test-Path "$env:USERPROFILE\.oh-my-posh") -eq $True) {
    Copy-Item .\packages\rahuliyer95.ps1 "$env:USERPROFILE\.oh-my-posh\themes" -Force
}
