#!/bin/bash

mkdir -p /opt/tmp
cd /opt/tmp
git clone https://i.mhwsjsw.gov.cn/gogs/zarra/storage-service.git
cd storage-service

mvn clean package  -Dmaven.test.skip=true

mkdir -p /opt/storage

cp storage-frontend/target/storage-frontend-0.0.1-SNAPSHOT.war  /opt/storage/storage-frontend.war
