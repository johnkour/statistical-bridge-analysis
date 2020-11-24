# statistical-bridge-analysis
Part of the project of analizing an existing bridge statistically

  **Database_initialization.py** uses the server: http://meteosearch.meteo.gr/ to *gather the data* (maximum wind speed in km/h) for the 			project.\
  **winddb.sqlite** is the database to use for our *statistical analysis*.\
  **data_prep.py** extracts the subset of data (stored in winddb.sqlite) which is going to be used in our analysis.\
  **keys.csv** and **values.csv** are the files containing the data.\
  Specifically, **values.csv** contains the maximum average wind speed per month and **keys.csv** contains the year and the month assigned to every row of *values.csv*.\
  \
  **prob_analysis** is the file containing the stuctural anlysis with probability theory.\
  \
  **w_speed** is an exponential function used to calculate the windspeed localy from the windspeed of the meteo-station.\
  **Empirical_Data** is used to visualise the wind data, forming a histogram an the CDF.\
  **prob_model** is used to try out several distributions for the windspeed.\
  \
  **wind_testing** is the file containing the analysis for the wind load (end of the first part of the assignment).\
  **wind_load** is a file calculating the wind load from the wind speed according to EN1991.\
  **snow_testing** is the file containing the analysis for the snow load(second part of the assignment).\
  **buck_res** is used to calculate the resistance of the weakest element of the truss to buckling.\
  **simple_monte_carlo** performs a number of Monte Carlo simulations to determine the probability of failure due to one kind of uncertainty (wind-load or snow-load).\
  \
  **joined_prob** forms a grid with the values of the wind speed and the snow load and then computes, calculates and then plots their joined PDF and CDF.\
  **graphical_var** manualy sets the values of the variables according to the contour plot of their joined CDF.\
  **graphical_loads** converts the values of the variables defined in *graphical_var* to loads in kPa.\
  Finally, the *risk analysis* is performed using the file **Risk_an** which uses the grid of values and the joined CDF from *joined_prob* to calulate the risk of failure.\
  The probabilities of failure for the various sets of values for wind speed and snow load evaluated are calculated in the function **joined_an**.\
  By using a denser grid the *accuracy* is enhanced, but this leads to greater *computational cost*.\
  \
  \
The files in folder **Solver in Matlab** were provided by the **School Of Civil Engineering, NTUA**.\
