@echo off
echo Windows batch scripts by DRockstar and Firon
echo.
echo Original credits: joeykrim, noobnl, skeeterslint, koush, and firon
echo for their original exploit, root, recovery, busybox, and kung fu
echo kang'd drockstars menu for nexus s
cls
echo.
echo.
echo.
echo   One Click Root for the Nexus S and Nexus S 4g
echo.
echo                 By Shabbypenguin
echo.
echo.
pause
cls
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
pause
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
echo Ensure you have usb debugging enabled on your phone
echo.
echo Go to settings - applications - development and check usb debugging
echo.
pause
echo.
adb.exe start-server
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


:menu
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
echo 3) Quit
echo.
echo ONLY ONE MENU ITEM IS RUN AT A TIME
echo.
set menu=""
set /p menu=Please type a number [1-3] and press enter 
echo.
echo.
if "%menu%"=="1" goto :crespomenu
if "%menu%"=="2" goto :crespo4gmenu
if "%menu%"=="3" goto :eof
goto :menu

:root
fastboot.exe flash recovery Files/Crespo/recovery.img
echo.
echo.
echo please use the volume down button and select recovery and press power
echo.
echo.
pause
goto :root

:CWM4g
fastboot.exe flash recovery Files/Crespo4G/recovery.img
echo.
echo.
echo please use the volume down button and select recovery and press power
echo.
echo.
pause
goto :root

:root
cls
echo.
echo Using volume up/down and the power button to select choose Mounts and storage.
echo.
echo Then select the top choice which should be mount /sdcard, once you have mounted the sd card
echo.
echo.
pause
cls
echo.
echo.
echo.
echo.
echo Pushing files over
@ping 127.0.0.1 -n 6 -w 1000 > nul
adb.exe push root.zip /sdcard/root.zip
echo.
echo.
echo.
echo.
echo Select go back (the bottom most option) or hit the back arrow softkey
echo.
echo.
echo Then select option 5 from the top, (install zip from sd card)
echo.
pause
cls
echo.
echo.
echo.
echo Select the 2nd option from this sub menu, choose zip from sdcard
echo.
echo.
echo Scroll all the way down and select root.zip, choose yes
echo.
pause
echo.
adb.exe reboot
cls
echo.
echo Congrats you are rooted!
echo.
echo Press the power button to reboot the phone
echo.
echo.
pause
echo.
echo
echo all your base are belong to us
adb.exe kill-server
GOTO:EOF

:TWRP
fastboot.exe flash recovery Files/Crespo4G/recovery.img
echo.
echo.
echo please use the volume down button and select recovery and press power
echo.
echo.
pause
goto :root

:TWRP4g
fastboot.exe flash recovery Files/Crespo4G/TWRP/recovery.img
echo.
echo.
echo please use the volume down button and select recovery and press power
echo.
echo.
pause
goto :root

:crespomenu
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Nexus S All in One Root and Recovery v3.0
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.
echo Menu:
echo.
echo 1) Root and Install ClockworkMod 5.0.2.0
echo 2) Root and Install TWRP 1.1.1
echo 3) Quit
echo.
echo ONLY ONE MENU ITEM IS RUN AT A TIME
echo PLEASE READ GUIDE.HTML INSIDE FOLDER
echo.
set menu=""
set /p menu=Please type a number [1-3] and press enter 
echo.
echo.
if "%menu%"=="1" goto :CWM
if "%menu%"=="2" goto :TWRP
if "%menu%"=="3" goto :eof
goto :crespomenu

:crespo4gmenu
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo Nexus S 4G All in One Root and Recovery v3.0
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.
echo Menu:
echo.
echo 1) Root and Install ClockworkMod 5.0.2.0
echo 2) Root and Install TWRP 1.1.1
echo 3) Quit
echo.
echo ONLY ONE MENU ITEM IS RUN AT A TIME
echo PLEASE READ GUIDE.HTML INSIDE FOLDER
echo.
set menu=""
set /p menu=Please type a number [1-3] and press enter 
echo.
echo.
if "%menu%"=="1" goto :CWM4g
if "%menu%"=="2" goto :TWRP4g
if "%menu%"=="3" goto :eof
goto :crespo4gmenu

:Missingsu
cls
echo.
echo.
echo Root.zip is missing, please try downloading again.
pause


