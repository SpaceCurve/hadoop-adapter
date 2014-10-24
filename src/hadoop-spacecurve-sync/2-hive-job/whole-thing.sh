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

echo "syncing jars to hdfs"
./sync-jar-hdfs.sh

echo "creating tables, processing earthquake and county data"
hive -f whole-thing.sql

echo "should have a 000... file here"
hdfs dfs -ls /apps/hive/warehouse/job2_earthquake_agg
