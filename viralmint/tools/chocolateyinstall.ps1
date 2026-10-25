$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  url64bit       = 'https://github.com/openclaw-easy/ViralMint/releases/download/v1.3.1/ViralMint-1.3.1-win.zip'
  checksum64     = '2E5D0D09F1B82C204309E0E8846957F1280C3A7BF6A5DB061A23CDCF6E957524'
  checksumType64 = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

$appDir = Join-Path $toolsDir 'ViralMint'
$exe = Join-Path $appDir 'ViralMint.exe'

# Shim only the launcher; it is a GUI app, so the shim must not wait for it.
Get-ChildItem $appDir -Include '*.exe' -Recurse | Where-Object { $_.FullName -ne $exe } | ForEach-Object {
  New-Item "$($_.FullName).ignore" -Type File -Force | Out-Null
}
New-Item "$exe.gui" -Type File -Force | Out-Null

$programs = [Environment]::GetFolderPath('CommonPrograms')
Install-ChocolateyShortcut -ShortcutFilePath (Join-Path $programs 'ViralMint.lnk') -TargetPath $exe -WorkingDirectory $appDir
