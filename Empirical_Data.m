function [hist, cdf] = Empirical_Data(data)
%VISUALIZATION OF THE EMPIRICAL DATA
%   This function gets the empirical data as a vector (data) and plots and
%   returns (as objects) their histogram and CDF.

m = length(data);
n_bins = round(1 + 3.3 .* log10(m));

[N, EDGES] = histcounts(data, n_bins);

figure(1);
hist = histogram(data, n_bins);
xlabel('maximum anual average wind speed(km/h)');
ylabel("Observations' frequency");

figure(2);
cdf = cdfplot(data);
grid on;
title('');
xlabel('maximum anual average wind speed(km/h)');
ylabel('Fraction of observations');
legend('Empirical CDF', 'Location', 'best');

end

