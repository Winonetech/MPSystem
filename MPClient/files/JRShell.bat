set a=%1
tasklist|find /i "JRShellInner.exe" ||goto :startjr
exit
:startjr
if "%a%"=="" set a=%cd%
start %a%\JRShellInner.exe %a%
exit
