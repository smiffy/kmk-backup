#!/bin/bash

/usr/bin/echo "sync directory '$1'"
/usr/bin/nextcloudcmd --non-interactive -n "$1" https://cloud.ionos-kanuclub-maxau.de

