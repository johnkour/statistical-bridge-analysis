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

% prob_model(wind)                % We choose Gumbel distribution.

%% =================CALCULATE EXPECTED WIND SPEED==========================

pd = fitdist(wind, 'ExtremeValue');

T = [25; 50; 75; 100; 150];
p = 1 ./ T; p = 1 - p;

v_ref = icdf(pd, p);

%% ============================WIND LOAD===================================

c_p_net = 0.55;
w_e = wind_load(v_ref,c_p_net);      % Wind load in kPa.

L = 4;                      % Length of each piece of the bridge's roof.
h = 2;                      % Heigth of the roof of the truss.
b = 6;                      % Width each piece of the bridge's roof.
A_b = b .* L;               % Area each piece of the bridge's roof.

%% =====================PREPARE LOADS FOR ANALYSIS=========================

w_e = w_e .* b;             % Distributed wind load on the roof(kN/m).

g = 0.35;                   % Permanent loads of the truss.

A = 2570 ./ 10 .^ 6;        % Area of every CHS in meters squared.
E = 200 .* 10 .^ 6;         % Elasticity modulus of every CHS.

q = g + w_e;

%% ==================CALCULATE OPTIMA OF THE AXIAL FORCES==================

N_min = zeros(size(q));
N_max = N_min;
for i = 1:length(q)
    [N_min(i), N_max(i)] = thema(q(i), L, h, E, A);
end

%% =====================STRENGTH OF EACH MEMBER============================

f_y = 355;                      % Mpa
params(1) = 1.15 .* f_y;        % Mean.
params(2) = 0.35 .* params(1);  % Standard deviation

pd = makedist('Normal', 'mu', params(1), 'sigma', params(2));

%% ========================================================================

