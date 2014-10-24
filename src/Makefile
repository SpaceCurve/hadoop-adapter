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

# replace these with the IPs or names of your VMs
# HADOOP_ADDR=sandbox.hortonworks.com
# optionally make an entry for sandbox.hortonworks.com in your
# local /etc/hosts file, this makes viewing the web admin
# for Hadoop possible.
HADOOP_ADDR=192.168.217.133
SPACECURVE_ADDR=spacecurve

package:
	tar cvzf hadoop-spacecurve-sync.tar.gz hadoop-spacecurve-sync
	tar cvzf spacecurve-prep.tar.gz spacecurve-prep

sync:
	scp hadoop-spacecurve-sync.tar.gz hduser@$(HADOOP_ADDR):
	scp spacecurve-prep.tar.gz spacecurve@$(SPACECURVE_ADDR):

clean:
	rm *.tar.gz
