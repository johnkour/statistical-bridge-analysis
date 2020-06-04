%% =======================ADD FOLDER TO PATH===============================

addpath('D:/jkour/Documents/Ó÷ïëÞ/4ï Ýôïò/Åáñéíü åîÜìçíï/Áîéïðéóôßá êáé äéáêéíäýíåõóç/Åñãáóßá åîáìÞíïõ/Ðñïãñáììáôéìüò');
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

%% =====================FIND OPTIMAL DISTRIBUTION==========================

