#!/usr/bin/env bash
pathToScan=$1

cd $pathToScan
split -d -l 1000 list.csv --additional-suffix=.scan
rm -f list.csv

for file in $pathToScan/*.scan; do
  while read server; do
    filename=$(passwd-sha512 $server | tr -dc '[:alnum:]\n\r')
    vncsnapshot $server $filename.jpg > $pathToScan/screenshot.log 2>&1 &
  done <$file
  sleep 30
  killall vncsnapshot
done
