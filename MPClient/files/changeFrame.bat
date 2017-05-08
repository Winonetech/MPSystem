@echo off
CLS
:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )
:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " " >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B
:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul & shift /1)
rem ********************************************************************
rem 本行以下可修改为你需要的bat命令（从上面三行冒号开始到下面都可删改）
rem ********************************************************************

set a=%1
taskkill /f /im JRShell.exe
ping 127.1 -n 3 >nul
echo %a%>temp.txt
if "%a%"=="" set a=%cd%
echo %a%>>temp.txt
del %a%\JRShell.exe
ping 127.1 -n 2 >nul
move %a%\update\JRShell.exe %a%\JRShell.exe
ping 127.1 -n 2 >nul

set a=%a%\MPClient.exe
set a=%a:\=\\%
echo %a%>>temp.txt
echo Windows Registry Editor Version 5.00>x.reg
echo [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\run]>>x.reg
echo "WOSPlayer"="%a%">>x.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run]>>x.reg
echo "WOSPlayer"="%a%">>x.reg
ping 127.1 -n 2 >nul
regedit /s x.reg
ping 127.1 -n 2 >nul
del x.reg

shutdown /r /t 0
