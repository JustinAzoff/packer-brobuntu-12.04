#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo "Upgrading"
apt-get update
apt-get -y dist-upgrade
