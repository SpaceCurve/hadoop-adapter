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

rm control-dir/*.json

hdfs dfs -rm -r output/job1
hdfs dfs -rm -r output/earthquake
hdfs dfs -rm -r temp/earthquake
hdfs dfs -mkdir -p temp/earthquake/control
hdfs dfs -mkdir -p output/job1

python gen_control.py job1 4h0

hdfs dfs -copyFromLocal control-dir/*.json temp/earthquake/control

hdfs dfs -ls temp/earthquake/control

hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
    -D mapreduce.job.reduces=0 \
    -input temp/earthquake/control \
    -output output/earthquake \
    -mapper mapper.py \
    -file mapper.py

hdfs dfs -ls output/earthquake
hdfs dfs -ls output/job1/*.json
