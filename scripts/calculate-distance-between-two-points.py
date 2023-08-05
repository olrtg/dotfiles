#!/usr/bin/env python3

import sys
import pandas as pd
from geopy.distance import geodesic

filepath = sys.argv[1] if len(sys.argv) > 1 else None

if not filepath:
    print("Please provide a filepath")
    sys.exit(1)

"""
Shape:
---
id                    int64
name                 object
description          object
from_latitude       float64
from_longitude      float64
to_latitude         float64
to_longitude        float64
center_latitude     float64
center_longitude    float64
created_at           object
created_by           object
organization_id     float64
"""
data = pd.read_csv(filepath)

MAX_DIAGONAL_AREA_IN_METERS = 575000

coordinates: pd.DataFrame = data[
    ["from_latitude", "from_longitude", "to_latitude", "to_longitude"]
]


def calculate_distance(row):
    from_coordinates = (row["from_latitude"], row["from_longitude"])
    to_coordinates = (row["to_latitude"], row["to_longitude"])
    return geodesic(from_coordinates, to_coordinates).meters


distances = coordinates.apply(calculate_distance, axis=1)
distancesWithoutOutliers = distances[distances < MAX_DIAGONAL_AREA_IN_METERS]

print("DISTANCES IN METERS:")
print("--------------------")
print("MEAN:", distances.mean())
print("MAX:", distances.max())
print("MIN:", distances.min())
print("")
print("")
print("EXCLUDING OUTLIERS (OUTSIDE THE CURRENT LIMITS):")
print("--------------------")
print("MEAN:", distancesWithoutOutliers.mean())
print("MAX:", distancesWithoutOutliers.max())
print("MIN:", distancesWithoutOutliers.min())
