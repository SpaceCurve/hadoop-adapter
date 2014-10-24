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

import dgg 
import hashlib
import sys
import json
import os
import urllib2

__doc__ = """

Generates control files for syncing data to HDFS

{ "query" : "http://sc:8080/ArcGIS/schema/earthquakes...", "output" : "/user/hduser/output/{job}/`hash-query`.json" }

Each control file is used as the input for a map task that execute the query against SpaceCurve and writes the output to HDFS

"""

def gen_control(sql,uq,job):
    return {
        "sql": sql,
        "url_query": uq,
        "headers": [ "Accept: application/noheader+json" ],
        "output" : os.path.join("/user/hduser/output", job, hashlib.sha1(uq).hexdigest() + ".json")
    }


def main(job,resolution='4h0'):
    if not os.path.isdir('control-dir'):
        os.mkdir('control-dir')

    # generate a list of queries for the cells in the Discrete Global Grid 
    # http://discreteglobalgrids.org/
    queries = dgg.generate_quoted_queries(resolution)

    for i,control in enumerate(gen_control(sql,uq,job) for sql,uq in queries):

        f = open("control-dir/control-%04d.json" % (i,), "w")
        f.write(json.dumps(control))
        f.close()

if __name__ == "__main__":
    job = sys.argv[1]
    resolution = sys.argv[2]
    main(job, resolution)

    print "saving data to", os.path.join("/user/hduser/output",job)
