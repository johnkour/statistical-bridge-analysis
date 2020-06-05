%% =======================ADD FOLDER TO PATH===============================

addpath('D:/jkour/Documents/Σχολή/4ο έτος/Εαρινό εξάμηνο/Αξιοπιστία και διακινδύνευση/Εργασία εξαμήνου/Προγραμματιμός');
clear; close all; clc;

%% ===================IMPORT MATRICES FROM CSVs============================

wind = readmatrix('values.csv');
% dates = readmatrix('keys.csv');

%% =================SCALE MATRICES FROM MONTHS TO YEARS====================

years = size(wind, 1) / 12;
wind = reshape(wind, 12, years);
wind = max(wind);
wind = transpose(wind);

%% ====================CALCULATE WIND SPEED LOCALY=========================

z_ref = 10;                      % Provided by meteosearch for Megalopoli.
z = 10;                          % Provided by the exercise.
wind = w_speed(z, z_ref, wind);

%% =======================EMPIRICAL DISTRIBUTION===========================

m = length(wind);

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

%% =======================GUMBEL DISTRIBUTION==============================

pd = fitdist(wind, 'GeneralizedExtremeValue');

f(1,:) = pdf(pd, y);

figure(1)
hold on;
plot(y, f(1,:), 'Color', [0.4660 0.6740 0.1880]);
legend('Histogram', 'Gumbel');
hold off;

F(1,:) = cdf(pd, y);

figure(2)
hold on;
plot(y, F(1,:), 'Color', [0.4660 0.6740 0.1880]);
legend('Empirical', 'Gumbel');
hold off;

figure(3)
subplot(3, 3, 1); qqplot(wind, pd); title('Gumbel');

figure(4)
subplot(2, 3, 1); probplot(pd, wind); title('Gumbel');


%% =======================EXPONENTIAL DISTRIBUTION=========================

[param, ~] = expfit(wind);

f(2,:) = exppdf(y, param);

figure(1)
hold on;
plot(y, f(2,:), 'y');
legend('Histogram', 'Gumbel', 'Exponential');
hold off;

F(2,:) = expcdf(y, mean_w);

figure(2)
hold on;
plot(y, F(2,:), 'y');
legend('Empirical', 'Gumbel', 'Exponential');
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
legend('Histogram', 'Gumbel', 'Exponential', 'Lognormal');
hold off;

F(3,:) = logncdf(y, params(1), params(2));

figure(2)
hold on;
plot(y, F(3,:), 'g');
legend('Empirical', 'Gumbel', 'Exponential', 'Lognormal');
hold off;

figure(3)
subplot(3, 3, 3); qqplot(wind, pd); title('Lognormal');

%% =======================NORMAL DISTRIBUTION==============================

pd = fitdist(wind, 'Normal');

f(4,:) = pdf(pd, y);

figure(1)
hold on;
plot(y, f(4,:), 'm');
legend('Histogram', 'Gumbel', 'Exponential', 'Lognormal', 'Normal');
hold off;

F(4,:) = cdf(pd, y);

figure(2)
hold on;
plot(y, F(4,:), 'm');
legend('Empirical', 'Gumbel', 'Exponential', 'Lognormal', 'Normal');
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
legend('Histogram', 'Gumbel', 'Exponential', 'Lognormal', 'Normal', ...
                 'Weibull');
hold off;

F(5,:) = wblcdf(y, params(1), params(2));

figure(2)
hold on;
plot(y, F(5,:), 'Color', [0.3010 0.7450 0.9330]);
legend('Empirical', 'Gumbel', 'Exponential', 'Lognormal', 'Normal', ...
                'Weibull');
hold off;

pd = fitdist(wind, 'Weibull');

figure(3)
subplot(3, 3, 5); qqplot(wind, pd); title('Weibull');

figure(4)
subplot(2, 3, 3); probplot(pd, wind); title('Weibull');

%% =========================GAMMA DISTRIBUTION=============================

[params,~] = gamfit(wind);

f(6,:) = gampdf(y, params(1), params(2));

figure(1)
hold on;
plot(y, f(6,:), 'k');
legend('Histogram', 'Gumbel', 'Exponential', 'Lognormal', 'Normal', ...
                'Weibull', 'Gamma');
hold off;

F(6,:) = gamcdf(y, params(1), params(2));

figure(2)
hold on;
plot(y, F(6,:), 'k');
legend('Empirical', 'Gumbel', 'Exponential', 'Lognormal', 'Normal', ...
                'Weibull', 'Gamma');
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
legend('Histogram', 'Gumbel', 'Exponential', 'Lognormal', 'Normal', ...
                'Weibull', 'Gamma', 'ExtremeValue');
hold off;

F(7,:) = cdf(pd, y);

figure(2)
hold on;
plot(y, F(7,:), 'Color', [0.6350 0.0780 0.1840]);
legend('Empirical', 'Gumbel', 'Exponential', 'Lognormal', 'Normal', ...
                'Weibull', 'Gamma', 'Extreme Value');
hold off;

figure(3)
subplot(3, 3, 7); qqplot(wind, pd); title('Extreme Value');

figure(4)
subplot(2, 3, 5); probplot(pd, wind); title('Extreme Value');

%% ======================HALFNORMAL DISTRIBUTION===========================

pd = fitdist(wind, 'HalfNormal');

f(8,:) = pdf(pd, y);

figure(1)
hold on;
plot(y, f(8,:), 'c');
legend('Histogram', 'Gumbel', 'Exponential', 'Lognormal', 'Normal', ...
                'Weibull', 'Gamma', 'ExtremeValue', 'Half Normal');
hold off;

F(8,:) = cdf(pd, y);

figure(2)
hold on;
plot(y, F(8,:), 'c');
legend('Empirical', 'Gumbel', 'Exponential', 'Lognormal', 'Normal', ...
                'Weibull', 'Gamma', 'ExtremeValue', 'Half Normal');
hold off;

figure(3)
subplot(3, 3, 8); qqplot(wind, pd); title('Half Normal');

%% ======================NAKAGAMI DISTRIBUTION=============================

pd = fitdist(wind, 'Nakagami');

f(9,:) = pdf(pd, y);

figure(1)
hold on;
plot(y, f(9,:), 'r');
legend('Histogram', 'Gumbel', 'Exponential', 'Lognormal', 'Normal', ...
                'Weibull', 'Gamma', 'ExtremeValue', 'HalfNormal', ...
                        'Nakagami');
hold off;

F(9,:) = cdf(pd, y);

figure(2)
hold on;
plot(y, F(9,:), 'r');
legend('Empirical', 'Gumbel', 'Exponential', 'Lognormal', 'Normal', ...
                'Weibull', 'Gamma', 'ExtremeValue', 'HalfNormal', ...
                        'Nakagami');
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
