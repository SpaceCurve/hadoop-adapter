package:
	tar cvzf hadoop-spacecurve-sync.tar.gz hadoop-spacecurve-sync
	tar cvzf spacecurve-prep.tar.gz spacecurve-prep

sync:
	scp hadoop-spacecurve-sync.tar.gz hduser@sandbox.hortonworks.com:
	scp spacecurve-prep.tar.gz spacecurve@spacecurve:

clean:
	rm *.tar.gz
