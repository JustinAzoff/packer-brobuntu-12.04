#!/usr/bin/env python
import os
import sys
import json
import subprocess
from optparse import OptionParser

def unpack(fs):
    fn = fs["dest"]
    path = os.path.expanduser(fs["path"])
    if not os.path.isdir(path):
        os.makedirs(path)
    subprocess.check_call(["tar", "xvf", fn,  "-C", path])

def zsync(fs):
    url = fs["url"]
    subprocess.check_call(["zsync", url])

def wget(fs):
    url = fs["url"]
    subprocess.check_call(["wget", "-N", url])

def local(fs):
    url = fs["url"]
    dest = fs["dest"]
    if os.path.exists(dest):
        os.unlink(dest)
    os.symlink(url, dest)

DOWNLOADERS = {
    'zsync': zsync,
    'http': wget,
    'local': local,
}

def get_fileset(fs):
    if 'url' not in fs:
        return
    method = fs["method"]
    downloader = DOWNLOADERS[method]
    downloader(fs)

def get_filesets(filesets, do_unpack):
    data = json.load(open("filesets.json"))
    if "all" in filesets:
        filesets = data.keys()
    if not os.path.exists("filesets"):
        os.mkdir("filesets")
    os.chdir("filesets")
    for fs in filesets:
        if fs in data:
            get_fileset(data[fs])
            if do_unpack:
                unpack(data[fs])

def expand(l):
    o = []
    for item in l:
        o.extend(item.split(","))
    return o

if __name__ == "__main__":
    parser = OptionParser()
    parser.add_option("-u", "--unpack", dest="unpack", help="Unpack filesets", action="store_true")
    (options, args) = parser.parse_args()
    filesets = "all"
    if args:
        filesets = args

    filesets = expand(filesets)

    if filesets and filesets != "none":
        get_filesets(filesets, do_unpack=options.unpack)
