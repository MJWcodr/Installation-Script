#!/bin/bash
# copies provided rclone.conf into directory
apt install rclone
mkdir /home/$(logname)/Onedrive
cd ./rclone
echo "$(pwd)"
echo "Do you know the password of rclone.conf.gpg? (y/n)"
read -r yesno
if [ "$yesno" = "y" ]; then
	echo "what's the passphrase?"
	read -s -r key
	# gpg --decrypt --batch --passphrase "$key" rclone.conf.gpg > rclone.conf
else 
	echo "do you have a rclone config? If so put it into the root of 'installation script' and enter 'yes' 
	alternatively you can create one for a onedrive by writing 'onedrive' (will be available in beta)
	There are no options to create anything for a CSP, sorry. Write 'no' "
	read -r yesonedriveno
	case $yesonedriveno in 
		"yes")
		mv -f "../rclone.conf" "./rclone.conf"
		;;
		"onedrive")
		echo "not available yet"
		;;
		*)
		exit
	esac
fi

if [ "$( cat rclone.conf)" = "" ]; then
	echo "provided rclone.conf is empty"
fi 

Directory=/home/$(logname)/.config/rclone/
if [ -d "$Directory" ]; then
    echo "/home/$(logname)/.config/rclone/ already exists."
    FILE1="/home/$(logname)/.config/rclone/rclone.conf"
    if [ -f "$FILE1" ]; then
    	 echo "/home/$(logname)/.config/rclone/rclone.conf already exists"
    	 echo "Do you want to update it? This action may lead to data loss if you already have rclone entries (y/n)"
    	read -r yesno
    	if [ "$yesno" = "y" ]; then
    		gpg --decrypt --batch --passphrase "$key" "rclone.conf.gpg" > rclone.conf
    		if [ "$(cat rclone.conf)" = "" ]; then
			echo "provided rclone.conf is empty"
			echo "this might be due to the provided password being wrong"
		fi 
    		mv -f "./rclone.conf" "/home/$(logname)/.config/rclone/rclone.conf"
    	fi
    else
	echo "error"
	mkdir /home/$(logname)/.config/rclone/
	gpg --decrypt --batch --passphrase "$key" "./rclone.conf.gpg" > rclone.conf 
    	mv -f "./rclone.conf" "/home/$(logname)/.config/rclone/rclone.conf"
    fi
else 
    echo "/home/$(logname)/.config/rclone/rclone.conf does not exist, yet"
    mkdir "/home/$(logname)/.config/rclone/"
    gpg --decrypt --batch --passphrase "$key" "./rclone.conf.gpg" > rclone.conf
    mv -f "./rclone.conf" "/home/$(logname)/.config/rclone/rclone.conf"
fi

# Systemd service
echo "Do you want to install the systemd service for onedrive? '(y/n)'"
read -r yesno
if [ "$yesno" = "y" ]; then
	./rclone/systemd/onedrive-setup.sh
fi
cd ../
echo "the rclone-setup script ended"

