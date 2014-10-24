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
