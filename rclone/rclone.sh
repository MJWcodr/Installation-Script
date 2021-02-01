#!/bin/bash
# copies provided rclone.conf into directory
cd ./rclone
apt install rclone

# create required Directories
## create /home/User_name/.config/rclone

if  [ -d /home/$(logname)/.config ]; then
	if [ -d /home/$(logname)/.config/rclone ]; then
		echo "the required directories already exist"
	else
		mkdir /home/$(logname)/.config/rclone
	fi
else
	mkdir /home/$(logname)/.config
	mkdir /home/$(logname)/.config/rclone
fi

#
echo -e "\fDo you know the password of rclone.conf.gpg? (y/n)"
read -r yesno
if [ "$yesno" = "y" ]; then
	echo -e "\fwhat's the passphrase?"
	read -s -r key
	# gpg --decrypt --batch --passphrase "$key" rclone.conf.gpg > rclone.conf
else
	echo -e "\fdo you have a rclone config? If so put it into the root of 'installation script' and enter 'yes'
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

echo -e "/home/$(logname)/.config/rclone/ already exists."
FILE1="/home/$(logname)/.config/rclone/rclone.conf"
if [ -f "$FILE1" ]; then
	echo -e "/home/$(logname)/.config/rclone/rclone.conf already exists"
	echo -e "\fDo you want to update it? This action may lead to data loss if you already have rclone entries (y/n)"
	read -r yesno
    	if [ "$yesno" = "y" ]; then
    		gpg --decrypt --batch --passphrase "$key" "rclone.conf.gpg" > rclone.conf
    		if [ "$(cat rclone.conf)" = "" ]; then
			echo -e "provided rclone.conf is empty"
			echo -e "this might be due to the provided password being wrong"
		fi
    		mv -f "./rclone.conf" "/home/$(logname)/.config/rclone/rclone.conf"
    	fi
else
	echo -e "rclone.conf does not exitst, yet"
	gpg --decrypt --batch --passphrase "$key" "./rclone.conf.gpg" > rclone.conf
    	mv -f "./rclone.conf" "/home/$(logname)/.config/rclone/rclone.conf"
fi
key=0


# Systemd service
echo -e "\fDo you want to install the systemd service for onedrive? '(y/n)'"
read -r yesno
if [ "$yesno" = "y" ]; then
	./systemd/onedrive-setup.sh
fi
cd ../
echo "the rclone-setup script ended"
