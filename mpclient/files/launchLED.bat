
set a=%1
tasklist|find /i "LedSendNew.exe" ||goto :start
exit
:start
if "%a%"=="" set a=LedSendNew.exe
start %a%
@echo %cd%
pause
exit
