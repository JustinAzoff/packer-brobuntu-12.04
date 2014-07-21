#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo "Upgrading"
apt-get update
apt-get -y dist-upgrade

#installing virtual kernel
echo "removing all kernels"
apt-get -y remove --purge linux-image.*

echo "installing kernel"
apt-get -y install linux-image
