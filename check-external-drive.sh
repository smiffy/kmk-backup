#!/bin/sh

export D=/media/pi/Extreme\ Pro
export NUM=`ls "$D"| wc -l`
if [ $NUM -lt 1 ]; then
    /usr/bin/echo "external drive '$D not found (NUM=$NUM), rebooting system ..." | /usr/bin/mail -s 'KMK backup error' kmk.admin@smiffy.de >> /tmp/log.txt
    sudo reboot now
    exit 1
else
    /usr/bin/echo "check successful - external drive '$D' available" 
    /usr/bin/echo "check successful - external drive '$D' available" | /usr/bin/mail -s 'KMK backup info' kmk.admin@smiffy.de >> /tmp/log.txt

    exit 0
fi
