DROP TABLE IF EXISTS earthquake;

CREATE EXTERNAL TABLE IF NOT EXISTS earthquake (
    time string,
    place string,
    latitude double,
    longitude double,
    mag double,
    shape binary
)
ROW FORMAT SERDE 'com.esri.hadoop.hive.serde.GeoJsonSerde'              
STORED AS INPUTFORMAT 'com.esri.json.hadoop.UnenclosedJsonInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 'hdfs:///user/hduser/output/job1/';
