function [u] = w_speed(z, z_ref, u_ref)
%WIND SPEED: Model for the wind speed.
%   This function uses an exponential law to calculate the wind speed in
%   the area of interest(u), given the wind speed at the area where the 
%   data were gathered(u_ref). The local height(z), as well as the height 
%   of the area where the data were gathered(z_ref) need to be provided. 
%   The parameter a has default value of 20%.

%% =====================INITIALIZE DEFAULT VALUES==========================

a = 0.2;

%% ========================CALCULATE WIND SPEED============================

u = (z ./ z_ref).^a;
u = u .* u_ref;

end

