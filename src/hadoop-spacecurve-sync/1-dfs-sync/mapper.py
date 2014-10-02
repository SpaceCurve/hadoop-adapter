#!/usr/bin/env python

import sys
import os
import json

for line in sys.stdin:

    control = json.loads(line)
    headers = ' '.join( '-H "%s"' % (x,) for x in control['headers'])
    command = '''curl -s %s "%s" | /usr/bin/hdfs dfs -put - %s''' % \
        (headers, control['url_query'], control['output'])
    print command
    os.system(command)
