#!/bin/bash
cd "./cronjob" || echo " \e[31mchanging directory into ./cronjob failed"
# copy the backup-hourly.sh script into the proper directory

if [ -f "/etc/cron.hourly/lbackup-hourly.sh" ]; then
	echo "lbackup-hourly.sh is already a cronjob"
	echo "do you want to update it?"
	read -r yesno
	if [ $yesno = "yes" ]; then
    	./lbackup-hourly.sh > lbackup-hourly
			chmod -x lbackup-hourly
		  cp -f ./lbackup-hourly /etc/cron.hourly/lbackup-hourly
	else
		echo -e "end of cronjob-setup.sh"
	fi
else
	./lbackup-hourly.sh > lbackup-hourly
	chmod -x lbackup-hourly
	cp -f ./lbackup-hourly /etc/cron.hourly/lbackup-hourly
fi
cd ..
