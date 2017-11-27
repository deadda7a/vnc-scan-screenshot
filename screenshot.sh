#!/usr/bin/env bash
salt=$1
pathToScan="/tmp/5900"

# make sha512 tool
gcc -o /tmp/passwd-sha512 ./passwd-sha512.c -lcrypt
chmod +x /tmp/passwd-sha512

# Install vncdotool
apt-get install -y vncsnapshot

cd $pathToScan
split -d -l 1000 list.csv
rm -f list.csv

for file in $pathToScan/*; do
  while read server; do
    filename=$(/tmp/passwd-sha512 $server --salt $salt | tr -dc '[:alnum:]\n\r')
    vncsnapshot $server $filename.jpg &
  done <$file
  sleep 180
  killall vncsnapshot
done
