#!/bin/bash
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

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/../SPACECURVE_IP.sh

echo "using ${SPACECURVE_IP:?"SPACECURVE_IP needs to be set"} for SpaceCurve IP"

hdfs dfs -cat /apps/hive/warehouse/job2_earthquake_agg/00* \
    | ./geo_filter.py \
    | curl -f --data-binary @- $SPACECURVE_IP:8080/ArcGIS/schema/hiveresult

# print out the number of rows in hiveresult, confirms the upload
curl -s $SPACECURVE_IP:8080/ArcGIS/schema/hiveresult | wc -l
