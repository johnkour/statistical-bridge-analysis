function [w_e] = wind_load(v_ref,c_p_net)
%WIND LOAD
%   This function uses the wind speed(v_ref) and a simplistic uniform value
%   for the pressure parameter(c_p_net) to calculate the wind load
%   according to EN1991 in kPa.

v_ref = v_ref .* 5 ./ 18;
q_ref = 1.25 .* v_ref .^ 2 ./ 2;
w_e = c_p_net .* q_ref ./ 10^3;

end

