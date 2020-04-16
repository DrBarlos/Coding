%% Mean Free Path Calculation 
%{
Carlos A Sanchez
August 30, 2018
%}

%% Preliminary Setup
altRange = [100:100:1000]; %in km
sigmaCCS = 10e-22; % in m^squared
T = 1000; % in K
avgMolecularMass = 1.66e-27 * 10; %in kg

%% Calculations
n0 = atmosphericDensity(altRange) / avgMolecularMass;
divones = ones(1,length(altRange));
meanFreePath = divones ./(sqrt(2) * sigmaCCS * n0);

%% Plotting
figure
semilogy(altRange,meanFreePath)
xlabel('Altitude (km)')
ylabel('Mean Free Path (m)')