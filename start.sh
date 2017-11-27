#!/usr/bin/env bash
docker build . -t scan:latest

for i in {1..255}; do
  subnet=$i.0.0.0/8
  docker run -d --image=scan:latest $subnet -v data:/data --name $subnet
done
