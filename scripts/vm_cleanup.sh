#!/bin/bash

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
rm /var/lib/dhcp/*

# Make sure Udev doesn't block our network
echo "cleaning up udev rules"
rm  -r /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

if ! grep -q 'pre-up sleep' /etc/network/interfaces; then
    echo "Adding a 2 sec delay to the interface up, to make the dhclient happy"
    echo "pre-up sleep 2" >> /etc/network/interfaces
fi

#Clean package stuff
apt-get clean
rm /var/lib/apt/lists/*
rm /var/cache/lsc_packages.db

#remove packages that aren't needed anymore
apt-get autoremove -y

# Zero out the free space to save space in the final image:
echo "Zeroing device to make space..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
#give this a few seconds to settle
sleep 2
sync
sleep 2

echo "Delete extra directories in HOME"
rmdir ~bro/* || true
