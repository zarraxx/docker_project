#!/bin/bash

apt-get update -y
apt-get upgrade -y
apt-get install -y vim build-essential
apt-get install -y unixodbc-dev libmyodbc  odbc-postgresql
apt-get install -y libsybdb5 tdsodbc  freetds-bin freetds-dev freetds-common
apt-get install -y postgresql-server-dev-9.5
apt-get install -y postgresql-plpython-9.5 postgresql-plpython3-9.5 postgresql-9.5-python3-multicorn
apt-get install -y python3-pip python3-dev python-pip python-dev

pip3 install pymssql
pip3 install python-tds
pip3 install bitarray

pip3 install PyMySQL

pip3 install pg8000


pip install pymssql
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
rm -rf tds_fdw-1.0.7

tar xzvf /stage/odbc_fdw.0.1.0-rc1.tar.gz 
cd odbc_fdw-0.1.0-rc1
make
make install 

cd -
rm -rf odbc_fdw-0.1.0-rc1

cp /stage/locales.conf /etc/freetds
cp /stage/odbcinst.ini  /etc
