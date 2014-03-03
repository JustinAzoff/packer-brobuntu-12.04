#!/bin/bash

TREEISH=$1

export DEBIAN_FRONTEND=noninteractive

function die {
    echo $*
    exit 1
}

function pre_setup {
    apt-get update > /dev/null
    #apt-get dist-upgrade -y
}

function install_prereqs {
    apt-get -y install build-essential git
    apt-get -y install bison flex cmake swig
    apt-get -y install libssl-dev libgeoip-dev libmagic-dev libpcap-dev python-dev libcurl4-openssl-dev
}

function install_bro {
    if [ -e /usr/local/bro/bin/bro ] ; then
        echo "bro already installed"
        return
    fi
    cd /usr/src/
    git clone --recursive git://git.bro.org/bro
    cd bro
    git checkout $TREEISH || die "checkout failed"
    git submodule update --recursive --init
    #overkill?
    git reset --hard
    git submodule foreach --recursive git reset --hard
    git checkout .
    git submodule foreach --recursive git checkout .

    ./configure || die "configure failed"
    make || die "build failed"
    sudo make install || die "install failed"
}

function configure_bro {
    if [ ! -e /bro ]; then
        ln -s /usr/local/bro /bro
    fi
    if [ ! -e /bro/site ]; then
        (cd /bro ; ln -s share/bro/site . )
    fi
    
}

pre_setup
install_prereqs
install_bro
configure_bro

exit 0
