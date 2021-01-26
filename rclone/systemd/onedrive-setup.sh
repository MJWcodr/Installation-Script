#!/bin/bash 
# Sets up the rclone automount service

# Copy script into systemd
cd ./systemd

FILE1=/usr/bin/onedrive-mount.sh
if test -f "$FILE1" ; then
	echo "$FILE1 already exists do you want to update it?"
	select option1 in Yes No
	do
	case $option1 in 
	"Yes")
		touch /usr/bin/onedrive-mount.sh
		rm /usr/bin/onedrive-mount.sh
		cp ./onedrive-mount.sh /usr/bin/onedrive-mount.sh
		break
	;;
	*)
		echo "You chose not to update the file"
		break
	;;
	esac
	done
else 
	cp ./onedrive-mount.sh /usr/bin/onedrive-mount.sh
fi

FILE2=/etc/systemd/system/onedrive-mount.service
if test -f "$FILE2"; then
	echo "$FILE2 already exists do you want to update it?"
	select option2 in Yes No
	do
	case $option2 in
	"Yes")
		touch /etc/systemd/system/onedrive-mount.service
		rm /etc/systemd/system/onedrive-mount.service
		cp ./onedrive-mount.service /etc/systemd/system/onedrive-mount.service
		break
	;;
	*)
		echo "You chose not to update the file"
		break
	;;
	esac
	done
else
	cp ./onedrive-mount.service /etc/systemd/system/onedrive-mount.service
fi

systemctl enable onedrive-mount
