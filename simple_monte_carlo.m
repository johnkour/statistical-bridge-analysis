function [MC_Prob, MC_Prob_std] = simple_monte_carlo(N_min, N_max, ...
                                            N_mc, M_mc, T, pd, L, A, ...
                                            E, I, alpha)
%MONTE CARLO FOR THE WIND SPEED
%   This function computes the probability of failure(MC_Prob) according to
%   the method Monte Carlo. It uses the minimum and maximum axial forces 
%   due to the wind load(N_min & N_max), the number of Monte Carlo
%   samples(N_mc), the number of Monte Carlo simulations(M_mc), the 
%   restoration period(T), the distribution of the yield stress(pd), the 
%   length(L), area(A), elasticity modulus(E), the moment of inertia(I) and
%   the buckling parameter(alpha) of every member.

k = zeros(size(N_min));
temp = zeros(length(N_min), M_mc);

for j = 1:M_mc                      % Number of Monte Carlo simulations.

    for i = 1:length(N_min)

        x = rand(N_mc, 1);  f_y_mc = icdf(pd, x);

%% =====================BUCKLING ANALYSIS==================================

        N_rd_b = buck_res(L, A, E, I, f_y_mc, alpha);
        N_rd = A .* f_y_mc .* 10 .^3;

        MC = double((abs(N_min(i)) < abs(N_rd_b)) & (N_max(i) < N_rd));

        k(i) = N_mc - sum(MC);

        temp(i,j) = k(i) ./ N_mc;

    end

end

MC_Prob = mean(temp, 2);
MC_Prob_std = std(temp, 0, 2);         % Standard deviation for MC_Prob.

for i = 1:length(N_min)
    fprintf( ...
      'The probability of failure for T = %d years is: %.2f percent.\n', ...
                    T(i), MC_Prob(i) .* 100);

end


end

