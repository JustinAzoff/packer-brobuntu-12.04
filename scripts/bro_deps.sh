#!/bin/bash

echo "installing bro dependencies"
apt-get update
apt-get -y install build-essential git zsync
apt-get -y install bison flex cmake swig
apt-get -y install libssl-dev libgeoip-dev libmagic-dev libpcap-dev python-dev libcurl4-openssl-dev
