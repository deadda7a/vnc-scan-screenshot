#!/usr/bin/env bash
ports=("5900" "5901")

for port in $ports; do
  mkdir /tmp/$port
  zmap -p $port -o /tmp/5900/list.csv
  screenshot.sh $port
done
