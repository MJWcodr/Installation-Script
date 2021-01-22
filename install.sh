#!/bin/bash
echo "installation start"
printf "\n Do you want to run install.sh to install some applications? (y/n)"
read -r yesno
if [ "$yesno" = "y" ]; then
./installprogs.sh
fi

echo "\n Do you want to run the rclone configuration script? (y/n)"
read -r yesno2
if [ "$yesno2" = "y" ]; then
./rclone/rclone.sh
fi

printf "\n Do you want to run the backup configuration script? (y/n)"
read -r yesno2
if [ "$yesno2" = "y" ]; then
./backup/backup.sh
fi
echo "finished"
