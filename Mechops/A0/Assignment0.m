%% Assignment 0 (A0): Hello {Graphical} World
% Carlos A. Sanchez

%% Data Import and Preliminary Analysis Setup
clc,clear all, close all;
dataOfTemps = importdata('temperature_dataFa18.txt'); % Uses default settings to import data as structure array 

timestampArr = (dataOfTemps.data(:,1))'; % Extracts and transposes time data from structure into row vector 
tempData = (dataOfTemps.data(:,2))'; % Same as above except for time

%% Calculations
avgTemp = mean(tempData); % Calculates the average temperature
dataStd = std(tempData); % Calculates standard deviation 
plusOneStd = avgTemp + dataStd; % Calculates one std above mean
minusOneStd = avgTemp - dataStd; % Calculates one std below mean
dummyArr = ones(1,length(timestampArr)); % Creates dummy array to plot straight lines


%% Plotting
figure('Name','Temperature vs. Time') % Creates figure window
hold on % Allows multiple figure elements to be drawn on the same figure window

scatter(timestampArr, tempData) % Creates scatterplot of data

plot(timestampArr, avgTemp*dummyArr, 'b') % Draws average temp line on figure
plot(timestampArr, plusOneStd * dummyArr, '-- b') % Draws 1 std above avg line
plot(timestampArr, minusOneStd * dummyArr, '-- b') % Draws 1 std below avg line

legend({'$$T_i$$', '$$T_{avg}$$', '$$T_{avg}\pm \sigma$$'}, 'Interpreter', 'latex')
xlabel('$$t[s]$$','Interpreter','latex')
ylabel('$$T[K]$$','Interpreter','latex')
title('Temperature vs. Time')

axis fill