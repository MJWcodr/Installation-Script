#!/bin/bash
cd "./cronjob" || echo " \e[31mchanging directory into ./cronjob failed"
# copy the backup-hourly.sh script into the proper directory

if [ -f "/etc/cron.hourly/lbackup-hourly.sh" ]; then
	echo "lbackup-hourly.sh is already a cronjob"
	echo "do you want to update it?"
	read -r yesno
	if [ $yesno = "yes" ]; then
		cp -f ./lbackup-hourly.sh /etc/cron.hourly/lbackup-hourly.sh
	else	
		/etc/cron.hourly/lbackup-hourly.sh
	fi
else
	cp -f ./lbackup-hourly.sh /etc/cron.hourly/lbackup-hourly.sh
fi
	
cd ..
