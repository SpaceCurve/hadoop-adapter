import json
import math
import fileinput

def ecef(point):
    a = 6378137.0       # major axis wgs84
    b = 6356752.314245  # minor axis wgs84
    e = math.sqrt(1 - ((b*b)/(a*a)))
    esqr = e*e
    h = 0 # ignore altitude
    phi = point[1] * math.pi / 180.0
    L   = point[0] * math.pi / 180.0
    sinphi = math.sin(phi)
    chi = math.sqrt(1 - (esqr * sinphi * sinphi))
    term = ((a/chi) + h) * math.cos(phi)
    return [term * math.cos(L), term * math.sin(L), (((1-esqr) * a/chi) + h) * sinphi]

def orient(p, q, r):
    pryz = (p[2] * r[1]) - (p[1] * r[2])
    prxz = (p[0] * r[2]) - (p[2] * r[0])
    prxy = (p[1] * r[0]) - (p[0] * r[1])
    d = (q[0] * pryz) + (q[1] * prxz) + (q[2] * prxy)
    return (d > 0) - (0 > d)

SPECIAL_CASES = set("4h1_41 4h2_156 4h3_605".split())

if __name__ == "__main__":
    for line in fileinput.input():
        data = json.loads(line)
        angle = map(ecef, data["geometry"]["coordinates"][0][0:3])
        if orient(*angle) < 0 or data["properties"]["id"] in SPECIAL_CASES:
            data["geometry"]["coordinates"][0].reverse()
        print json.dumps(data)
