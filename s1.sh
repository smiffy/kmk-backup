#!/bin/bash
pwd
cd `dirname "$0"`
pwd
date '+%Y%m%d-%H%M' > .ts
echo s1
./s2.sh
