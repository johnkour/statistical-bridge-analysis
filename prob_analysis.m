%% =======================ADD FOLDER TO PATH===============================

addpath(genpath(...
'D:/jkour/Documents/Σχολή/4ο έτος/Εαρινό εξάμηνο/Αξιοπιστία και διακινδύνευση/Εργασία εξαμήνου/Προγραμματιμός'));

clear; close all; clc;
f = 1;          % figure indexing.

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

m = length(wind);

%% ======================DISTRIBUTION TESTING==============================

% f = prob_model(wind)

%% ================INITIALIZE VALUES FOR TESTING, PART 1===================

wind_distr = 'ExtremeValue';% We choose Gumbel distribution.

c_p_net = 0.55;             % Pressure parameter.
g = 0.35;                   % Permanent loads of the truss(kPa).

L = 4;                      % Length of each piece of the bridge's roof.
h = 2;                      % Heigth of the roof of the truss.
b = 6;                      % Width each piece of the bridge's roof.
A_b = b .* L;               % Area each piece of the bridge's roof.

A = 2570 ./ 10 .^ 6;        % Area of every CHS in meters squared.
E = 200 .* 10 .^ 6;         % Elasticity modulus of every CHS.

f_y = 355;                  % Mpa

I = 856 ./ 10 .^ 8;         % Moment of inertia for every element.
alpha = 0.21;               % Parameter for buckling analysis.

T = [25; 50; 75; 100; 150]; % Restoration periods for testing, part 1.

N_mc = 1 .* 10 .^6;         % Number of Monte Carlo samples for testing, p1
M_mc = 10 .^ 2;             % Number of Monte Carlo sim/s for testing, p1

%% ========================PART 1 OF TESTING===============================

fprintf('WIND LOAD ANALYSIS:\n\n')

[MC_Prob(:,1), MC_P_std(:,1)] = wind_testing(wind, wind_distr, T, ... 
                                                c_p_net, g, L, h, b, A, ...
                                                E, f_y, I, alpha, ...
                                                N_mc, M_mc);

%% ================INITIALIZE VALUES FOR TESTING, PART 2===================

snow_distr = 'Lognormal';   % Distribution of snow load.

mean_s = 0.6;               % Mean of snow load(kPa).
sigma_s = 0.4;              % Standard deviation of snow load(kPa).

T = [25; 50; 75; 100; 150]; % Restoration periods for testing, part 2.

N_mc = 1 .* 10 .^6;         % Number of Monte Carlo samples for testing, p2
M_mc = 10 .^ 2;             % Number of Monte Carlo sim/s for testing, p2

%% ========================PART 2 OF TESTING===============================

fprintf('\nSNOW LOAD ANALYSIS:\n\n')

[MC_Prob(:,2), MC_P_std(:,2)] = snow_testing(snow_distr, mean_s, ... 
                                                    sigma_s, T, g, L, ...
                                                    h, b, A, E, f_y, I, ...
                                                    alpha, N_mc, M_mc);

%% ================INITIALIZE VALUES FOR TESTING, PART 3===================

wind_start = 0;     % km/h.
wind_end = 30;      % km/h.

snow_start = 0;     % kPa.
snow_end = 4.5;     % kPa.

points = 1 .* 10 .^ 3;

T = 50;             % years.

%% ========================PART 3 OF TESTING===============================

close all;
[W, S, p, P, f] = join_prob(wind, wind_distr, c_p_net, snow_distr, ...
                mean_s, sigma_s, wind_start, wind_end, snow_start, ...
                snow_end, points, f);


