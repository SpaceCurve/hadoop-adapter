#!/bin/bash

echo "loading global grid"
pushd $PWD/DGG
sh load_dgg.sh
popd
