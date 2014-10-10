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
