import webbrowser
import time
import os

# open the subset_NLDAS_FORA0125_H_002_20240301_191240_.txt file
file_path = os.path.join(os.getcwd(), 'subset_NLDAS_FORA0125_H_002_20240301_191240_.txt')
# read the file
i = -1
with open(file_path, 'r') as file:
    # start form the second line read each 24 lines
    for line in file:
        if i % 24 == 0:
            #print(line)
            webbrowser.open(line)
        i += 1