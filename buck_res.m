function [N_rd] = buck_res(L, A, E, I, f_y, alpha)
%BUCKLING RESISTANCE
%   This function uses the length(L), the area(A), the elasticity
%   modulus(E), the moment of inertia(I), the yield resistance(f_y) and the
%   parameter of the buckling curve(alpha) to compute the buckling
%   resistance of the member.

L_cr = 1 .* L;  i = sqrt(I ./ A);

lambda1 = pi .* sqrt(E ./ f_y);
lambda = L_cr ./ (i .* lambda1);
Fi = 0.5 .* (1 + alpha .* (lambda - 0.2) + lambda .^ 2);
x = 1 ./ (Fi + sqrt(Fi .^ 2 - lambda .^ 2));    x = min(x, 1);

N_rd = x .* f_y .* A .* 10 .^ 3;

end

