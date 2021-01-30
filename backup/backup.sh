#!/bin/bash
printf "\n Start of backup.sh"
cd ./backup || exit
# Install restic
	printf "\n Do you want to install the programs required? (y/n)"
	read -r yesno
	if [ "$yesno" = "y" ]; then
		apt update
		apt install restic rclone -y
	fi
# create password file
	if [ -f "/srv/backuppw.txt" ]; then
	echo "backuppw.txt already exists"
	else 
		z=0
		while [ $z = 0 ];
			do
			echo "create a password for the repository"
			echo "What should the password be?"
			read -s -r secret
			echo "Enter the password again"
			read -s -r secret1
			if [ "$secret1" = "$secret" ]; then
				z="1"
			else
				echo "The Passwords don't match"
			fi
			done
			echo "$secret1" > /srv/backuppw.txt
			chmod 700 /srv/backuppw.txt
			secret1=''
			secret=''
	fi
# local backup

	echo "setting up local backup at /srv/lbackups"
	if [ -d /srv/lbackups ]; then
		echo "/srv/lbackups already exists"
	else
		restic init --repo /srv/lbackups --password-file "/srv/backuppw.txt"
	fi
	

## Copying config files
	
	./backup > ./backup.txt
	./backup-exclude > backup-exclude.txt
	mv -f "./backup.txt" "/srv/backup.txt"
	mv -f "./backup-exclude.txt" "/srv/backup-exclude.txt"

## start the backup

	printf "starting backup"
	restic -r "/srv/lbackups" --exclude-file "/srv/backup-exclude.txt" --password-file "/srv/backuppw.txt" backup --verbose "backup.txt" 
	
# remote backup to onedrive

# cronjob for backing up files
echo "do you want to regularly backup your files? (y/n)"
read -r yesno
if [ $yesno = "y" ]; then
	./cronjob/cronjob-setup.sh
fi

cd ../
printf "\n End of backup.sh"
