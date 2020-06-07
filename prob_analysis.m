%% =======================ADD FOLDER TO PATH===============================

addpath( ...
'D:/jkour/Documents/Σχολή/4ο έτος/Εαρινό εξάμηνο/Αξιοπιστία και διακινδύνευση/Εργασία εξαμήνου/Προγραμματιμός');

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

prob_model(wind)                % We choose Gumbel distribution.

%% =================CALCULATE EXPECTED WIND SPEED==========================

pd = fitdist(wind, 'ExtremeValue');

T = [25; 50; 75; 100; 150];
p = 1 ./ T; p = 1 - p;

wind_e = icdf(pd, p);

%% ========================================================================

