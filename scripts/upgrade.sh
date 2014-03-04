#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo "Upgrading"
apt-get -y dist-upgrade

if dpkg -l | grep linux-image-3 | grep -qv $(uname -r); then
    echo "removing current (now obsolete) kernel"
    cur=$(uname -r)
    just_version=${cur/-generic/}
    apt-get -y remove --purge linux-.*${just_version}.*
fi
