#!/bin/sh
# Unix OS Sniffer and $adb setup by Firon
platform=`uname`;
ADB=$PWD"/Files/tools/adb";
FASTBOOT=$PWD"/Files/tools/fastboot";
cd "$(dirname "$0")"
if [ -z $(which adb) ]; then
	ADB=$PWD"/Files/tools/adb";
    FASTBOOT=$PWD"/Files/tools/fastboot";
	if [ "$platform" == 'Darwin' ]; then
		ADB=$PWD"/Files/tools/adb.osx"
		FASTBOOT=$PWD"/Files/tools/fastboot.osx"
	fi
fi
chmod +x $ADB
chmod +x $FASTBOOT
CLS='printf "\033c"'
# End section, thanks Firon!

f_ROOT () {
$CLS
sleep 3
echo "Pushing Recovery Script"
$ADB push Files/root/superuser.zip /sdcard/superuser.zip
$ADB push Files/root/command /cache/recovery/command
$ADB shell killall recovery
sleep 3
echo "Running automated recovery commands"
sleep 4
echo "Enjoy root :)"
echo "Press enter to continue"; read line
$ADB reboot
if [ -z $(which sudo 2>/dev/null) ]; then
	$ADB kill-server
else
	sudo $ADB kill-server
fi
exit 0
}

f_FLASH () {
$CLS
$ADB reboot bootloader
echo 
echo 
echo 
echo        Downloading $RECOVERY..
wget -q http://www.Shabbypenguin.com/Android/Scripts/Nexus-Files/Recoveries/$MYDEVICE/$RECOVERY/recovery.img -P $PWD/Files/Devices/$MYDEVICE/$RECOVERY/
sleep 5
$FASTBOOT flash recovery Files/Devices/$MYDEVICE/$RECOVERY/recovery.img
$CLS
echo 
echo 
echo " please use the volume down button and select recovery and press power"
echo 
echo 
echo "Press enter to continue"; read line
f_ROOT
}

f_DEVICEMENU () {
$CLS
unset choice
while :
do
case $choice in
1) RECOVERY=CWM && f_FLASH ;;
2) RECOVERY=CWMT && f_FLASH ;;
3) RECOVERY=TWRP && f_FLASH ;;
esac
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "         All in One Root and Recovery v8.1"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo 
echo 
echo "Menu:"
echo 
echo "1) Root and Install ClockworkMod"
echo "2) Root and Install ClockworkMod Touch"
echo "3) Root and Install TWRP"
echo 
echo 
echo 
echo 
read choice
done
}

f_UNLOCK () {
$ADB reboot bootloader
sleep 6
$CLS
echo "if your phone is not displayed or it stays on waiting for device for too long then there was an error with the drivers or its not in fastboot"
echo 
$FASTBOOT devices
echo 
echo "Please look at your phone"
echo 
echo 
echo "Using Volume up and down please choose the unlock option, hit power to make the selection"
echo 
echo 
$FASTBOOT oem unlock
echo 
echo "Press enter to continue"; read line
echo 
echo 
$FASTBOOT reboot
$CLS
$ADB "wait-for-device" devices
$CLS
echo 
echo 
echo 
echo 
echo 
echo 
echo 
echo 
echo "                   You need to enable usb debugging again"
echo 
echo "                 Go to settings - applications - development"
export PS1="\e[0;31m[\u@\h \W]\$ \e[m "
sleep 2
export PS1="\e[0;32m[\u@\h \W]\$ \e[m "
sleep 2
export PS1="\e[0;31m[\u@\h \W]\$ \e[m "
sleep 2
export PS1="\e[0;32m[\u@\h \W]\$ \e[m "
echo 
echo 
echo 
echo 
echo "Press enter to continue"; read line
f_PUSHFILES
}

f_WARNING () {
$CLS
unset choice
while :
do
echo 
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "Please Read Carefully"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo 
echo "  Warning"
echo "  Warning"
echo "  Warning"
echo "  Warning"
echo "  Warning"
echo "  Warning"
echo "   THIS WILL WIPE ALL OF YOUR APPS, CONTACTS GAMESAVES ETC EVERYTHING"
echo "                      INCLUDING YOUR SD CARD"
echo "  Warning"
echo "  Warning"
echo 
echo 
case $choice in
Y) f_UNLOCK ;;
y) f_UNLOCK ;;
N) exit 0 ;;
n) exit 0 ;;
*) echo "\"$choice\" is not valid"
sleep 2
esac
echo 
echo "Do you wish to continue?"
echo 
echo 
echo "Type Y/N"
echo 
read choice
done
}

f_BOOTMENU () {
unset choice
while :
do
echo 
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "Please Read Carefully"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo 
echo 
echo "Menu:"
echo 
echo "1) This is a stock locked phone"
echo "2) This phone has its bootloader unlocked but not root/recovery"
echo "3) Already got recovery? just need root?"
echo "4) Quit"
echo 
echo 
echo -n "Your choice? : "
read choice
echo 
echo 
case $choice in
1) f_WARNING ;;
2) f_DEVICEMENU ;;
3) $ADB reboot recovery && sleep 21 && f_ROOT ;;
4) exit 0 ;;
*) echo "\"$choice\" is not valid"
sleep 2 ;;
esac
done
}


$CLS
echo 
echo 
echo 
echo 
echo 
echo 
echo 
echo 
echo "                     One Click Root for the Nexus Devices"
echo 
echo "              		        By Shabbypenguin"
echo 
echo 
echo 
echo "Press enter to continue"; read line
$CLS
echo 
echo 
echo 
echo 
echo 
echo 
echo 
echo 
echo "                    You need to enable usb debugging first"
echo 
echo "                  Go to settings - applications - development"
echo 
echo 
echo 
echo 
echo "Press enter to continue"; read line
$CLS
cd $PWD
if [ -z $(which sudo 2>/dev/null) ]; then
	$ADB kill-server
else
	sudo $ADB kill-server
fi
if [ -z $(which sudo 2>/dev/null) ]; then
	$ADB start-server
else
	sudo $ADB start-server
fi
$CLS
MYDEVICE=`$ADB shell getprop ro.product.device`
rm -rf Files/Devices/*
echo 
echo 
echo 
echo 
echo 
echo 
echo 
echo 
echo "      		 	 Your device is: $MYDEVICE"
echo 
echo " 		 If this is incorrect please exit this program"
echo 
echo 
echo 
echo 
echo "Press enter to continue"; read line
$CLS
f_BOOTMENU
