# set-executionpolicy bypass -scope process -force
$fldr = "$_SteamLibrary\steamapps\common\Left 4 Dead 2\left4dead2\addons\tro-mod.vpk"
$url = "https://github.com/wvzxn/l4d2-tro-mod/raw/main/tro-mod.vpk"
function Get-SteamLibrary {
  param ([string]$SteamPath,[string]$SteamLibrary)
  $e = 'Write-Output "Steam folder not found..." ; Start-Sleep -s 3 ; return 1'
  if ((Get-WmiObject win32_operatingsystem).osarchitecture -like "*64*") {$_steam_reg = (Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam").InstallPath} else {$_steam_reg = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Valve\Steam").InstallPath}
  if ($? -eq $false) {$e | Invoke-Expression}
  $a = Get-Content ("$_steam_reg\steamapps\libraryfolders.vdf") | Select-String "path"
  if ($a.Length -gt 1) {
    for ($j=1; $j -le ($a.length)-1; $j++) {
      $a[$j] -replace '\s','' | ForEach-Object {Set-Variable -Name b -Value (((($_.split(""""))[3])) -replace '\\\\','\')}
      if ($a.Length -eq 2) {Set-Variable -Name "$SteamLibrary" -Value $b -Scope script} else {Set-Variable -Name "$SteamLibrary$j" -Value $b -Scope script}
    }
  }
  Set-Variable -Name "$SteamPath" -Value ($_steam_reg) -Scope script
}
# --------------------------------------------------------------------------------------------------------
Get-SteamLibrary -SteamPath "_Steam" -SteamLibrary "_SteamLibrary"
if (!(Test-Path variable:_SteamLibrary)) {$_SteamLibrary = "$_Steam"}
[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
(New-Object System.Net.WebClient).DownloadFile("$url","$fldr")
Add-Type -AssemblyName PresentationCore,PresentationFramework
[System.Windows.MessageBox]::Show("Слава Україні!") > $null
exit