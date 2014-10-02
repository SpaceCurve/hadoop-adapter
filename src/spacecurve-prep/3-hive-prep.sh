#!/bin/bash

echo "Loading schema for results from hive"
pushd $PWD/hive_result
sh load_schema.sh
popd

