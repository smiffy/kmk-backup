#!/bin/bash

set -e

cd `dirname "$0"`
if [ -f ./.snapshot.timestamp ]; then
    export MODE=incr;
else
    export MODE=full;
fi

export NC_DIR="/media/pi/Extreme Pro/kmk.nextcloud"
export BACKUP_DIR="/media/pi/Extreme Pro/backup"
export BACKUP_FILE="$BACKUP_DIR/${MODE}-`date '+%Y%m%d-%H%M'`.tar.gz"
export INDEX_FILE=${BACKUP_FILE/backup/backup/index}

/usr/bin/echo "$0 started at `date`" >> ./log/backup.log
./sync-nextcloud.sh "$NC_DIR" # >> ./log/backup.log
/usr/bin/tar --no-check-device --listed-incremental=./.snapshot.timestamp -cvzf "$BACKUP_FILE" "$NC_DIR" >> ./log/backup.log

echo "writing index data from $BACKUP_FILE to $INDEX_FILE"
/usr/bin/echo "content of file $BACKUP_FILE:" > "$INDEX_FILE"
/usr/bin/ls -t "$BACKUP_DIR/"*.tar.gz | head -1 | xargs -I@ tar -tvf "@" >> "$INDEX_FILE.txt" 
ls -l "$INDEX_FILE.txt"


rm -f /tmp/log.txt
if [ "$MODE" != "incr" ]; then
    /usr/bin/echo "name/size of tar file";
    /usr/bin/ls  "$BACKUP_DIR"/* -t|/usr/bin/head -n1| /usr/bin/xargs -I@ ls -lh "@" > /tmp/log.txt;
else
    /usr/bin/echo "content of incremental tar file `ls  "$BACKUP_DIR"/* -t|head -n1`";
    /usr/bin/ls  "$BACKUP_DIR"/* -t|/usr/bin/head -n1| /usr/bin/xargs -I@ /usr/bin/tar -tf "@" >> /tmp/log.txt;
    /usr/bin/echo "#files modified: `/usr/bin/ls  "$BACKUP_DIR"/$MODE* -t|/usr/bin/head -n1| /usr/bin/xargs -I@ /usr/bin/tar -tf "@"| grep -v '/$'| wc -l`" >> /tmp/log.txt;
fi
echo "diskusage:" >> /tmp/log.txt
/usr/bin/df | /usr/bin/grep -E '(root|sda1)' >> /tmp/log.txt

export cut_file=$(ls "$BACKUP_DIR"/full-* -t | tail +4| head -n1)
if [ "$cut_file" ] ; then
    echo "old backup files to delete:" >> /tmp/log.txt
    /usr/bin/find "$BACKUP_DIR" ! -newer "$cut_file" -print | tee -a /tmp/log.txt
    /usr/bin/find "$BACKUP_DIR" ! -newer "$cut_file" -exec rm {} \;
    /usr/bin/find "$BACKUP_DIR/index" ! -newer "$cut_file" -exec rm {} \;
fi
grep -v '/$' /tmp/log.txt | /usr/bin/mail -s 'KMK backup' kmk.admin@smiffy.de >> /tmp/log.txt
/usr/bin/echo "$0 terminated at `date`" >> ./log/backup.log
