#!/bin/bash

TREEISH=$1

if [ "$TREEISH" == "" ]; then
    TREEISH="HEAD"
fi

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
    apt-get -y install build-essential git zsync
    apt-get -y install bison flex cmake swig gawk
    apt-get -y install libssl-dev libgeoip-dev libmagic-dev libpcap-dev python-dev libcurl4-openssl-dev
    apt-get -y install geoip-database-contrib
}

function install_bro {
    if [ -e /usr/local/bro/bin/bro ] ; then
        echo "bro already installed"
        return
    fi
    cd /usr/src/
    if [ -e /tmp/bro.tgz ]; then
        tar xzf /tmp/bro.tgz
        rm /tmp/bro.tgz
    else
        git clone --recursive git://git.bro.org/bro
    fi
    cd bro
    git fetch origin $TREEISH
    git pull
    git checkout $TREEISH || die "checkout failed"
    git submodule update --recursive --init
    #overkill?
    git reset --hard
    git submodule foreach --recursive git reset --hard
    git checkout .
    git submodule foreach --recursive git checkout .

    ./configure || die "configure failed"
    make -j2 || die "build failed"
    sudo make install || die "install failed"
    make clean
    #change ownership to bro user
    chown -R bro: /usr/src/bro
}

function configure_bro {
    if [ ! -e /bro ]; then
        ln -s /usr/local/bro /bro
    fi
    if [ ! -e /bro/site ]; then
        (cd /bro ; ln -s share/bro/site . )
    fi
    echo 'export PATH=$PATH:/bro/bin' > /etc/profile.d/bro.sh

    ln -s /home/bro/exercises /exercises
}

pre_setup
install_prereqs
install_bro
configure_bro

exit 0
