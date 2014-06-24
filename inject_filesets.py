#!/usr/bin/env python
import os
import json
import shutil
import sys


def modify_template(src, dst, filesets_subset, filesets):
    data = json.load(open("filesets.json"))
    orig = json.load(open(src))

    #work out the file copies
    file_copies = []
    for fsn in filesets:
        fs = data[fsn]
        dest = fs["dest"]
        file_copies.append({
            "type": "file",
            "source": os.path.join("filesets",  dest),
            "destination": os.path.join("/home/bro/filesets", dest)
        })

    #collect dirnames
    new_dirs = set(os.path.dirname(f["destination"]) for f in file_copies)

    #create parent dirs
    for d in new_dirs:
        orig["provisioners"].append({
            "type": "shell",
            "inline": ["mkdir -p '%s'" % d]
        })

    with open(filesets_subset, 'w') as f:
        subset = dict((fs, data[fs]) for fs in filesets)
        json.dump(subset, f, indent=4)

    file_copies.append({
        "type": "file",
        "source": filesets_subset,
        "destination": os.path.join("/home/bro/filesets.json")
    })
    file_copies.append({
        "type": "file",
        "source": "get_filesets.py",
        "destination": os.path.join("/home/bro/get_filesets.py")
    })
    file_copies.append({
        "type": "file",
        "source": "update_files",
        "destination": os.path.join("/home/bro/update_files")
    })

    orig["provisioners"].extend(file_copies)

    orig["provisioners"].append({
        "type": "shell",
        "inline": ["cd /home/bro && chmod +x update_files get_filesets.py"]
    })
    orig["provisioners"].append({
        "type": "shell",
        "inline": ["sudo apt-get -y install zsync"]
    })
    orig["provisioners"].append({
        "type": "shell",
        "inline": ["cd /home/bro && ./update_files"]
    })

    with open(dst, 'w') as f:
        json.dump(orig, f, indent=4)

if __name__ == "__main__":
    src = sys.argv[1]
    dst = sys.argv[2]
    filesets_subset = sys.argv[3]
    filesets = sys.argv[4]
    if filesets and filesets != "none":
        modify_template(src, dst, filesets_subset, filesets.split(","))
    else:
        shutil.copy(src, dst)
