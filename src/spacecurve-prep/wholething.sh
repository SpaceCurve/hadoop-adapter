#!/bin/bash

./spacecurve-reset.sh
./1-earthquake-load.sh
./2-global-grid-load.sh
./3-hive-prep.sh

scctl show tables -n ArcGIS
