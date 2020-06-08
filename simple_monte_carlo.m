function [MC_Prob] = simple_monte_carlo(N_min, N_max, N_mc, T, pd, L, ...
                                            A, E, I, alpha)
%MONTE CARLO FOR THE WIND SPEED
%   This function computes the probability of failure(MC_Prob) according to
%   the method Monte Carlo. It uses the minimum and maximum axial forces 
%   due to the wind load(N_min & N_max), the number of Monte Carlo
%   simulations(N_mc), the restoration period(T), the distribution of the
%   yield stress(pd), the length(L), area(A), elasticity modulus(E), the
%   moment of inertia(I) and the buckling parameter(alpha) of every member.

k = zeros(size(N_min));
MC_Prob = zeros(size(N_min));

for i = 1:length(N_min)

    x = rand(N_mc, 1);  f_y_mc = icdf(pd, x);

%% =====================BUCKLING ANALYSIS==================================

    N_rd_b = buck_res(L, A, E, I, f_y_mc, alpha);
    N_rd = A .* f_y_mc .* 10 .^3;

    MC = double((abs(N_min(i)) < abs(N_rd_b)) & (N_max(i) < N_rd));

    k(i) = N_mc - sum(MC);

    MC_Prob(i) = k(i) ./ N_mc;

    X = sprintf( ...
      'The probability of failure for T = %d years is: %.2f percent.', ...
                        T(i), MC_Prob(i) .* 100);
    
    disp(X)

end

end

