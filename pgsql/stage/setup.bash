#!/bin/bash

echo hello


apt-get update -y
apt-get upgrade -y
apt-get install -y build-essential
apt-get install -y libsybdb5 freetds-dev freetds-common
apt-get install -y  postgresql-server-dev-9.5

echo `pwd`
tar -xvzf /stage/v1.0.7.tar.gz
cd tds_fdw-1.0.7
make USE_PGXS=1
make USE_PGXS=1 install
cd -
