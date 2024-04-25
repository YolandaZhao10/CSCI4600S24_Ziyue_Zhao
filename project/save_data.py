import pygrib
import os
import numpy as np
import matplotlib.pyplot as plt

data_list = open('subset_NLDAS_FORA0125_H_002_20240301_191240_.txt', 'r')
point1_result = []
point2_result = []
point3_result = []
point4_result = []

for line in data_list:
    line = line.strip()
    if line.endswith('README.NLDAS2.pdf'):
        continue
    line = line.split("NLDAS_FORA0125_H")
    # check if the file is exist
    file_path = "./data/NLDAS_FORA0125_H"+line[-1]
    if os.path.exists(file_path):
      with pygrib.open(file_path) as grbs:
          grb = grbs.message(1)
          data = grb.values
          lats, lons = grb.latlons()# Get latitudes and longitudes
          # Hollywood, Los Angeles, California, United States
          desired_lat = 35.0625  # latitude
          desired_lon = -115.9375  # longitude

          # Find the nearest latitude and longitude for a specific location
          idx = np.abs(lats - desired_lat) + np.abs(lons - desired_lon)
          lat_idx, lon_idx = np.unravel_index(np.argmin(idx), idx.shape)
          
          # Extract the data point at the nearest location
          data_point = data[lat_idx, lon_idx]
          point1_result.append(data_point)


          desired_lat = 40.0625  # latitude
          desired_lon = -80.0625 # longitude

          # Find the nearest latitude and longitude for a specific location
          idx = np.abs(lats - desired_lat) + np.abs(lons - desired_lon)
          lat_idx, lon_idx = np.unravel_index(np.argmin(idx), idx.shape)
          
          # Extract the data point at the nearest location
          data_point = data[lat_idx, lon_idx]
          point2_result.append(data_point)


          desired_lat = 52.9375  # latitude
          desired_lon = -67.0625 # longitude

          # Find the nearest latitude and longitude for a specific location
          idx = np.abs(lats - desired_lat) + np.abs(lons - desired_lon)
          lat_idx, lon_idx = np.unravel_index(np.argmin(idx), idx.shape)

          # Extract the data point at the nearest location
          data_point = data[lat_idx, lon_idx]
          point3_result.append(data_point)

          desired_lat = 52.9375  # latitude
          desired_lon = -115.9375 # longitude

          # Find the nearest latitude and longitude for a specific location
          idx = np.abs(lats - desired_lat) + np.abs(lons - desired_lon)
          lat_idx, lon_idx = np.unravel_index(np.argmin(idx), idx.shape)

          # Extract the data point at the nearest location
          data_point = data[lat_idx, lon_idx]
          point4_result.append(data_point)
    else:
        continue
    
# convert the list to numpy array
point1_result = np.array(point1_result)
point2_result = np.array(point2_result)
point3_result = np.array(point3_result)
point4_result = np.array(point4_result)

# save the data to a .csv file
np.savetxt("point1_result.csv", point1_result, delimiter=",")
np.savetxt("point2_result.csv", point2_result, delimiter=",")
np.savetxt("point3_result.csv", point3_result, delimiter=",")
np.savetxt("point4_result.csv", point4_result, delimiter=",")