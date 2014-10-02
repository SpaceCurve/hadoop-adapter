drop table if exists job2_earthquake_agg;

create table job2_earthquake_agg as
SELECT name, ST_AsGeoJson(boundaryshape) as geojson_boundary, count(*) cnt FROM counties
JOIN earthquake
WHERE ST_Contains(counties.boundaryshape, earthquake.shape)
GROUP BY counties.name, counties.boundaryshape
ORDER BY cnt desc;

select name,cnt from job2_earthquake_agg;
