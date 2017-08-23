#!/bin/bash
set -v
image=tomcat_dev
docker rmi $image || true
docker build --rm=true -t $image .
