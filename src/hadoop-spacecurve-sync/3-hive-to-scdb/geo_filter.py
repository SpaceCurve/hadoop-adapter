#!/usr/bin/env python
#
# Copyright 2014 SpaceCurve Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
