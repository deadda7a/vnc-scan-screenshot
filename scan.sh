#!/usr/bin/env bash
# zmap build dependencies
apt-get -y install build-essential cmake libgmp3-dev gengetopt libpcap-dev flex byacc libjson-c-dev pkg-config libunistring-dev git

# Clone, compile and install zmap
git clone https://github.com/zmap/zmap.git /tmp/zmap
cd /tmp/zmap
cmake .
make -j4
make install

zmap -p 5900 -N 1000 -f "response,saddr" -o /tmp/5900/list.csv
