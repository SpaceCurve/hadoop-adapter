#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/../SPACECURVE_IP.sh

echo "using ${SPACECURVE_IP:?"SPACECURVE_IP needs to be set"} for SpaceCurve IP"

hdfs dfs -cat /apps/hive/warehouse/job2_earthquake_agg/00* \
    | ./geo_filter.py \
    | curl -f --data-binary @- $SPACECURVE_IP:8080/ArcGIS/schema/hiveresult

# print out the number of rows in hiveresult, confirms the upload
curl -s $SPACECURVE_IP:8080/ArcGIS/schema/hiveresult | wc -l
