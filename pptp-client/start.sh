#!/bin/bash

sysctl net.ipv4.ip_forward=1

#pptpsetup --create pptpVPN --server $SERVER --username $USER--password $PWD --encrypt --start