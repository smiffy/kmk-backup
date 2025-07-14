# kmk-backup

## crontab settings:
````
30 4 * * * cd /home/pi/backup && ./kmk-backup.sh
20 4 * * * cd /home/pi/backup && ./check-external-drive.sh
# every sunday at 4am delete .snapshot file to force a new full backup
0 4 * * 0 rm -f /home/pi/backup/.snapshot.timestamp
````

## look for a backuped file:

grep <searchstring> "$BACKUP_DIR/index/*.txt
