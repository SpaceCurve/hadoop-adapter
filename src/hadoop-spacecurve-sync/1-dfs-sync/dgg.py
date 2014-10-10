try:
    import simplejson as json
except:
    import json

import urllib2
import os
import sys

__doc__ = """\

This library queries SpaceCurve for the polygons that make up a total covering of earth using the Discrete Global Grid.

http://discreteglobalgrids.org/

The grid data is assumed to have been imported to /ArcGIS/schema/grids

Using this grid data we form a set of queries, one per cell, that extracts all the earthquakes within that cell.

"""

"""

ArcGIS> select * from schema.earthquakes as e where e."geometry".st_within(st_geography('POLYGON((101.25 -69.094843, 146.25 -35.26439, -168.75 -20.905157, -123.75 -35.264389, -78.75 -69.094842, 101.25 -69.094843))'));

"""

SPACECURVE_IP = os.environ['SPACECURVE_IP']
print "using %s for SPACECURVE_IP" % (SPACECURVE_IP)

def spacecurve_query(url):
    q = urllib2.Request(url)
    q.add_header("Accept", "application/noheader+json")
    body = urllib2.urlopen(q).read()
    return body


def get_query_url(resolution):
    return r'''http://{0}:8080/ArcGIS/select%20*%20from%20schema.grid%20where%20properties.resolution%20=%20'{1}';'''.format(SPACECURVE_IP,resolution)


def spacecurve_objects(raw_result_body):
    return [ json.loads(geojson) for geojson in raw_result_body.split('\r\n') if len(geojson) > 0 ]


def get_grid_objects(resolution):
    query_result = spacecurve_query(get_query_url(resolution))
    return spacecurve_objects(query_result)


def grid_to_pred(grid):
    "converts a grid row to a predicate"
    polygon = 'POLYGON((' + ', '.join([ "%s %s" % (a,b)  for a,b in grid['geometry']['coordinates'][0] ]) + '))'
    predicate = r'''"geometry".st_within(st_geography('%s'))''' % (polygon,)
    return predicate

def earthquake_within(pred):
    return "select * from schema.earthquakes as e where e." + pred + ";"


def generate_queries(resolution):
    preds = [ grid_to_pred(grid) for grid in get_grid_objects(resolution) ]
    queries = [ earthquake_within(pred) for pred in preds ]
    return queries


def quote_url(s):
    return "http://%s:8080/ArcGIS/%s" % (SPACECURVE_IP, urllib2.quote(s))


def dump_earthquake_cell_count(resolution):
    grids = get_grid_objects(resolution)
    for grid in grids:
        sql = earthquake_within(grid_to_pred(grid))
        query_result = spacecurve_query(quote_url(sql))
        earthquakes = spacecurve_objects(query_result)
        grid['properties']['earthquake_count'] = len(earthquakes)
    return grids


def tojsonstr(geojson_l):
    return "\n".join([ json.dumps(s) for s in geojson_l ])


def run_earthquake_cell_report(resolution,path):
    with open(path,"w") as f:
        f.write(tojsonstr(dump_earthquake_cell_count(resolution)))


def generate_quoted_queries(resolution='4h0'):
    """list of http urls for earthquakes within a grid by <resolution>:string

    The guaranteed minimum set of resolutions is:

        ====================
          cells | resolution
        ====================      
              12 "4h0"
              42 "4h1"
             162 "4h2"
             642 "4h3"
            2562 "4h4"
              20 "4t0"
              80 "4t1"
             320 "4t2"
            1280 "4t3"
            5120 "4t4"

    Your database may have more.
    """
    return [ (q, quote_url(q)) for q in generate_queries(resolution) ]

if __name__ == "__main__":
    argv = sys.argv
    if "--earthquake-cell-report" in argv:
        resolution = argv[argv.index("--resolution") + 1]
        output =     argv[argv.index("-o") + 1]
        run_earthquake_cell_report(resolution,output)


