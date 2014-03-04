#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt-get -y install lubuntu-desktop --no-install-recommends

USERNAME=bro
LIGHTDM_CONFIG=/etc/lightdm/lightdm.conf

# Configure lightdm autologin.

if [ -f $LIGHTDM_CONFIG ]; then
    echo "autologin-user=${USERNAME}" >> $LIGHTDM_CONFIG
    echo "autologin-user-timeout=0" >> $LIGHTDM_CONFIG
fi
