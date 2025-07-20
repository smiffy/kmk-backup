#!/bin/sh

set -e

if [ $# -lt 1 ]
  then
    echo "usage: $0 <searchstring>"
    exit 1;
fi

export BACKUP_DIR="/media/pi/Extreme Pro/backup"


grep -v -E '/$' "$BACKUP_DIR/index/"* | grep "$1" --colour
