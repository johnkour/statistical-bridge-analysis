# Modify the data collected in the database so as to be ready for analysis 
# through Matlab.

# IMPORT USEFULL LIBRARIES:

import sqlite3
import numpy as np

# ACCESS THE DATABASE:

conn = sqlite3.connect('winddb.sqlite')
cur = conn.cursor()

# GATHER THE DATA IN AN ARRAY:

cur.execute('SELECT * FROM Winds')

Data = cur.fetchall()                     # List containig the rows of data.

cur.close()

Data = np.array(Data)                     # Array containing the data.

s_year = int(Data[0, 0])
s_month = int(Data[0, 1])
if (s_month != 1):    Data = Data[Data[:, 0] > s_year]

l_year = int(Data[-1, 0])
l_month = int(Data[-1, 1])
if (l_month != 12):    Data = Data[Data[:, 0] < l_year]

keys = Data[:, :2]
keys = keys.astype(int)

values = Data[:, 2:]

# SAVE THE DATA FOR THE ANALYSIS AS CSV TO ACCESS WITH MATLAB:

np.savetxt('keys.csv', keys, fmt = '%d', delimiter = ';')
np.savetxt('values.csv', values, delimiter = ';')
