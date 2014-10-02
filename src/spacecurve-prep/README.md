# SpaceCurve Setup

## Reset

```
pushd ~/VM 
source nuke.sh
popd
```

```
# nuke.sh
scctl stop
sleep 5
sh scripts/cleanup.sh 
scctl start
sleep 20
sh scripts/init.sh 
sleep 20
scctl status
```

Should end with

```
[2481] starting /opt/spacecurve/scdb/1.2.0.0-202_c0ed0_HEAD_release/bin//master -y -m127.0.0.1 -n0 -c/opt/spacecurve/scdb/1.2.0.0-202_c0ed0_HEAD_release/pysrc/scdb/../../conf/master.properties -d/var/opt/spacecurve/scdb/data/node_0 -C
==> Checking status...
[2516] running /opt/spacecurve/scdb/1.2.0.0-202_c0ed0_HEAD_release/bin//front -y -m127.0.0.1 -n100 -c/opt/spacecurve/scdb/1.2.0.0-202_c0ed0_HEAD_release/conf//front.properties
[2515] running /opt/spacecurve/scdb/1.2.0.0-202_c0ed0_HEAD_release/bin//worker -y -m127.0.0.1 -n2 -c/opt/spacecurve/scdb/1.2.0.0-202_c0ed0_HEAD_release/conf//worker.properties -d/var/opt/spacecurve/scdb/data/node_2/engine_0
[2514] running /opt/spacecurve/scdb/1.2.0.0-202_c0ed0_HEAD_release/bin//worker -y -m127.0.0.1 -n1 -c/opt/spacecurve/scdb/1.2.0.0-202_c0ed0_HEAD_release/conf//worker.properties -d/var/opt/spacecurve/scdb/data/node_1/engine_0
[2481] running /opt/spacecurve/scdb/1.2.0.0-202_c0ed0_HEAD_release/bin//master -y -m127.0.0.1 -n0 -c/opt/spacecurve/scdb/1.2.0.0-202_c0ed0_HEAD_release/pysrc/scdb/../../conf/master.properties -d/var/opt/spacecurve/scdb/data/node_0 -C
[2466] exited /opt/spacecurve/scdb/1.2.0.0-202_c0ed0_HEAD_release/bin//master -y -m127.0.0.1 -n0 -c/opt/spacecurve/scdb/1.2.0.0-202_c0ed0_HEAD_release/conf//master.properties -d/var/opt/spacecurve/scdb/data/node_0
==> OK
```

## Load Earthquake Data

```
pushd ~/VM/datasets/earthquakes
sh scripts/1_transform.sh
sh scripts/2_schema.sh
sleep 10
sh scripts/3_load.sh
popd
```

There should be 17939 entries in the database

```
curl -s 'http://127.1:8080/ArcGIS/select%20*%20from%20schema.earthquakes;' | wc -l
17939
```

## Load Global Grids

```
pushd ~/hdfs-sync/DGG
sh load_dgg.sh
popd
```

It should finish with

```
importing grid data into spacecurve
done
grid points uploaded
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 4418k    0 4418k    0     0  20.6M      0 --:--:-- --:--:-- --:--:-- 20.6M
10240
```

## Create destination schema

```
pushd ~/hdfs-sync/hive_result
sh load_schema.sh
popd
```

## Confirm schema


```
scctl show tables -n ArcGIS
scdb.scdb_tables (system)
scdb.scdb_partitions (system)
scdb.scdb_stats (system)
scdb.scdb_types (system)
scdb.scdb_type_elements (system)
scdb.scdb_partition_states (system)
schema.earthquakes
schema.grid
schema.hiveresult
```

