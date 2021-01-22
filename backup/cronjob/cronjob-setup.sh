#!/bin/bash
cd "./backup/cronjob" || echo " \e[31mchanging directory into ./backup/cronjob failed"
# copy the backup-hourly.sh script into the proper directory
if [ -f "/usr/sbin/lbackup-hourly.sh" ]; then
	echo "/usr/sbin/lbackup-hourly.sh already exists"
	echo "do you want to updatre it? (y/n)"
	read -r yesno
	if [ "$yesno" = "y" ]; then
		cp ./lbackup-hourly /usr/sbin/lbackup-hourly.sh
	fi
else
	cp ./lbackup-hourly.sh /usr/sbin/lbackup-hourly.sh
fi

# adds the cronjob to crontab if it doesn't already exist
crontab -l > current-cron
echo "0 * * * * /usr/sbin/lbackup-hourly.sh" >> current-cron
if grep "0 * * * * /usr/sbin/lbackup-hourly.sh" "current-cron"; then
	echo "crontab already runs lbackup-hourly.sh."
	rm current-cron
	else
	cron current-cron
fi
cd .. || echo "failed to change directory" && exit
echo "end chronjob creation"
