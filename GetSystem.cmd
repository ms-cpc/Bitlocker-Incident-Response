@echo off
:: ######################################################
:: VERSION 1.0.131009 - October 09 2013
:: SCRIPT: Privilege Escalation Tool(PET)
:: CREATION DATE: 2012-05-14
:: LAST MODIFIED: 2013-10-09
:: AUTHOR: Cst. Mark SOUTHBY
:: EMAIL: mark@southby.ca
:: ######################################################
:: #### Authored by Cst. SOUTHBY, for personal use. Not sanctioned or approved by any organization or entity. Use at your own risk.
:: ---------------------------------------------- 
:: #### For Law enforcement use only. Can be used and modified without permission for Law Enforcement purposes.
:: START OF BATCH
title PET
echo Privilege Escalation Tool
echo.
echo.
echo Please select method of escalation attempt
choice /C 12 /m "[1] PSexec [2] UAC Stack Overflow"
If "%errorlevel%"=="1" (goto psexec)
If "%errorlevel%"=="2" (goto stackoverflow)
:stackoverflow
    >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
    if '%errorlevel%' NEQ '0' (
        echo Get ADMIN Privileges
        echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
        echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
        "%temp%\getadmin.vbs"
        del "%temp%\getadmin.vbs"
        exit /B
    ) else (
        echo Got ADMIN Privileges
        pushd "%cd%"
        cd /d "%~dp0"
        @echo on
    )
	start cmd
goto exit

:psexec
!!psexec -i -s -d cmd /noeula
color 0c
echo ===================================
echo     If the above error says 
echo       "Access is denied."
echo               or
echo  '!!psexec' is not recognized as an internal or external command,
echo. 
echo. 
echo  This is because this tool needs to be run from an 
echo  Administrator privledged command prompt.
echo.
echo  To run command prompt as an Administrator
echo  in Windows 7, press the windows key, type
echo  "cmd" and then press control-shift-enter.
echo.
echo.
echo.
echo  In Windows XP sp3 hold down shift-right click 
echo  selcect run-as and uncheck Protect my computer.... or run
echo  as administrator if you know the password.
echo.
goto exit

:exit
color