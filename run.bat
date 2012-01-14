@echo off
@echo off
echo kang'd drockstars menu for nexus s
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
echo                       The Android Creative Syndicate
echo.
echo                              Presents to you
ping -n 2 127.0.0.1 > nul
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo      One Click Root for the Nexus S/4G and Galaxy Nexus
echo.
echo                       By Shabbypenguin
echo.
echo.
echo.
echo.
pause
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
pause
echo.
echo.
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                    You need to enable usb debugging first
echo                  Go to settings - applications - development
color 0A
ping -n 2 127.0.0.1 > nul
color 0C
ping -n 2 127.0.0.1 > nul
color 0A
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
cls

@rem *** Find AD.EXE or abort *********************************************
set BatchFileDir=%~dp0
set AdbExe=%BatchFileDir%adb.exe
if exist "%AdbExe%" goto FoundAdbExe
set AdbExe=%CD%\adb.exe
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
echo USING ADB: "%AdbExe%"
echo.
echo.
@rem *** Find Fastboot.EXE or abort *********************************************
set BatchFileDir=%~dp0
set Fastboot=%BatchFileDir%fastboot.exe
if exist "%Fastboot%" goto FoundFastboot
set Fastboot=%CD%\fastboot.exe
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
echo USING Fastboot: "%Fastboot%"
echo.
echo.
pause
cls
cd "%~dp0"
adb.exe kill-server
echo.
echo.
echo.
echo.
echo.
echo Ensure you have usb debugging enabled on your phone
echo.
echo.
echo Go to settings - applications - development and check usb debugging
echo.
echo.
pause
echo.
adb.exe start-server
cls
goto :bootmenu

:bootmenu
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
if "%menu%"=="1" goto :Bootloader
if "%menu%"=="2" goto :menu
if "%menu%"=="3" goto :preroot
if "%menu%"=="4" goto :eof
goto :bootmenu

:menu
cls
echo.
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Please Choose Your Phone Model
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.
echo Menu:
echo.
echo 1) Nexus S (GSM)
echo 2) Nexus S 4G (CDMA)
echo 3) Galaxy Nexus (GSM)
REM echo 4) Galaxy Nexus (CDMA/LTE) 
echo 4) Quit
echo.
echo ONLY ONE MENU ITEM IS RUN AT A TIME
echo.
set menu=""
set /p menu=Please type a number [1-4] and press enter 
echo.
echo.
if "%menu%"=="1" goto :crespomenu
if "%menu%"=="2" goto :crespo4gmenu
if "%menu%"=="3" goto :GalMenu
REM if "%menu%"=="4" goto :GalLTEmenu
if "%menu%"=="4" goto :eof
goto :menu

REM This is teh part of the script that unlocks the bootloader and then forwards onto menu so users can pick their device

:Bootloader
adb.exe reboot bootloader
@ping 127.0.0.1 -n 6 -w 1000 > nul
cls
echo if your phone is not displayed or it stays on waiting for device for too long then there was an error with the drivers or its not in fastboot
echo.
fastboot.exe devices
echo.
echo Please look at your phone
echo.
echo.
echo Using Volume up and down please choose the unlock option, hit power to make the selection
echo.
echo.
fastboot.exe oem unlock
echo.
pause
echo.
echo.
fastboot.exe reboot
pause
cls
echo.
echo.
echo Please enable usb debugging again
echo.
echo Settings - Applications - Development 
echo.
echo.
echo when you have enabled usb debugging again please 
pause
@ping 127.0.0.1 -n 6 -w 1000 > nul
adb.exe reboot bootloader
@ping 127.0.0.1 -n 6 -w 1000 > nul
goto :menu

REM Here is the various recoveries for the different phones, most of the names can be figured out with common sense ;)

:NSCWM
fastboot.exe flash recovery Files/Crespo/recovery.img
echo.
echo.
echo please use the volume down button and select recovery and press power
echo.
echo.
pause
goto :root

:NS4GCWM
fastboot.exe flash recovery Files/Crespo4G/recovery.img
echo.
echo.
echo please use the volume down button and select recovery and press power
echo.
echo.
pause
goto :root

:GNLCWM
fastboot.exe flash recovery Files/GALLTE/recovery.img
echo.
echo.
echo please use the volume down button and select recovery and press power
echo.
echo.
pause
goto :root

:GNCWM
fastboot.exe flash recovery Files/GALGSM/recovery.img
echo.
echo.
echo please use the volume down button and select recovery and press power
echo.
echo.
pause
goto :root

:NSTWRP
fastboot.exe flash recovery Files/Crespo4G/recovery.img
echo.
echo.
echo please use the volume down button and select recovery and press power
echo.
echo.
pause
goto :root

:NS4GTWRP
fastboot.exe flash recovery Files/Crespo4G/TWRP/recovery.img
echo.
echo.
echo please use the volume down button and select recovery and press power
echo.
echo.
pause
goto :root

REM Here is teh actual part of the script that does the rooting

:preroot
cls
echo Rebooting...
adb.exe reboot recovery
adb.exe wait-for-device
:root

:root
cls
echo.
echo Pushing files over
@ping 127.0.0.1 -n 6 -w 1000 > nul
adb.exe push root.zip /sdcard/root.zip
echo.
echo.
echo.
echo.
echo.
echo.
echo  Select install zip from sd card
echo.
pause
cls
echo.
echo.
echo.
echo Select choose zip from sdcard
echo.
echo.
echo Scroll all the way down and select root.zip, choose yes
echo.
@ping 127.0.0.1 -n 10 -w 1000 > nul
pause
echo.
cls
echo.
echo Congrats you are rooted!
echo.
echo.
echo.
pause
adb.exe reboot
echo.
echo
echo all your base are belong to us
adb.exe kill-server
GOTO:EOF



REM Here are teh different phone menus trying to keep them seperate :)

:crespomenu
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Nexus S All in One Root and Recovery v5.0
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.
echo Menu:
echo.
echo 1) Root and Install ClockworkMod 5.0.2.0
echo 2) Root and Install TWRP 1.1.1
echo 3) Quit
echo.
echo.
set menu=""
set /p menu=Please type a number [1-3] and press enter 
echo.
echo.
if "%menu%"=="1" goto :NSCWM
if "%menu%"=="2" goto :NSTWRP
if "%menu%"=="3" goto :eof
goto :crespomenu

:crespo4gmenu
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Nexus S 4G All in One Root and Recovery v5.0
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.
echo Menu:
echo.
echo 1) Root and Install ClockworkMod 5.0.2.0
echo 2) Root and Install TWRP 1.1.1
echo 3) Quit
echo.
echo.
set menu=""
set /p menu=Please type a number [1-3] and press enter 
echo.
echo.
if "%menu%"=="1" goto :NS4GCWM
if "%menu%"=="2" goto :NS4GTWRP
if "%menu%"=="3" goto :eof
goto :crespo4gmenu

:Galmenu
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Galaxy Nexus (GSM) All in One Root and Recovery v5.0
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.
echo Menu:
echo.
echo 1) Root and Install ClockworkMod 5.5.0.2
echo 2) Quit
echo.
echo.
set menu=""
set /p menu=Please type a number [1-2] and press enter 
echo.
echo.
if "%menu%"=="1" goto :GNCWM
if "%menu%"=="2" goto :eof
goto :Galmenu

:GalLTEmenu
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Galaxy Nexus (CDMA/LTE) All in One Root and Recovery v5.0
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.
echo Menu:
echo.
echo 1) Root and Install ClockworkMod 5.5.0.2
echo 2) Quit
echo.
echo.
set menu=""
set /p menu=Please type a number [1-2] and press enter 
echo.
echo.
if "%menu%"=="1" goto :GNLCWM
if "%menu%"=="3" goto :eof
goto :GalLTEmenu
