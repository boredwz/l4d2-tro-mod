#         Name: L4D2 TRO-MOD setup script
#       Author: wvzxn // https://github.com/wvzxn/
#  Description: Left 4 Dead 2 sound mod.
#               The script acts as both installer and updater.

#Requires -Version 5

#   Steam test
if (Test-Path "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam") {
  $steamPath = (gp "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam").installPath;
} else {
  if (Test-Path "${env:ProgramFiles(x86)}\Steam") {
    $steamPath = "${env:ProgramFiles(x86)}\Steam"
  } else {Write-Error "Steam path is not found"; return}
}

#   Get Steam Libraries
$steamLibs = gc "$steamPath\steamapps\libraryfolders.vdf"|?{$_ -match '"path"'}|%{
  ($_ -replace '^.*\"([^\"]+?)\"$','$1') -replace '\\\\','\'
}

#   Download mod.vpk
iwr -useb "https://gist.githubusercontent.com/wvzxn/e7872773f4c44671ca37fad7ca3912b7/raw/Get-GithubLatestRelease.ps1"|iex
$url = Get-GithubLatestRelease "wvzxn/l4d2-tro-mod"
$filename = Get-GithubLatestRelease "wvzxn/l4d2-tro-mod" -getname
$size = [int64]((iwr -Uri $url -Method Head).Headers.'Content-Length') / 1MB
Write-Host ("Downloading... [~{0:N0}MB]" -f $size)
Get-GithubLatestRelease "wvzxn/l4d2-tro-mod" -dl -out "$env:USERPROFILE\Desktop"

#   Copy mod.vpk
$steamLibs|%{
  if (Test-path "$_\steamapps\common\Left 4 Dead 2") {
    if (Test-Path "$_\steamapps\common\Left 4 Dead 2\left4dead2\addons\$filename") {
      del "$_\steamapps\common\Left 4 Dead 2\left4dead2\addons\$filename" -Force
    }
    copy "$env:USERPROFILE\Desktop\$filename" -dest "$_\steamapps\common\Left 4 Dead 2\left4dead2\addons"
    del "$env:USERPROFILE\Desktop\$filename"
    Write-Host "Done."
  } else {
    Write-Host "Error."
  }
}
return
