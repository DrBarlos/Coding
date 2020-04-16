function [DATA] = shockDataExtract(Flder)
%% Excel Shock File Extractor function
%{
by Carlos A. Sanchez 
March 30th, 2019
------------------------
This function runs through a folder and extracts relevant information,
outputting all this in a structure named DATA.
------------------------
%}

%% Data Processing
% Processing Setup
D = dir(fullfile(Flder,'*.xlsx')); % Collects relevant Excel files in folder

% Data Structure Array
field1 = 'timeSent';             value1 = 1;
field2 = 'timeReflected';        value2 = 1;
field3 = 'pressureP4';           value3 = 1;
field4 = 'pressureDP';           value4 = 1; 
field5 = 'temperature';          value5 = 1; 
DATA = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5);

%% Iteration over Folder
% Run Script for every file in the folder
for i = 1:numel(D)
    currentFile  = D(i).name 
    [DATA(i).timeSent, DATA(i).timeReflected] = ...
    shockPlot(fullfile(Flder,currentFile)); % Calculates t_s and t_r
    DATA(i).pressureP4 = str2num([currentFile([4,5]),'.',currentFile([7,8])]); % in inches of mercury
    DATA(i).pressureDP = str2num([currentFile([13,14]),'.',currentFile([16,17])]); % in inches of mercury
    DATA(i).temperature = str2num([currentFile([21,22]),'.',currentFile([24])]); % in inches of mercury
end
end
