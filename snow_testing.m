function [MC_Prob, MC_P_std] = snow_testing(snow_distr, mean_s, ...
                                        sigma_s, T, g, L, h, b, A, E, ...
                                        f_y, I, alpha, N_mc, M_mc)
%TESTING, PART 2: SNOW
%   This function performs all the necessary tests required to evaluate
%   whether the truss will fail due to snow load. It returns a vector with
%   the probability of failure(MC_Prob) for every value of the restoration 
%   period(T).

%% ==================CALCULATE EXPECTED SNOW LOAD==========================

params = zeros(2);
cov = sigma_s ./ mean_s;
params(2) = log(cov .^ 2 + 1);  params(2) = sqrt(params(2));
params(1) = log(mean_s) - 1 ./ 2 .* params(2) .^ 2;

pd = makedist(snow_distr, 'mu', params(1), 'sigma', params(2));

p = 1 ./ T; p = 1 - p;

%% =====================PREPARE LOADS FOR ANALYSIS=========================

snow = icdf(pd, p);             % Snow load in kPa.

q = g + snow;    q = q .* b ./ 2;    % Distributed loads of the truss(kN/m).

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

[MC_Prob, MC_P_std] = simple_monte_carlo(N_min, N_max, N_mc, M_mc, ...
                                    pd, L, A, E, I, alpha);

%% ==========================EXPORT RESULTS================================

for i = 1:length(N_min)
    fprintf( ...
      'The probability of failure for T = %d years is: %.2f percent.\n', ...
                    T(i), MC_Prob(i) .* 100);

end

%--------------------------------------------------------------------------

end

