function [F] = Gumbel_CDF(a, u, y)
%CDF OF GUMBEL DISTRIBUTION.
%   This function gets the parameters of the Gumbel distribution(a, u) and
%   calculates the CDF of a specific point(y).


F = -a .* ( y - u);
F = -exp(F);
F = exp(F);

end

