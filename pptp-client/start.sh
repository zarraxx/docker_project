#!/bin/bash

#sysctl net.ipv4.ip_forward=1

pon ${TUNNEL} debug dump logfd 2 nodetach persist "$@"

#pptpsetup --create pptpVPN --server $SERVER --username $USER--password $PWD --encrypt --start