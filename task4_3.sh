#!/bin/bash

if [ "$#" -ne 2 ]; then
 echo "error of argument numbers" 1>&2
 exit 1
fi
BAKDIR=$1
BAKNUM=$2
if [ ! -d "$BAKDIR" ]; then 
 echo "document does not exist. suffer, please." 1>&2
 exit 2
fi
if ! [ "$BAKNUM" -eq "$BAKNUM" ] 2>/dev/null; then
 echo "insert a number, please" 1>&2
 exit 3
fi
if (( "$BAKNUM" < 1 )); then 
 echo "NNOOOOOOOOOO!!!" 1>&2
 exit 4
fi
if [ ! -d /tmp/backups ]; then
 mkdir -p /tmp/backups
fi
PREF="tar.gz"