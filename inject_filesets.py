#!/usr/bin/env python
import os
import json
import shutil
import sys
import subprocess


def modify_template(src, dst, filesets):
    data = json.load(open("filesets.json"))
    orig = json.load(open(src))

    #work out the file copies
    file_copies = []
    for fsn in filesets:
        fs = data[fsn]
        for fn in fs['files']:
            file_copies.append({
                "type": "file",
                "source": os.path.join("filesets", fs["dir"], fn),
                "destination": os.path.join("/home/bro/", fs["dir"], fn)
            })

    #collect dirnames
    new_dirs = set(os.path.dirname(f["destination"]) for f in file_copies)

    #create parent dirs
    for d in new_dirs:
        orig["provisioners"].append({
            "type": "shell",
            "inline": ["mkdir -p '%s'" % d]
        })

    orig["provisioners"].extend(file_copies)
    with open(dst, 'w') as f:
        json.dump(orig, f, indent=4)

if __name__ == "__main__":
    src = sys.argv[1]
    dst = sys.argv[2]
    filesets = sys.argv[3]
    if filesets and filesets != "none":
        modify_template(src, dst, filesets.split(","))
    else:
        shutil.copy(src, dst)
