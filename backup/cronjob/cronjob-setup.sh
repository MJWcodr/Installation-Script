#!/bin/bash
cd "./cronjob" || echo " \e[31mchanging directory into ./cronjob-setup failed"
# copy the backup-hourly.sh script into the proper directory

if [ -f "/etc/cron.hourly/lbackup-hourly" ]; then
	echo "lbackup-hourly  is already a cronjob"
	echo -e "\fdo you want to update it?"
	read -r yesno
	if [ $yesno = "yes" ]; then
		cp -f ./lbackup-hourly  /etc/cron.hourly/lbackup-hourly
	else
		/etc/cron.hourly/lbackup-hourly
	fi
else
	cp -f ./lbackup-hourly  /etc/cron.hourly/lbackup-hourly
fi

cd ..
