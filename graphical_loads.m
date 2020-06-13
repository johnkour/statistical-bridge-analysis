function [load] = graphical_loads(c_p_net)
%GRAPHICALLY ESTIMATED LOADS
%   This function defines manually the snow load(kPa) and the wind
%   speed(km/h) according to the contour graph of their joined probability
%   and returns a matrix named load. Load's first column is the wind load
%   in kPa and it's second column is the snow load in kPa.

temp = graphical_var();     wind = temp(:,1);   snow = temp(:,2);
wind = wind_load(wind, c_p_net);

load = [wind, snow];

end

