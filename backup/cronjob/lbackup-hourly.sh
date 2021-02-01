echo "
##!/bin/bash
systemd-run --scope -p CPUQuota=25% /etc/cron.hourly/lbackup-hourly.sh
systemd-run --scope -p MemoryMax=250M -p MemoryHigh=200M /etc/cron.hourly/lbackup-hourly.sh
restic -r "/srv/lbackups" --exclude-file "/srv/backup-exclude.txt" --password-file "/srv/backuppw.txt" backup --verbose \$(cat /srv/backup.txt)

case \$(rclone lsf onedrive:Personal/Backup) in
	*$(hostname)*)
		rclone sync /srv/lbackups onedrive:Personal/Backups/$(hostname)/
	;;
	*)
		rclone mkdir onedrive:Personal/Backups/$(hostname)/
		rclone sync /srv/lbackups onedrive:Personal/Backups/$(hostname)/
esac"
