%% Creates Calibration Curve from Recorded Data (This is Hardcoded for Simplicity)
%% Setup
% General
del_m = 0.01; % in units: g
g = 9.81; % in units: m/s^2

% Bolts
N_bolts = 12;
m_avgBolts = 28.53; % in units: g

% Scale (Basket)
m_s = 7.03; % in units: g 

%% Recorded Values
% Loading
Vl = [0.229, 0.268, 0.307, 0.346, 0.385, 0.421, 0.464, 0.502, 0.542, 0.578, 0.618, 0.657];
del_Vl = [0.005, 0.003, 0.003, 0.003, 0.003, 0.004, 0.003, 0.003, 0.003, 0.005, 0.003, 0.003];

% Unloading 
Vu = [0.657, 0.617, 0.579, 0.542, 0.500, 0.461, 0.423, 0.384, 0.344, 0.304, 0.264, 0.226]; % Unloading Voltages
del_Vu = 0.003 * ones(1,12); % Uncertainties
%% Calculations 
% Loading Case
m_bolts_loading = (m_avgBolts * [1:12] + m_s * ones(1,12))/1000; % Bolt Mass Array
W_bolts_loading = g * m_bolts_loading; %In Units: N
% Unloading Case
W_bolts_unloading = fliplr(W_bolts_loading); % Bolt Weight Array 

% Bolt Mass Uncertainty 
del_mbolt = del_m * ones(1,12);
del_Wbolt = g / 1000 * del_mbolt; 

% Linear Regression
V_all = [Vl,Vu];
W_bolts_all = [W_bolts_loading, W_bolts_unloading];
linreg = fitlm(W_bolts_all, V_all) %fits a linear model which returns relevant values in command line

%% Plotting
figure('Name', 'Calibration Curve')
hold on

% Plotting Least Squares Regression
p1 = plot(linreg)
title('')

% Loading Curve
data1 = errorbar(W_bolts_loading, Vl, del_Wbolt, del_Wbolt, del_Vl, del_Vl, 'sg','MarkerSize',5,...
    'MarkerEdgeColor','g','MarkerFaceColor','g'); 

% Unloading Curve
data2 = errorbar(W_bolts_unloading, Vu, del_Wbolt, del_Wbolt, del_Vu, del_Vu, 'ob','MarkerSize',5,...
    'MarkerEdgeColor','b','MarkerFaceColor','b');
xlabel('Weight (N)');
ylabel('Output Voltage (V)');

legend([data1, data2], 'Loading', 'Unloading','Location','north','Orientation','horizontal')
