#!/bin/sh
ls *.tar.gz | xargs -I@ sh -c "tar ztvf @ > index/@.txt"
