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
