# Packer Template for Bro

This repository contains a Packer template for building an Ubuntu 12.04
with Bro installed inside of it.

## Usage

First, [install Packer](http://www.packer.io/intro/getting-started/setup.html).
Then, clone this repository and `cd` into it.

Run the following:

    $ packer build template.json

At the end of that, you'll have an image for importing into virtualbox

$ du -hs output-virtualbox-iso/*

    597M    output-virtualbox-iso/brobuntu-disk1.vmdk
     12K    output-virtualbox-iso/brobuntu.ovf
