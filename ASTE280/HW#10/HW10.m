clc; close all; clear all;
%% Setup
Md = 10000; % Dry mass in kg
deltaV = 25000; % Delta V in m/s
isp = 1:1:3000; % Creates specific impulse array in m/s
ueq = 9.81* isp; % Calculates equivalent exhaust velocity in km/s

%% Calculations
R = exp(deltaV./ueq);
F = (R - 1)./ R;

%% Plotting
figure('Name', 'Isp, Mass Ratio, Mass Fraction')

yyaxis left
semilogy(isp,R);
title('Mass Ratio, Mass Fraction, Isp')
xlabel('Isp [s]')
ylabel('Mass Ratio')

yyaxis right
plot(isp,F,'-.')
ylabel('Mass Fraction')
legend('Mass Ratio','Mass Fraction')