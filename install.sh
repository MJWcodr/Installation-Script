#!/bin/bash
if [ $(whoami) != root ]; then
	echo "Please run as root, exiting"
	exit
fi

apt -qq update

echo "installation start"
printf "\n Do you want to run installprogs.sh to install some applications? (y/n)"
read -r yesno
if [ "$yesno" = "y" ]; then
./installprogs.sh
fi

echo "\n Do you want to run the rclone configuration script? (y/n)"
read -r yesno
if [ "$yesno" = "y" ]; then
./rclone/rclone.sh
fi

printf "\n Do you want to run the backup configuration script? (y/n)"
read -r yesno
if [ "$yesno" = "y" ]; then
./backup/backup.sh
fi

printf "\n Do you want to run the security script? (y/n)"
read -r yesno
if [ "$yesno" = "y" ]; then
	./security/security.sh
fi
echo "finished"
