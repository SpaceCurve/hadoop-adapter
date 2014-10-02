#!/usr/bin/env python

import json
import sys

def mk_geojson(line):
    name,geojson,count = line.strip().split(chr(1))
    return json.dumps({
            "geometry" : json.loads(geojson),
            "properties" : {
                "county" : name,
                "cnt" : count
            },
            "type" : "Feature"
        })


for line in sys.stdin:
    print mk_geojson(line)
