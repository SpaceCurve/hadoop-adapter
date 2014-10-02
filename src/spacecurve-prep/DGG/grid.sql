CREATE TYPE schema.feature IS WHEN "Feature" THEN UNIT;

CREATE TYPE schema.grid_properties AS RECORD (
	"center"  VARRAY of BINARY FLOAT,--Limited ListSupport          --DataNode: center : ['list'] : n= 1168984   path:{root.root.grid.properties.center}
	"id" VARCHAR,                                                             --DataNode: id : ['unicode'] : n= 1168984   [unicode n=1168984 avg_len=9.2 min=5 max=10] path:{root.root.grid.properties.id}
	"query" VARCHAR,                                                          --DataNode: query : ['unicode'] : n= 1168984   [unicode n=1168984 avg_len=5.0 min=5 max=5] path:{root.root.grid.properties.query}
	"radius" BINARY FLOAT,                                                    --DataNode: radius : ['float'] : n= 1168984   [float n=1168984 avg=50.07 min=25.94 max=4156.17] path:{root.root.grid.properties.radius}
	"resolution" VARCHAR,                                                     --DataNode: resolution : ['unicode'] : n= 1168984   [unicode n=1168984 avg_len=3.0 min=3 max=3] path:{root.root.grid.properties.resolution}
	"randompoints_inout" VARRAY of UNSIGNED SMALLINT NULL,
	"randompoints_query" VARCHAR NULL,
	"randompoints_join_query" VARCHAR NULL,
	"zRenderColor"  VARRAY of UNSIGNED SMALLINT NULL --Limited ListSupport    --DataNode: zRenderColor : ['list'] : n= 1168984   path:{root.root.grid.properties.zRenderColor}
);
CREATE TABLE schema.grid (
	"geometry" geography,  -- Choose geometry/geography                       --[geometry n=1168984 Polygon: 1168984  points: (min=13 max=25)] numPolygonsWithHoles: 0 // BoundBox: (c= 22233384) [[-180.0000, -90.0000],[180.0000, 90.0000]]
	"properties" schema.grid_properties,                                      --DataNode: properties : ['dict'] : n= 1168984   path:{root.root.grid.properties}
	"type" schema.feature                                                     --DataNode: type : ['unicode'] : n= 1168984   [unicode n=1168984 avg_len=7.0 min=7 max=7] path:{root.root.grid.type}
, PARTITION KEY ("geometry")
);