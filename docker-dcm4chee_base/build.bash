#!/bin/bash
set -v
image=dcm4chee_base
docker rmi $image || true
docker build --rm=true -t $image .
