function [load] = graphical_var()
%GRAPHICALLY ESTIMATED VARIABLES
%   This function defines manually the snow load(kPa) and the wind
%   speed(km/h) according to the contour graph of their joined probability
%   and returns a matrix named load. Load's first column is the wind speed
%   in km/h and it's second column is the snow load in kPa.

snow = [1.734; 2.421; 3.108; 3.795; 4.482];
wind = [29.82; 25.38; 25.26; 25.20; 25.23];

load = [wind, snow];

end

