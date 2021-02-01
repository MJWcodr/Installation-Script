#!/bin/bash
cd "./cronjob" || echo " \e[31mchanging directory into ./cronjob-setup failed"
# copy the backup-hourly.sh script into the proper directory

if [ -f "/etc/cron.hourly/lbackup-hourly" ]; then
	echo "lbackup-hourly  is already a cronjob"
	echo -e "\fdo you want to update it?"
	read -r yesno
	if [ $yesno = "yes" ]; then
		./lbackup-hourly.sh > lbackup-hourly
		chmod -x lbackup-hourly
		mv  -f ./lbackup-hourly  /etc/cron.hourly/lbackup-hourly
	else
		./lbackup-hourly.sh > lbackup-hourly
		chmod -x lbackup-hourly
		mv  -f ./lbackup-hourly  /etc/cron.hourly/lbackup-hourly
	fi
else
	./lbackup-hourly.sh > lbackup-hourly
	chmod -x lbackup-hourly
	mv  -f ./lbackup-hourly  /etc/cron.hourly/lbackup-hourly
fi

cd ..
