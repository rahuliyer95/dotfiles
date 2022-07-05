foreach ($module in ("PSReadLine", "Pscx", "PSSudo")) {
    Import-Module $module
}

foreach ($file in ("path","aliases","extras","prompt")) {
    if (Test-Path "$env:USERPROFILE\.winrc.d\.$file.ps1") {
        . "$env:USERPROFILE\.winrc.d\.$file.ps1" > $null
    }
}

# vi key-bindings
Set-PSReadlineOption -EditMode vi

