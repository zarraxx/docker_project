#!/bin/bash

apt-get update -y
apt-get upgrade -y
apt-get install -y build-essential
apt-get install -y libsybdb5 freetds-dev freetds-common
apt-get install -y postgresql-server-dev-9.5
apt-get install -y postgresql-9.5-python-multicorn
apt-get install -y python-pip python-dev

pip install python-tds
pip install bitarray

pip install PyMySQL

pip install pg8000



echo `pwd`
tar -xvzf /stage/v1.0.7.tar.gz
cd tds_fdw-1.0.7
make USE_PGXS=1
make USE_PGXS=1 install
cd -

cp /stage/locales.conf /etc/freetds
