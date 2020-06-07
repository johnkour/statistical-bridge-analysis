# statistical-bridge-analysis
Part of the project of analizing an existing bridge statistically

  **Database_initialization.py** uses the server: http://meteosearch.meteo.gr/ to *gather the data* (maximum wind speed in km/h) for the 			project.
  **winddb.sqlite** is the database to use for our *statistical analysis*.
	**data_prep.py** extracts the subset of data (stored in winddb.sqlite) which is going to be used in our analysis.
	**keys.csv** and **values.csv** are the files containing the data.
	Specifically, **values.csv** contains the maximum average wind speed per month and **keys.csv** contains the year and the month assigned 	 to every row of *values.csv*.
	**w_speed** is an exponential function used to calculate the windspeed localy from the windspeed of the meteo-station.
	**prob_model** is used to try out several distributions for the windspeed.
	
