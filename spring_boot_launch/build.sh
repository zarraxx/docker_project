#!/bin/bash
set -v
image=spring_boot_launch
docker rmi $image || true
docker build --rm=true -t $image .
