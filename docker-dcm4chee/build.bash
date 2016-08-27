#!/bin/bash
set -v
image=dcm4chee
docker rmi $image || true
docker build --rm=true -t $image .
