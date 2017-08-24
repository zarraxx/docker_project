#!/bin/bash

if [ ! -n "$GIT_URL" ]; then
  echo "GIT_URL not set"
else
  echo "Clone from $GIT_URL"
  PREV=`pwd`
  mkdir -p /tmp/git
  rm -rf /tmp/git
  mkdir -p /tmp/git
  cd /tmp/git
  git clone $GIT_URL CONF
  cd  CONF$CONF_DIR
  sh run.sh
  cd $PREV
fi


exec "$@"
