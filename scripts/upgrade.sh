#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

#installing virtual kernel
echo "removing all kernels"
apt-get -y remove --purge linux-image.*

echo "installing linux-virtual kernel"
apt-get -y install linux-virtual

echo "Upgrading"
apt-get -y dist-upgrade
