#!/bin/bash
# check for sudo rights
if [ $(whoami) != root ]; then
	echo -e "Please run as root, exiting"
	exit
fi
echo -e "installation start"
# define what text is bold
bold=$(tput bold)
normal=$(tput sgr0)

# update all repositories
apt -q update

echo -e "\fDo you want to run installprogs.sh to install some applications? (y/n)"
read -r yesno
if [ "$yesno" = "y" ]; then
./installprogs.sh
fi

echo -e "\fDo you want to run the rclone configuration script? (y/n)"
read -r yesno
if [ "$yesno" = "y" ]; then
./rclone/rclone.sh
fi

echo -e "\fDo you want to run the backup configuration script? (y/n)"
read -r yesno
if [ "$yesno" = "y" ]; then
./backup/backup.sh
fi

echo -e "\fDo you want to run the security script? (y/n)"
read -r yesno
if [ "$yesno" = "y" ]; then
	./security/security.sh
fi
echo -e "finished"
