# Packer Template for Bro

This repository contains a Packer template for building an Ubuntu 12.04 VM
with Bro installed.

## Usage

First, [install Packer](http://www.packer.io/intro/getting-started/setup.html).
Then, clone this repository and `cd` into it.

Run the following:

    $ make

Or more explicitly:

    $ ./src/clone_bro #to build a reusable .tgz of the current git repo
    $ packer build -only=lubuntu-vbox template-base.json
    $ packer build -only=brobuntu-vbox template-bro.json


At the end of that, you'll have an image for importing into virtualbox

    $ du -hs output/*/*
    623M    output/brobuntu-vbox-v2.2-none/brobuntu-v2.2-disk1.vmdk
     12K    output/brobuntu-vbox-v2.2-none/brobuntu-v2.2.ovf
    559M    output/lubuntu-vbox/lubuntu-disk1.vmdk
     12K    output/lubuntu-vbox/lubuntu.ovf

## Building additional VMs and specifying the Bro version

    $ make VER=HEAD
    $ make VER=v2.1
    $ #etc

## Filesets

To build a VM with filesets included, install zsync or wget as needed and run:

    $ make VER=HEAD FILESETS=standard

You will then have another VM in the output directory:

    $ du -hs output/brobuntu-vbox-HEAD-standard/brobuntu-HEAD-standard*
    638M    output/brobuntu-vbox-HEAD-standard/brobuntu-HEAD-standard-disk1.vmdk
     12K    output/brobuntu-vbox-HEAD-standard/brobuntu-HEAD-standard.ovf
