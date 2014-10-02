echo "correcting polygon order"
python orient.py grid.json.old > grid.json

scctl shell --ddl -n ArcGIS -f grid.sql

sleep 10

echo "importing grid data into spacecurve"
curl -f --data-binary @grid.json 127.1:8080/ArcGIS/schema/grid
echo "done"
echo "grid points uploaded"
curl 127.1:8080/ArcGIS/schema/grid | wc -l
