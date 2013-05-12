@echo off
@echo off
cls
color 0A
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                 One Click Root for the Nexus Devices
echo.
echo                           By Shabbypenguin
echo.
echo.
echo.
echo.
pause
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                   You need to enable usb debugging
echo              Go to settings - applications - development
echo.
echo                         Or in ICS and higher
echo            Settings - Developer Options - Android Debugging
color 0A
ping -n 2 127.0.0.1 > nul
color 0C
ping -n 2 127.0.0.1 > nul
color 0A
echo.
echo.
echo.
echo.
pause
cls
@rem *** Find WGET.EXE or abort *********************************************
set BatchFileDir=%~dp0
set WgetExe=%BatchFileDir%/Files/tools/wget.exe
if exist "%WgetExe%" goto FoundWgetExe
set WgetExe=%CD%\/Files/tools/wget.exe
if exist "%WgetExe%" goto FoundWgetExe
set WgetExe=
for %%f in ("WgetExe") do set WgetExe=%%~$PATH:f
if not "%WgetExe%" == "" FoundWgetExe
echo ERROR: Could not find "Wget.exe" (have you installed it?)
echo.
echo To find Wget.EXE this script:
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo (1) Looks in the same directory as the batch file ("%BatchFileDir%)
echo.
echo (2) Looks in the current directory (%CD%)
echo.
echo (3) Looks in the PATH, that is one of the following directories: %PATH%
echo.
pause
goto :EOF
:FoundWgetExe
echo.
echo.
echo.
echo.
echo.
echo.
echo USING WGET: "%WgetExe%"
@rem *** Find AD.EXE or abort *********************************************
set BatchFileDir=%~dp0
set AdbExe=%BatchFileDir%/Files/tools/adb.exe
if exist "%AdbExe%" goto FoundAdbExe
set AdbExe=%CD%\/Files/tools/adb.exe
if exist "%AdbExe%" goto FoundAdbExe
set AdbExe=
for %%f in ("AdbExe") do set AdbExe=%%~$PATH:f
if not "%AdbExe%" == "" FoundAdbExe
echo ERROR: Could not find "adb.exe" (have you installed it?)
echo.
echo To find ADB.EXE this script:
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo (1) Looks in the same directory as the batch file ("%BatchFileDir%)
echo.
echo (2) Looks in the current directory (%CD%)
echo.
echo (3) Looks in the PATH, that is one of the following directories: %PATH%
echo.
pause
goto :EOF
:FoundAdbExe
echo.
echo USING ADB: "%AdbExe%"
echo.
@rem *** Find Fastboot.EXE or abort *********************************************
set BatchFileDir=%~dp0
set Fastboot=%BatchFileDir%/Files/tools/fastboot.exe
if exist "%Fastboot%" goto FoundFastboot
set Fastboot=%CD%\/Files/tools/fastboot.exe
if exist "%Fastboot%" goto FoundFastboot
set Fastboot=
for %%f in ("Fastboot") do set Fastboot=%%~$PATH:f
if not "%Fastboot%" == "" FoundFastboot
echo ERROR: Could not find "Fastboot.EXE" (have you installed it?)
echo.
echo To find Fastboot.EXE this script:
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo (1) Looks in the same directory as the batch file ("%BatchFileDir%)
echo.
echo (2) Looks in the current directory (%CD%)
echo.
echo (3) Looks in the PATH, that is one of the following directories: %PATH%
echo.
pause
goto :EOF
:FoundFastboot
echo USING FASTBOOT: "%Fastboot%"
echo.
echo.
echo.
echo.
pause
cls
cd "%~dp0"
%AdbExe% kill-server 2>NUL
SET MYDEVICE=
SET RECOVERY=
%AdbExe% start-server 2>NUL
cls
del mydevicetmp 2>NUL
%AdbExe% shell getprop ro.product.device > mydevicetmp
set /p MYDEVICE= < mydevicetmp
del mydevicetmp 2>NUL
mkdir Files\Devices\%MYDEVICE%
rmdir /s /q Files\Devices\%MYDEVICE%
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                      Your device is: %MYDEVICE%
echo.
echo           If this is incorrect please exit this program
echo.
echo.
echo.
echo.
pause
cls
goto :BOOTMENU

:BOOTMENU
echo.
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Please Read Carefully
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.
echo Menu:
echo.
echo 1) This is a stock locked phone
echo 2) This phone has its bootloader unlocked but not root/recovery
echo 3) Already got recovery? just need root?
echo 4) Quit
echo.
echo.
set menu=""
set /p menu=Please type a number [1-4] and press enter 
echo.
echo.
if "%menu%"=="1" goto :WARNING
if "%menu%"=="2" goto :DEVICEMENU
if "%menu%"=="3" %AdbExe% reboot recovery && ping 127.0.0.1 -n 22 -w 1000 > nul && goto :ROOT
if "%menu%"=="4" goto :eof
goto :bootmenu

REM This is the part of the script that unlocks the bootloader and then forwards onto menu so users can pick their device

:WARNING
cls
echo.
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Please Read Carefully
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
ping -n 4 127.0.0.1 > nul
cls
color C0
echo   Warning
echo   Warning
echo   Warning
echo   Warning
echo   Warning
echo   Warning
echo    THIS WILL WIPE ALL OF YOUR APPS, CONTACTS GAMESAVES ETC EVERYTHING
echo                        INCLUDING YOUR SD CARD
echo   Warning
echo   Warning
ping -n 2 127.0.0.1 > nul
color 0C
ping -n 2 127.0.0.1 > nul
color C0
ping -n 2 127.0.0.1 > nul
color 0A
ping -n 2 127.0.0.1 > nul
color 0C
echo.
echo.
echo.
echo Do you wish to continue?
echo.
echo.
set menu=""
set /p menu=Please type Y/N and press enter 
echo.
echo.
cls
color 0A
if "%menu%"=="y" goto :UNLOCK
if "%menu%"=="Y" goto :UNLOCK
if "%menu%"=="N" goto :eof
if "%menu%"=="n" goto :eof
goto :WARNING

:UNLOCK
%AdbExe% reboot bootloader
@ping 127.0.0.1 -n 6 -w 1000 > nul
cls
echo if your phone is not displayed or it stays on waiting for device for too long then there was an error with the drivers or its not in fastboot
echo.
%Fastboot% devices
echo.
echo Please look at your phone
echo.
echo.
echo Using Volume up and down please choose the unlock option, hit power to make the selection
echo.
echo.
%Fastboot% oem unlock
echo.
pause
echo.
echo.
%Fastboot% reboot
cls
%AdbExe% wait-for-device devices
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                    You need to enable usb debugging again
echo.
echo                  Go to settings - applications - development
echo.
echo				 			 Or in ICS and higher
echo				Settings - Developer Options - Android Debugging
color 0A
ping -n 2 127.0.0.1 > nul
color 0C
ping -n 2 127.0.0.1 > nul
color 0A
echo.
echo.
echo.
echo.
pause
goto :DEVICEMENU

:DEVICEMENU
cls
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo          All in One Root and Recovery v8.1
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.
echo Menu:
echo.
echo 1) Root and Install ClockworkMod
echo 2) Root and Install ClockworkMod Touch
echo 3) Root and Install TWRP
echo 4) Quit
echo.
echo.
set menu=""
set /p menu=Please type a number [1-4] and press enter 
echo.
echo.
if "%menu%"=="1" set RECOVERY=CWM
if "%menu%"=="2" set RECOVERY=CWMT
if "%menu%"=="3" set RECOVERY=TWRP
if "%menu%"=="4" goto :eof
goto :FLASH

:FLASH
%AdbExe% reboot bootloader
cls
echo.
echo.
echo.
echo        Downloading %RECOVERY%..
%WgetExe% -q http://www.Shabbypenguin.com/Android/Scripts/Nexus-Files/Recoveries/%MYDEVICE%/%RECOVERY%/recovery.img -P %BatchFileDir%/Files/Devices/%MYDEVICE%/%RECOVERY%/
ping -n 2 127.0.0.1 > nul
%Fastboot% flash recovery Files/Devices/%MYDEVICE%/%RECOVERY%/recovery.img
cls
echo.
echo.
echo please use the volume down button and select recovery and press power
echo.
echo.
pause
goto :ROOT

REM Here is teh actual part of the script that does the rooting

:ROOT
cls
echo.
echo.
echo.
echo.
echo Pushing Recovery Script
echo.
@ping 127.0.0.1 -n 3 -w 1000 > nul
%AdbExe% push Files/root/superuser.zip /sdcard/superuser.zip
%AdbExe% push Files/root/command /cache/recovery/command
%AdbExe% shell killall recovery
echo.
echo Running automated recovery commands
echo.
@ping 127.0.0.1 -n 3 -w 1000 > nul
echo Choose yes and enjoy root :)
pause
%AbdExe% reboot
goto :EOF
