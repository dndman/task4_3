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
PREF=`echo ${BAKDIR:1}|sed 's/\//-/g'`

if [ -f "/tmp/backups/${PREF}.tar.gz" ]; then
  mv "/tmp/backups/${PREF}.tar.gz" "/tmp/backups/${PREF}.0.tar.gz"
fi



#COUNT=`ls -1 /tmp/backups |grep "$PREF"| wc -l`
SURVIVER=`ls -1 /tmp/backups |grep "$PREF"| sort | head -n$((BAKNUM-1))`
#DEADS=`ls -1 /tmp/backups |grep "$PREF"| sort | tail -n$((COUNT - BAKNUM + 1))`


for FILE in `ls -1 /tmp/backups |grep "$PREF"`; do
  if ! [[ $SURVIVER = *"$FILE"* ]]; then
  rm -f "/tmp/backups/$FILE"
  fi
done


if (( "$BAKNUM" > 1 )); then 

 for N in $(seq $((BAKNUM-1)) -1 1); do
   if [ -f "/tmp/backups/${PREF}.$((N-1)).tar.gz" ]; then
   mv "/tmp/backups/${PREF}.$((N-1)).tar.gz" "/tmp/backups/${PREF}.${N}.tar.gz"
   fi
 done
fi

tar -cf "/tmp/backups/${PREF}.tar.gz" "${BAKDIR}" 2>/dev/null

