function [f] = Gumbel_PDF(a, u, y)
%PDF OF GUMBEL DISTRIBUTION.
%   This function gets the parameters of the Gumbel distribution(a, u) and
%   calculates the PDF of a specific point(y).

f = exp(-a .* (y - u));
f = a .* exp(-(a .* (y - u) + f));

end

