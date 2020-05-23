#!/usr/bin/env python

import json

filename = "now.json"

with open(filename) as f:
    fdata = json.load(f)
    print(fdata)
