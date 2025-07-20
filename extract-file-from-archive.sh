#!/bin/bash

set -e
export TARGET_DIR="${3:-extract}"
mkdir -p $TARGET_DIR

if [[ $# -lt 2 ]]
  then
    echo "usage: $0 <archive> <file> <directory-to-extract>|[$TARGET_DIR]"
    exit 1;
fi

if [[ ! -f "$1" ]]
then
    echo "Archive '$1' does not exist"
    exit 1
fi

echo
echo "Archive: '$1'"
echo "File: '$2'"
echo "Target directory: '$TARGET_DIR'"
# echo "tar -xvzf \"$1\" -C \"$TARGET_DIR\" \"$2\""
echo
tar -xvzf "$1" -C "$TARGET_DIR" "$2"
