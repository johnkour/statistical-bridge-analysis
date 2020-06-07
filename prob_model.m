function [] = prob_model(wind)
%PROBABILITY DISTRIBUTION FOR DATA
%   This function tests 9 probability distributions to the data.
%   Distributions:
%                   1)  Generalized Extreme Value(=Types I, II & III comb.)
%                   2)  Exponential
%                   3)  Lognormal
%                   4)  Normal
%                   5)  Weibull
%                   6)  Gamma
%                   7)  Extreme Value(= Type I or Gumbel)
%                   8)  HalfNormal
%                   9)  Nakagami

%% =======================EMPIRICAL DISTRIBUTION===========================

mean_w = mean(wind);
med_wind = median(wind);
s_wind = std(wind);
max_w = max(wind);
min_w = min(wind);

[hist, ECDF] = Empirical_Data(wind);

hist.FaceColor = '#EDB120';
% hist.Normalization = 'pdf';
hist.Normalization = 'probability';
hist.NumBins = 5;
ECDF.Color = '#EDB120';

y = linspace(10, 40, 1000);

%% ================GENERALIZED EXTREME VALUE DISTRIBUTION==================

pd = fitdist(wind, 'GeneralizedExtremeValue');

f(1,:) = pdf(pd, y);

figure(1)
hold on;
plot(y, f(1,:), 'Color', [0.4660 0.6740 0.1880]);
legend('Histogram', 'Generalized Extreme Value');
hold off;

F(1,:) = cdf(pd, y);

figure(2)
hold on;
plot(y, F(1,:), 'Color', [0.4660 0.6740 0.1880]);
legend('Empirical', 'Generalized Extreme Value');
hold off;

figure(3)
subplot(3, 3, 1); qqplot(wind, pd); title('Generalized Extreme Value');

figure(4)
subplot(2, 3, 1); probplot(pd, wind); title('Generalized Extreme Value');


%% =======================EXPONENTIAL DISTRIBUTION=========================

[param, ~] = expfit(wind);

f(2,:) = exppdf(y, param);

figure(1)
hold on;
plot(y, f(2,:), 'y');
legend('Histogram', 'Generalized Extreme Value', 'Exponential');
hold off;

F(2,:) = expcdf(y, mean_w);

figure(2)
hold on;
plot(y, F(2,:), 'y');
legend('Empirical', 'Generalized Extreme Value', 'Exponential');
hold off;

pd = fitdist(wind, 'Exponential');

figure(3)
subplot(3, 3, 2); qqplot(wind, pd); title('Exponential');

%% =======================LOGNORMAL DISTRIBUTION===========================

[params, ~] = lognfit(wind);

pd = makedist('Lognormal', 'mu', params(1), 'sigma', params(2));

f(3,:) = pdf(pd,y);

figure(1)
hold on;
plot(y, f(3,:), 'g');
legend('Histogram', 'Generalized Extreme Value', 'Exponential', ...
                'Lognormal');
hold off;

F(3,:) = logncdf(y, params(1), params(2));

figure(2)
hold on;
plot(y, F(3,:), 'g');
legend('Empirical', 'Generalized Extreme Value', 'Exponential', ...
                'Lognormal');
hold off;

figure(3)
subplot(3, 3, 3); qqplot(wind, pd); title('Lognormal');

%% =======================NORMAL DISTRIBUTION==============================

pd = fitdist(wind, 'Normal');

f(4,:) = pdf(pd, y);

figure(1)
hold on;
plot(y, f(4,:), 'm');
legend('Histogram', 'Generalized Extreme Value', 'Exponential', ...
                'Lognormal', 'Normal');
hold off;

F(4,:) = cdf(pd, y);

figure(2)
hold on;
plot(y, F(4,:), 'm');
legend('Empirical', 'Generalized Extreme Value', 'Exponential', ...
                'Lognormal', 'Normal');
hold off;

figure(3)
subplot(3, 3, 4); qqplot(wind, pd); title('Normal');

figure(4)
subplot(2, 3, 2); probplot(pd, wind); title('Normal');

%% ========================WEIBULL DISTRIBUTION============================

[params,~] = wblfit(wind);

f(5,:) = wblpdf(y, params(1), params(2));

figure(1)
hold on;
plot(y, f(5,:), 'Color', [0.3010 0.7450 0.9330]);
legend('Histogram', 'Generalized Extreme Value', 'Exponential', ...
                'Lognormal', 'Normal', 'Weibull');
hold off;

F(5,:) = wblcdf(y, params(1), params(2));

figure(2)
hold on;
plot(y, F(5,:), 'Color', [0.3010 0.7450 0.9330]);
legend('Empirical', 'Generalized Extreme Value', 'Exponential', ... 
                'Lognormal', 'Normal', 'Weibull');
hold off;

pd = fitdist(wind, 'Weibull');

figure(3)
subplot(3, 3, 5); qqplot(wind, pd); title('Weibull');

figure(4)
subplot(2, 3, 3); probplot(pd, wind); title('Weibull');

%------------------------KOLMOGOROV-SMIRNOV TEST---------------------------

[h(1,1), p(1,1), d(1,1), d_crit(1,1)] = kstest(wind, 'CDF', pd);

%---------------------------LILLIEFORS TEST--------------------------------

[h(2,1), p(2,1), d(2,1), d_crit(2,1)] = kstest(wind, 'CDF', pd);

%% =========================GAMMA DISTRIBUTION=============================

[params,~] = gamfit(wind);

f(6,:) = gampdf(y, params(1), params(2));

figure(1)
hold on;
plot(y, f(6,:), 'k');
legend('Histogram', 'Generalized Extreme Value', 'Exponential', ...
                'Lognormal', 'Normal', 'Weibull', 'Gamma');
hold off;

F(6,:) = gamcdf(y, params(1), params(2));

figure(2)
hold on;
plot(y, F(6,:), 'k');
legend('Empirical', 'Generalized Extreme Value', 'Exponential', ...
                'Lognormal', 'Normal', 'Weibull', 'Gamma');
hold off;

pd = fitdist(wind, 'Gamma');

figure(3)
subplot(3, 3, 6); qqplot(wind, pd); title('Gamma');

figure(4)
subplot(2, 3, 4); probplot(pd, wind); title('Gamma');

%% =======================EXTREME VALUE DISTRIBUTION=======================

pd = fitdist(wind, 'ExtremeValue');

f(7,:) = pdf(pd, y);

figure(1)
hold on;
plot(y, f(7,:), 'Color', [0.6350 0.0780 0.1840]);
legend('Histogram', 'Generalized Extreme Value', 'Exponential', ...
                'Lognormal', 'Normal', 'Weibull', 'Gamma', ...
                'Extreme Value');
hold off;

F(7,:) = cdf(pd, y);

figure(2)
hold on;
plot(y, F(7,:), 'Color', [0.6350 0.0780 0.1840]);
legend('Empirical', 'Generalized Extreme Value', 'Exponential', ...
                'Lognormal', 'Normal', 'Weibull', 'Gamma', ...
                'Extreme Value');
hold off;

figure(3)
subplot(3, 3, 7); qqplot(wind, pd); title('Extreme Value');

figure(4)
subplot(2, 3, 5); probplot(pd, wind); title('Extreme Value');

%------------------------KOLMOGOROV-SMIRNOV TEST---------------------------

[h(1,2), p(1,2), d(1,2), d_crit(1,2)] = kstest(wind,'CDF',pd);

%---------------------------LILLIEFORS TEST--------------------------------

[h(2,2), p(2,2), d(2,2), d_crit(2,2)] = kstest(wind,'CDF',pd);

%% ======================HALFNORMAL DISTRIBUTION===========================

pd = fitdist(wind, 'HalfNormal');

f(8,:) = pdf(pd, y);

figure(1)
hold on;
plot(y, f(8,:), 'c');
legend('Histogram', 'Generalized Extreme Value', 'Exponential', ...
                'Lognormal', 'Normal', 'Weibull', 'Gamma', ...
                'Extreme Value', 'Half Normal');
hold off;

F(8,:) = cdf(pd, y);

figure(2)
hold on;
plot(y, F(8,:), 'c');
legend('Empirical', 'Generalized Extreme Value', 'Exponential', ...
                'Lognormal', 'Normal', 'Weibull', 'Gamma', ...
                'Extreme Value', 'Half Normal');
hold off;

figure(3)
subplot(3, 3, 8); qqplot(wind, pd); title('Half Normal');

%% ======================NAKAGAMI DISTRIBUTION=============================

pd = fitdist(wind, 'Nakagami');

f(9,:) = pdf(pd, y);

figure(1)
hold on;
plot(y, f(9,:), 'r');
legend('Histogram', 'Generalized Extreme Value', 'Exponential', ...
                'Lognormal', 'Normal', 'Weibull', 'Gamma', ...
                'Extreme Value', 'HalfNormal', 'Nakagami');
hold off;

F(9,:) = cdf(pd, y);

figure(2)
hold on;
plot(y, F(9,:), 'r');
legend('Empirical', 'Generalized Extreme Value', 'Exponential', ...
                'Lognormal', 'Normal', 'Weibull', 'Gamma', ...
                'Extreme Value', 'HalfNormal', 'Nakagami');
hold off;

figure(3)
subplot(3, 3, 9); qqplot(wind, pd); title('Nakagami');

figure(4)
subplot(2, 3, 6); probplot(pd, wind); title('Nakagami');

%% ==========================PLOT MANAGEMENT===============================

f1 = figure(1);
f2 = figure(2);
f3 = figure(3);
f4 = figure(4);

f1.Name = 'Histogram v PDF';
f2.Name = 'CDFs';
f3.Name = 'Q-Q plots';
f4.Name = 'Probability plots';

saveas(f1, f1.Name, 'jpeg');
saveas(f2, f2.Name, 'jpeg');
saveas(f3, f3.Name, 'jpeg');
saveas(f4, f4.Name, 'jpeg');

if h(1,1) == 0
    disp('Weibull distribution passes K-S test.')
else
    disp("Weibull distribution doesn't pass K-S test.")
end

if h(2,1) == 0
    disp('Weibull distribution passes Lilliefors test.')
else
    disp("Weibull distribution doesn't pass Lilliefors test.")
end

if h(1,2) == 0
    disp('Extreme value distribution passes K-S test.')
else
    disp("Extreme value distribution doesn't pass K-S test.")
end

if h(2,2) == 0
    disp('Extreme value distribution passes Lilliefors test.')
else
    disp("Extreme value distribution doesn't pass Lilliefors test.")
end

end

