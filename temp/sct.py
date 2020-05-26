#!/usr/bin/env python3
import sys
import json
from os import path

fname = sys.path[0] + "/now.json"
fsize = path.getsize(fname)
usr_in = " ".join(sys.argv[1:])

usr_dic = {
    "president": {"name": "Zaphod Beeblebrox", "species": "Betelgeusian"}
}

try:
    with open(fname, "a+") as f:
        if fsize != 0:
            fdata = json.load(f)
            print(fdata)
        else:
            json.dump(usr_dic, f)
except FileNotFoundError:
    print(f"{fname} doesn't exist.")
