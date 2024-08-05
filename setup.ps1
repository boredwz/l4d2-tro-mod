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

Write-Host "#   Get Steam Libraries"
#   Get Steam Libraries
$steamLibs = gc "$steamPath\steamapps\libraryfolders.vdf"|?{$_ -match '"path"'}|%{
  ($_ -replace '^.*\"([^\"]+?)\"$','$1') -replace '\\\\','\'
}

Write-Host "#   Copy mod.vpk"
#   Copy mod.vpk
$steamLibs|%{
  if(test-path "$_\steamapps\common\Left 4 Dead 2") {
    copy "$env:USERPROFILE\Desktop\TPO EHEu IIpocuTb CaJIa (by wvzxn).vpk" -dest "$_\steamapps\common\Left 4 Dead 2\left4dead2\addons"
  }
}

#   End
echo "Done!"
Write-Host -NoNewline "Press any key to continue...";[void][System.Console]::ReadKey($true);Write-Host
exit
