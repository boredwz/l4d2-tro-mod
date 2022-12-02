#         Name: L4D2 TRO-MOD v1.0
#       Author: wvzxn // https://github.com/wvzxn/
#  Description: Left 4 Dead 2 sound mod.
#               The script acts as both installer and updater.

function get-steamLibs {
  $i = (gp "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam").installPath
  return gc "$i\steamapps\libraryfolders.vdf"|?{$_ -match '"path"'}|%{$_ -replace '(.*"path".*")(.*)(".*)','$2'}|%{$_ -replace '\\\\','\'}
}

get-steamLibs|%{if(test-path "$_\steamapps\common\Left 4 Dead 2"){$l4d2="$_\steamapps\common\Left 4 Dead 2"}}
iwr "https://github.com/wvzxn/l4d2-tro-mod/releases/latest/download/tro-mod.vpk" -outFile "$l4d2\left4dead2\addons\tro-mod.vpk"
echo "Done!"
Write-Host -NoNewline "Press any key to continue...";[void][System.Console]::ReadKey($true);Write-Host
exit