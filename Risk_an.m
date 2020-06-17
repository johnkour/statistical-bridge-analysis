function [Risk, Dlambda] = Risk_an(W, S, P, points, g, L, h, b, A, E, f_y, I, ...
                                            alpha, N_mc, M_mc, c_p_net)
%RISK ANALYSIS
%   This function performs all the necessary tests required to evaluate
%   whether the truss will fail due to wind load. It returns a scalar with
%   the risk of failure(Risk) for the number of the points provided
%   (points). The more the points the better the accuracy, but also the 
%   more the computentional cost, of the analysis.

ind(:,1) = randi([100, 950], points, 1);
ind(:,2) = randi([450, 10.^3], points, 1);
ind = sortrows(ind);

P_r = zeros(1, points);
for i = 1:points
    P_r(i) = P(ind(i,1),ind(i,2));
end

w = W(1, :);    s = S(:, 1);
s_r = s(ind(:,1));  w_r = w(ind(:,2));  w_r = wind_load(w_r, c_p_net);
loads = [w_r' ,s_r];

lambda = 1 - P_r;    lambda = lambda';
temp = sortrows([lambda, loads], 'descend');
lambda = temp(:,1);     loads = temp(:,2:end);

fprintf('\nCOMBINED SNOW AND WIND LOAD FOR RISK ANALYSIS:\n\n')

[MC_Prob, ~] = joined_an(loads, g, L, h, b, A, E, f_y, ...
                                            I, alpha, N_mc, M_mc);

Dlambda = lambda - [lambda(2:end); 0];


Risk = MC_Prob .* Dlambda;   Risk = sum(Risk);

end

