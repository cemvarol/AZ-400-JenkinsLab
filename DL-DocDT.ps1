Set-NetFirewallProfile -Enabled False

Set-Service W32Time -StartupType Automatic
w32tm /config /syncfromflags:manual /manualpeerlist:"time.windows.com"
w32tm /config /reliable:yes
net start w32time

Set-TimeZone "GMT Standard Time"



$url = "https://github.com/cemvarol/AZ-Migration/blob/master/ChromeSetup.exe?raw=true"
$output = "$env:USERPROFILE\downloads\ChromeSetup.exe"
Invoke-WebRequest -Uri $url -OutFile $output

& "$env:USERPROFILE\downloads\ChromeSetup.exe"

Start-Sleep -s 40

#& "C:\Program Files\google\chrome\Application\chrome.exe" https://download.docker.com/win/stable/Docker%20Desktop%20Installer.exe

& "C:\Program Files\google\chrome\Application\chrome.exe" https://download.docker.com/win/stable/43884/Docker%20Desktop%20Installer.exe



Start-Sleep -s 70

& "$env:USERPROFILE\downloads\Docker Desktop Installer.exe"
