curl -f --data-binary @hive_result.geojson $SPACECURVE_IP:8080/ArcGIS/schema/hiveresult
curl -s $SPACECURVE_IP:8080/ArcGIS/schema/hiveresult | wc -l
