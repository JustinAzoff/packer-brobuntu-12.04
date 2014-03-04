# Packer Template for Bro

This repository contains a Packer template for building an Ubuntu 12.04 VM
with Bro installed.

## Usage

First, [install Packer](http://www.packer.io/intro/getting-started/setup.html).
Then, clone this repository and `cd` into it.

Run the following:

    $ packer build -only=lubuntu-vbox template-base.json
    $ packer build -only=brobuntu-vbox template-bro.json

At the end of that, you'll have an image for importing into virtualbox

    $ du -hs output-*/*
    623M    output-brobuntu-vbox/brobuntu-disk1.vmdk
     12K    output-brobuntu-vbox/brobuntu.ovf
    559M    output-lubuntu-vbox/lubuntu-disk1.vmdk
     12K    output-lubuntu-vbox/lubuntu.ovf
