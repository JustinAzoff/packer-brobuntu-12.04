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

echo Add a terminal icon to the desktop
install -o $USERNAME -g $USERNAME -d /home/${USERNAME}/Desktop/
install -o $USERNAME -g $USERNAME /usr/share/applications/lxterminal.desktop /home/${USERNAME}/Desktop/
