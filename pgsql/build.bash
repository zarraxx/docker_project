#!/bin/bash
set -v
image=pgsql
docker rmi $image || true
docker build --rm=true -t $image .
