# replace these with the IPs or names of your VMs
HADOOP_ADDR=sandbox.hortonworks.com
SPACECURVE_ADDR=spacecurve

package:
	tar cvzf hadoop-spacecurve-sync.tar.gz hadoop-spacecurve-sync
	tar cvzf spacecurve-prep.tar.gz spacecurve-prep

sync:
	scp hadoop-spacecurve-sync.tar.gz hduser@$(HADOOP_ADDR):
	scp spacecurve-prep.tar.gz spacecurve@$(SPACECURVE_ADDR):

clean:
	rm *.tar.gz
