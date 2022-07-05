$Branch="$([char]0xe0a0)"
$Check="$([char]0x2714)"
$Cross="$([char]0x2717)"
$Separator="$([char]0xe0b0)"

function global:prompt {
  $realCommandStatus = $?
  $realLASTEXITCODE = $LASTEXITCODE
  $OutputEncoding = [System.Text.Encoding]::UTF8

  if ( $realCommandStatus -eq $True ) {
    $ExitColor="DarkGreen"
    $ExitStatus="$Check"
  } else {
    $ExitColor="DarkRed"
    $ExitStatus="$Cross"
  }

  $Path = $pwd.ProviderPath
  $Username = [Environment]::UserName
  $PcName = [Environment]::MachineName

  Write-Host "`n" -NoNewLine
  Write-Host " $Username@$PcName " -NoNewLine -ForegroundColor "Black" -BackgroundColor "Yellow"
  Write-Host "$Separator" -NoNewLine -ForegroundColor "Yellow" -BackgroundColor "Blue"
  Write-Host " $Path " -NoNewLine -ForegroundColor "Black" -BackgroundColor "Blue"
  Write-Git
  Write-Host "`n" -NoNewLine
  # Write-Host " $Arrow " -NoNewLine -ForegroundColor "Black" -BackgroundColor "$ExitColor"
  # Write-Host "$Separator" -NoNewLine -ForegroundColor $ExitColor -BackgroundColor "Black"
  Write-Host " $ExitStatus " -NoNewLine -ForegroundColor "Black" -BackgroundColor $ExitColor
  Write-Host "$Separator" -NoNewLine -ForegroundColor $ExitColor -BackgroundColor "Black"

  $global:LASTEXITCODE = $realLASTEXITCODE  
  return " "
}

function Write-Git {
  $s = ""
  $branchName = ""
  $retValue = git rev-parse --is-inside-work-tree
  if ( $retValue -eq $True ) {
    $retValue = git rev-parse --is-inside-git-dir
    if ( $retValue -eq $False ) {
      git update-index --really-refresh -q > $null
      
			$deleted = 0
			$modified = 0
			$added = 0

      git status | foreach {
        if ($_ -match "deleted:") {
            $deleted += 1
        }
        elseif (($_ -match "modified:") -or ($_ -match "renamed:")) {
            $modified += 1
        }
        elseif ($_ -match "new file:") {
            $added += 1
        }
			}
			$s += "$added+ $modified~ $deleted-"
      # Untracked files
      $retValue = git ls-files --others --exclude-standard
      if ( $retValue ) {
        $s += " ?"
      }
      
      # Stashed files
      git rev-parse --verify refs/stash > $null
      if ( $? -eq $True ) {
        $s += " $"
      }
    }   
    $branchName = git symbolic-ref --quiet --short HEAD
    if ( -not $branchName ) {
      $branchName =  git rev-parse --short HEAD
    }
    if ( -not $branchName ) {
      $branchName = "unknown"
    }
    
    Write-Host "$Separator" -NoNewLine -ForegroundColor "Blue" -BackgroundColor "Magenta"
    Write-Host " $Branch $branchName $([char]0x2261) " -NoNewLine -ForegroundColor "Black" -BackgroundColor "Magenta"
    if ($s) {
      Write-Host "$s " -NoNewLine -ForegroundColor "Black" -BackgroundColor "Magenta"
    }
    Write-Host "$Separator" -NoNewLine -ForegroundColor "Magenta" -BackgroundColor "Black"
  } else {
    Write-Host "$Separator" -NoNewLine -ForegroundColor "Blue" -BackgroundColor "Black"
  }
}
