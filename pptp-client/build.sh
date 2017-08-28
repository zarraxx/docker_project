#!/bin/bash
set -v
image=pptp_client
docker rmi $image || true
docker build --rm=true -t $image .
