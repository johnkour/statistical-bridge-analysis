function [hist, cdf] = Empirical_Data(data, f)
%VISUALIZATION OF THE EMPIRICAL DATA
%   This function gets the empirical data as a vector (data) and the index 
%   of the figures(f) and plots and returns (as objects) their histogram 
%   and CDF and the index of the figures(f).

m = length(data);
n_bins = round(1 + 3.3 .* log10(m));

[N, EDGES] = histcounts(data, n_bins);

figure(f);
hist = histogram(data, n_bins);
xlabel('maximum anual average wind speed(km/h)');
ylabel("Observations' frequency");
f = f + 1;

figure(f);
cdf = cdfplot(data);
grid on;
title('');
xlabel('maximum anual average wind speed(km/h)');
ylabel('Fraction of observations');
legend('Empirical CDF', 'Location', 'best');

end

