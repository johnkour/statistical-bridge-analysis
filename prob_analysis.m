%% =======================ADD FOLDER TO PATH===============================

addpath(genpath(...
'D:/jkour/Documents/Σχολή/4ο έτος/Εαρινό εξάμηνο/Αξιοπιστία και διακινδύνευση/Εργασία εξαμήνου/Προγραμματιμός'));

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

m = length(wind);

%% ======================DISTRIBUTION TESTING==============================

% prob_model(wind)

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

%% ========================PART 1 OF TESTING===============================

MC_Prob(:,1) = wind_testing(wind, wind_distr, T, c_p_net, g, L, h, b, ... 
                            A, E, f_y, I, alpha, N_mc);

%% ================INITIALIZE VALUES FOR TESTING, PART 2===================

snow_distr = 'Lognormal';   % Distribution of snow load.

mean_s = 0.6;               % Mean of snow load(kPa).
sigma_s = 0.4;              % Standard deviation of snow load(kPa).

T = [25; 50; 75; 100; 150]; % Restoration periods for testing, part 2.

N_mc = 1 .* 10 .^6;         % Number of Monte Carlo samples for testing, p2

%% ========================PART 2 OF TESTING===============================

MC_Prob(:,2) = snow_testing(snow_distr, mean_s, sigma_s, T, g, ... 
                            L, h, b, A, E, f_y, I, alpha, N_mc);

%% ========================================================================

