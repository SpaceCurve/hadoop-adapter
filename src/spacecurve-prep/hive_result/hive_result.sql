CREATE TYPE schema.feature IS WHEN "Feature" THEN UNIT;

CREATE TYPE schema.hiveresult_properties AS RECORD (
	"county" VARCHAR,
	"cnt" VARCHAR
);

CREATE TABLE schema.hiveresult (
	"geometry" geography,
	"properties" schema.hiveresult_properties,
	"type" schema.feature
, PARTITION KEY ("geometry")
);
