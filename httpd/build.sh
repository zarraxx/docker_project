#!/bin/bash
set -v
image=httpd
docker rmi $image || true
docker build --rm=true -t $image .
