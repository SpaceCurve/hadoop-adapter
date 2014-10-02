#!/bin/bash

echo "DESTROY all SpaceCurve data??"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

echo "stopping spacecurve"
pushd ~/VM
scctl stop
sleep 5
echo "cleaning"
sh scripts/cleanup.sh 
scctl start
sleep 5
echo "init"
sh scripts/init.sh 
sleep 5 
scctl status
popd
echo "done"
