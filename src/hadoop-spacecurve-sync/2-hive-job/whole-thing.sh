#!/bin/bash

echo "syncing jars to hdfs"
./sync-jar-hdfs.sh

echo "creating tables, processing earthquake and county data"
hive -f whole-thing.sql

echo "should have a 000... file here"
hdfs dfs -ls /apps/hive/warehouse/job2_earthquake_agg
