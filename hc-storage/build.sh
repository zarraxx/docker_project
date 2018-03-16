#!/bin/bash
set -v
image=hc-storage
docker rmi $image || true
docker build --rm=true -t $image .
