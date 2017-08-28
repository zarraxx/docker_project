#!/bin/bash

sysctl net.ipv4.ip_forward=1
modprobe ppp_mppe
pptpsetup --create pptpVPN --server $SERVER --username $USER--password $PWD --encrypt --start