$ErrorActionPreference = 'Stop'

$programs = [Environment]::GetFolderPath('CommonPrograms')
$shortcut = Join-Path $programs 'ViralMint.lnk'
if (Test-Path $shortcut) { Remove-Item $shortcut -Force }
