function [MC_Prob, MC_P_std] = wind_testing(wind, wind_distr, T, ...
                                         c_p_net, g, L, h, b, A, E, ...
                                         f_y, I, alpha, N_mc, M_mc)
%TESTING, PART 1: WIND
%   This function performs all the necessary tests required to evaluate
%   whether the truss will fail due to wind load. It returns a vector with
%   the probability of failure(MC_Prob) for every value of the restoration 
%   period(T).

%% =================CALCULATE EXPECTED WIND SPEED==========================

pd = fitdist(wind, wind_distr);

p = 1 ./ T; p = 1 - p;

v_ref = icdf(pd, p);

%% ============================WIND LOAD===================================

w_e = wind_load(v_ref,c_p_net);      % Wind load in kPa.

%% =====================PREPARE LOADS FOR ANALYSIS=========================

q = g + w_e;    q = q .* b; % Distributed loads of the truss(kN/m).

%% ==================CALCULATE OPTIMA OF THE AXIAL FORCES==================

N_min = zeros(size(q));
N_max = N_min;
for i = 1:length(q)
    [N_min(i), N_max(i)] = thema(q(i), L, h, E, A);
end

%% =====================STRENGTH OF EACH MEMBER============================

params(1) = 1.15 .* f_y;        % Mean.
params(2) = 0.35 .* params(1);  % Standard deviation

pd = makedist('Normal', 'mu', params(1), 'sigma', params(2));

%% =======================MONTE CARLO SIMULATION===========================

[MC_Prob, MC_P_std] = simple_monte_carlo(N_min, N_max, N_mc, M_mc, T, ...
                                pd, L, A, E, I, alpha);

end

