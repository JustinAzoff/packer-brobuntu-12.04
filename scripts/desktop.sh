#!/bin/bash -e

export DEBIAN_FRONTEND=noninteractive
apt-get -y install lubuntu-desktop --no-install-recommends 
apt-get -y install evince
#remove update notifier
apt-get -y remove update-notifier

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

echo Make sure exercises are linked to the desktop
install -o $USERNAME -g $USERNAME -d /home/${USERNAME}/exercises
su $USERNAME -c "ln -s /home/${USERNAME}/exercises/ /home/${USERNAME}/Desktop/exercises"
