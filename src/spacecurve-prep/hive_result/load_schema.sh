scctl shell --ddl -n ArcGIS -f hive_result.sql

sleep 10
curl 127.1:8080/ArcGIS/schema/hiveresult
