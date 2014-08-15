#!/bin/sh
rm /var/lib/apt/lists/*
apt-get clean
apt-get update
