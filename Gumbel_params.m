function [a,u] = Gumbel_params(mu, s)
%PARAMETERS OF GUMBEL DISTRIBUTION.
%   Using the mean(mu) and the standardt deviation(s) of the empirical data
%   , this function calculates the parameters to fit the Gumbel 
%   distribution(a, u).

g = 0.5772;

a = pi ./ (sqrt(6) .* s);
u = mu - g ./ a;
end

