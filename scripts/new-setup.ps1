

if (-not (Test-Path -Path ../bin/gource.exe)) {
    Write-Host "missing executable, downloading"
    Invoke-WebRequest -Uri https://github.com/acaudwell/Gource/releases/download/gource-0.53/gource-0.53.win64.zip -OutFile ./gource.zip
    Write-Host "Download complete, unzipping files"
    Expand-Archive -Path ./gource.zip -DestinationPath ../bin/
    Write-Host "Files unzipped. Removing downloaded archive."
    Remove-Item -Path ./gource.zip
}

../bin/gource.exe -H

