#!/bin/bash

if [ ! -n "$WAR_URL" ]; then
  echo "WAR_URL not set"
else
  echo "Downloading from $WAR_URL"
  PREV=`pwd`
  mkdir -p /var/ext/war
  rm -rf /var/ext/war
  mkdir -p /var/ext/war
  cd /var/ext/war
  wget $WAR_URL
  cd $PREV
fi


exec "$@"
