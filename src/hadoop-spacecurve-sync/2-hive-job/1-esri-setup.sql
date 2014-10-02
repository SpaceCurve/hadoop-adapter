add jar hdfs:///esri/lib/esri-geometry-api-1.2.jar;
add jar hdfs:///esri/lib/spatial-sdk-hive-1.0.3-SNAPSHOT.jar;
add jar hdfs:///esri/lib/spatial-sdk-json-1.0.3-SNAPSHOT.jar;

create temporary function ST_Point as 'com.esri.hadoop.hive.ST_Point';
create temporary function ST_Contains as 'com.esri.hadoop.hive.ST_Contains';
create temporary function ST_AsText as 'com.esri.hadoop.hive.ST_AsText';
create temporary function ST_Within as 'com.esri.hadoop.hive.ST_Within';
create temporary function ST_AsGeoJson as 'com.esri.hadoop.hive.ST_AsGeoJson';

drop table counties;

CREATE EXTERNAL TABLE IF NOT EXISTS counties (Area string, Perimeter string, State string, County string, Name string, BoundaryShape binary)                                         
ROW FORMAT SERDE 'com.esri.hadoop.hive.serde.JsonSerde'              
STORED AS INPUTFORMAT 'com.esri.json.hadoop.EnclosedJsonInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat';

load data local inpath 'california-counties.json' overwrite into table counties;
