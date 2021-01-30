if [ -d  /home/matthias/Onedrive ]; then
	rclone mount --allow-other --vfs-cache-mode onedrive: /home/matthias/Onedrive
else
	mkdir /home/matthias/Onedrive
	rclone mount --allow-other --vfs-cache-mode full onedrive: /home/matthias/Onedrive
fi
