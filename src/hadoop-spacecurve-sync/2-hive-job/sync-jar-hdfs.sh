#!/bin/bash

hdfs dfs -rm -r /esri
hdfs dfs -mkdir -p /esri/lib

hdfs dfs -put ./jars/esri-geometry-api-1.2.jar /esri/lib
hdfs dfs -put ./jars/spatial-sdk-hive-1.0.3-SNAPSHOT.jar /esri/lib
hdfs dfs -put ./jars/spatial-sdk-json-1.0.3-SNAPSHOT.jar /esri/lib

hdfs dfs -ls /esri/lib
