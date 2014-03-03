#!/bin/bash

# Set up sudo
echo %bro ALL=NOPASSWD:ALL > /etc/sudoers.d/bro
chmod 0440 /etc/sudoers.d/bro

# Setup sudo to allow no-password sudo for "sudo"
usermod -a -G sudo bro
