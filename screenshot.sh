#!/usr/bin/env bash
salt=$1
pathToScan="/tmp/5900"

# make sha512 tool
gcc -lcrypt -o /tmp/passwd-sha512 ./passwd-sha512.c
chmod +x /tmp/passwd-sha512

# Install vncdotool
apt-get install -y vncsnapshot

cd $pathToScan
split -d -l 1000 list.csv
rm -f list.csv

for file in $pathToScan/*; do
  while read server; do
    filename=$(/tmp/passwd-sha512 $server --salt $salt | tr -dc '[:alnum:]\n\r')
    vncsnapshot $servercapture $filename.jpg &
  done <$file
  sleep 180
  killall vncsnapshot
done
