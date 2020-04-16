function [ts,tr] = shockPlot(excelFlnm,plotFlag)
%% shockPlot Function
%{
by Carlos A. Sanchez
April 4th, 2019
--------------------
This function extracts ts and tr from relevant signals, and may also create
plots depending on option selected
--------------------
Variable Definitions
Function Arguments
excelFlnm ----- Specifies location of Excel File

Excel File Inputs
tA1  -----  Signal gathered from TOA gauge 1
tA2  -----  Signal gathered from TOA gauge 2
t    -----  Time array

Outputs
ts   -----  Time sent
tr   -----  Time reflected

Check Options
plotFlag ----- Check option to plot data. Beware on using this with large
data sets as it may crash your computer. Credits to the AME341 authors for
inspiring this option :) 

%}
%% Check Options
if nargin < 2
    plotFlag = 0;
end

%% Import data
t = 0:(2*10^-5):0.59998; % Creates time vector
tA1 = xlsread(excelFlnm,'B6:B30005'); % Extracts sensor 1 data
tA2 = xlsread(excelFlnm,'C6:C30005'); % Extracts sensor 2 data

%% Calculations
% Peak Search
[pk1,locs1] = findpeaks(tA1,'MinPeakProminence',0.13,'MinPeakDistance',12, 'NPeaks', 2); % Finds peaks from sensor 1
[pk2,locs2] = findpeaks(tA2,'MinPeakProminence',0.13,'MinPeakDistance',12, 'NPeaks', 2); % Finds peaks from sensor 2

tSensor1 = t(locs1); % Creates sensor 1 peak times array
tSensor2 = t(locs2); % Creates sensor 2 peak times array

%% Plotting
if plotFlag 
figure('Name','Sensor Data')
plot(t,tA1,tSensor1,pk1,'or',t,tA2,tSensor2,pk2,'ob')
xlabel('Time(s)');
ylabel('Amplitude');

x_min_plot = tSensor1(1) - 0.001; % Calculates Lower x bound from peak
x_max_plot = tSensor1(2) + 0.001; % Calculates Upper x bound from peak
axis([x_min_plot x_max_plot -0.05 inf]); % Sets Axis Limits

legend('Sensor 1', 'Sensor 1 Peaks', 'Sensor 2', 'Sensor 2 Peaks','Location','northwest')
end

%% Function Output
ts = tSensor2(1) - tSensor1(1); % Calculates time for sent signal
tr = tSensor1(2) - tSensor2(2); % Calculates time for reflected signal

end

