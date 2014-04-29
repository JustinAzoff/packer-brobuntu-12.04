#!/usr/bin/env python
import os
import sys
import json
import subprocess

def get_fileset(fs):
    if not os.path.exists(fs["dir"]):
        subprocess.check_call(["git", "clone", fs["repo"], fs["dir"]])
    os.chdir(fs["dir"])
    subprocess.check_call(["git", "pull"])
    subprocess.check_call(["git", "annex", "merge"])

    subprocess.check_call(["git", "annex", "get"] + fs["files"])


def get_filesets(filesets):
    data = json.load(open("filesets.json"))
    if not os.path.exists("filesets"):
        os.mkdir("filesets")
    os.chdir("filesets")
    for fs in filesets:
        if fs in data:
            get_fileset(data[fs])

if __name__ == "__main__":
    filesets = sys.argv[1]
    if filesets and filesets != "none":
        get_filesets(filesets.split(","))
