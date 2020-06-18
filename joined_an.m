function [MC_Prob, MC_P_std] = joined_an(loads, g, L, h, b, ...
                                            A, E, f_y, I, alpha, N_mc, ...
                                            M_mc)
%TESTING, PART 3: SNOW AND WIND
%   This function performs all the necessary tests required to evaluate
%   whether the truss will fail due to wind load. It returns a vector with
%   the probability of failure(MC_Prob) for every value of the restoration 
%   period(T).


%% =====================PREPARE LOADS FOR ANALYSIS=========================

q = g + sum(loads, 2);  q = q .* b ./ 2; % Distributed loads of the truss(kN/m).

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

for i = 1:length(q)
    fprintf( ...
'The probability of failure for wind = %.4f kPa and snow = %.2f kPa is: %.2f percent.\n', ...
                    loads(i, 1), loads(i, 2), MC_Prob(i) .* 100);

end

%--------------------------------------------------------------------------

end

