DROP TABLE IF EXISTS job2_earthquake_agg;

CREATE TABLE job2_earthquake_agg AS
SELECT
    name, ST_AsGeoJson(boundaryshape) AS geojson_boundary, count(*) cnt FROM counties
JOIN
    earthquake
WHERE
    ST_Contains(counties.boundaryshape, earthquake.shape)
GROUP BY
    counties.name, counties.boundaryshape
ORDER BY
    cnt DESC;

SELECT name,cnt FROM job2_earthquake_agg;
