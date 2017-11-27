#!/usr/bin/env bash
subnet=$1
port=5900
# ports=("5900" "5901")

# for port in $ports; do
mkdir /data/$port
zmap -p $port $subnet -o /data/$port/list.csv
screenshot.sh $port
# done
