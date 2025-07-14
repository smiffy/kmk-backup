#!/bin/bash

cd `dirname "$0"`
rm -f ./.snapshot.timestamp
./kmk-backup.sh

