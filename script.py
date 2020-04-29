# We start by accessing the meteo server.

# IMPORT USEFULL LIBRARIES:

import urllib.request, urllib.parse, urllib.error, ssl, re, sqlite3
from bs4 import BeautifulSoup

# MODIFICATION FOR https SERVERS:

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

# INITIALIZATION AND INPUTS:

expression = '([0-9.]+)\s+\S+\s+\S+\s+\S+\s+\n'

core_url = 'http://' + 'meteosearch.meteo.gr/' + 'data/'
region = input('''
   Please enter the region you would like to access (default: megalopoli):\n''')
if (len(region) < 1):    region = 'megalopoli'
core_url = core_url + region + '/'

start_month = input('''
    Please enter which month we will begin (default: 01):\n''')
if (len(start_month) < 1):    start_month = '01'
start_year = input('''
    Please enter which year we will begin (default: 2009):\n''')
if (len(start_year) < 1):    start_year = '2010'

end_month = input('''
    Please enter which month we will end (default: 01):\n''')
if (len(end_month) < 1):    end_month = '01'
end_year = input('''
    Please enter which year we will end (default: 2020):\n''')
if (len(end_year) < 1):    end_year = '2020'

# INITIALIZATION OF DATABASE:

conn = sqlite3.connect('winddb.sqlite')
cur = conn.cursor()

cur.execute('''
    DROP TABLE IF EXISTS Winds''')

cur.execute('''
    CREATE TABLE Winds (year INTEGER, month INTEGER, wind REAL)''')

# PROCESSING THE DATA:

for year in range(int(start_year), int(end_year)):
    for month in range(1,13):
        
        cur.execute('''
        SELECT wind FROM Winds WHERE year = ? AND month = ?''', (year, month))
        row = cur.fetchone()
        
        aux_url = str(year) + '-'
        if month < 10:    aux_url = aux_url + '0'
        aux_url = aux_url + str(month) + '.txt'
        url = core_url + aux_url
        html = urllib.request.urlopen(url, context = ctx).read()
#        print(html)
        soup = BeautifulSoup(html, 'html.parser')
        print(soup)
        data = soup.decode()
        wind = re.findall(expression, data)
        print(wind)
        w = list()
        [w.append(float(x)) for x in wind]
        max_wind = max(w)
        print(max_wind)
        
        cur.execute('''
    INSERT INTO Winds (year, month, wind) VALUES (?, ?, ?)''', (year,month, max_wind))
    
    conn.commit()

conn.commit()

cur.close()