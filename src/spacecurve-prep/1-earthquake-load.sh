#!/bin/bash

pushd ~/VM/datasets/earthquakes
sh scripts/1_transform.sh
sh scripts/2_schema.sh
sleep 10
sh scripts/3_load.sh
popd
