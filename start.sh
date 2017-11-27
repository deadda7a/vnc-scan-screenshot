#!/usr/bin/env bash

docker build . -t scan:latest

for i in {1..255}; do
  ip=$i.0.0.0/8
  kubectl run --image=scan:latest $ip -v data:/data 
done
