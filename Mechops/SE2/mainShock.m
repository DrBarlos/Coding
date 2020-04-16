%% Main Shock Tube Script
%{
by Carlos A. Sanchez
--------------------
This script utilizes the various custom functions to plot relations
--------------------
%}
%% Options
extractData = 0; % Only turn on when needing to extract data (Takes a while!)

%% Data Extraction 
% Uses custom function to extract data from Excel files
if extractData
data1 = shockDataExtract('ST_Mon');
data2 = shockDataExtract('ST_Tue');
data3 = shockDataExtract('ST_Wed');
data4 = shockDataExtract('ST_Thu');
end

%% Calculations
gamma = 1.398; % unitless
R = 287.05; % in 
d = 1; % in m
del_d = 0.01; % in m
del_t = 2e-5; % in s
del_T = 0.1 % in C or K 

% Array Setup
p4p1 = ones(1,1);
M_s = ones(1,1);
M_s_exp = ones(1,1);
del_M_s = ones(1,1);
M_r_exp = ones(1,1);
del_v_Sent = ones(1,1);
del_v_Reflected = ones(1,1);

% Loop through structures
for i = 1:numel(data1)
    % Calculates p4/p1
    ratio_p4p1 = data1(i).pressureP4 / (data1(i).pressureP4 - data1(i).pressureDP);
    p4p1(i,1) = ratio_p4p1; % Stores p4/p1 value in array
    
    % Experimental Values
    a_i = sqrt(gamma * R * (data1(i).temperature + 273.15 )); %Calculate speed of sound for given temperature
    v_s = 1 / data1(i).timeSent; % Calculates speed of sent shock
    M_s_exp(i,1) = v_s / a_i; % Calculates Mach number of sent shock. 
       
    % Theoretical Values 
    shockFunc1 = @(x) x * (1 - (gamma - 1)*(x-1)/sqrt(2 * gamma * (2 * gamma + (gamma + 1)*(x-1))))^(-2 * gamma /(gamma - 1)) - ratio_p4p1;
    ratio_p2p1 = fzero(shockFunc1,2);
    M_S_temp = sqrt((gamma + 1) * (ratio_p2p1 - 1)/(2 * gamma) + 1);
    M_s(i,1) = M_S_temp;
    
    % Calculated (But uses p2/p1 vals)
    v_r = 1/data1(i).timeReflected; % Calculates speed of reflected shock
    u_p = (a_i / gamma)*(ratio_p2p1 - 1)*((2*gamma /(gamma + 1))/(ratio_p2p1 + ((gamma-1)/(gamma + 1))))^0.5;
    M_r_exp(i,1) = (v_r + u_p)/ a_i;
    
    shockFunc2 = @(x) ((M_S_temp)/(M_S_temp^2 - 1)) * sqrt(1 + (2 * (gamma - 1)/(gamma + 1)^2 ) * (M_S_temp^2 - 1 )*(gamma + (1/M_S_temp^2))) - (x/(x^2-1));
    ratio_p2p1 = fzero(shockFunc2,1.1);
    M_r(i,1) = sqrt((gamma + 1) * (ratio_p2p1 - 1)/(2 * gamma) + 1);
end

const = numel(data1);
for i = 1:numel(data2)
    % Calculates p4/p1
    ratio_p4p1 = data2(i).pressureP4 / (data2(i).pressureP4 - data2(i).pressureDP);
    p4p1(i+const,1) = ratio_p4p1; % Stores p4/p1 value in array
    
    % Experimental Values
    a_i = sqrt(gamma * R * (data1(i).temperature + 273.15 )); %Calculate speed of sound for given temperature
    v_s = 1 / data1(i).timeSent; % Calculates speed of sent shock
    M_s_exp(i+const,1) = v_s / a_i; % Calculates Mach number of sent shock. 
       
    % Theoretical Values 
    shockFunc1 = @(x) x * (1 - (gamma - 1)*(x-1)/sqrt(2 * gamma * (2 * gamma + (gamma + 1)*(x-1))))^(-2 * gamma /(gamma - 1)) - ratio_p4p1;
    ratio_p2p1 = fzero(shockFunc1,2);
    M_S_temp = sqrt((gamma + 1) * (ratio_p2p1 - 1)/(2 * gamma) + 1);
    M_s(i+const,1) = M_S_temp;
    
    % Calculated (But uses p2/p1 vals)
    v_r = 1/data1(i).timeReflected; % Calculates speed of reflected shock
    u_p = (a_i / gamma)*(ratio_p2p1 - 1)*((2*gamma /(gamma + 1))/(ratio_p2p1 + ((gamma-1)/(gamma + 1))))^0.5;
    M_r_exp(i+const,1) = (v_r + u_p)/ a_i;
    
    shockFunc2 = @(x) ((M_S_temp)/(M_S_temp^2 - 1)) * sqrt(1 + (2 * (gamma - 1)/(gamma + 1)^2 ) * (M_S_temp^2 - 1 )*(gamma + (1/M_S_temp^2))) - (x/(x^2-1));
    ratio_p2p1 = fzero(shockFunc2,1.1);
    M_r(i+const,1) = sqrt((gamma + 1) * (ratio_p2p1 - 1)/(2 * gamma) + 1);
end

const = numel(data1) + numel(data2);
for i = 1:numel(data3)
    % Calculates p4/p1
    ratio_p4p1 = data3(i).pressureP4 / (data3(i).pressureP4 - data3(i).pressureDP);
    p4p1(i+const,1) = ratio_p4p1; % Stores p4/p1 value in array
    
    % Experimental Values
    a_i = sqrt(gamma * R * (data3(i).temperature + 273.15 )); %Calculate speed of sound for given temperature
    v_s = 1 / data3(i).timeSent; % Calculates speed of sent shock
    M_s_exp(i+const,1) = v_s / a_i; % Calculates Mach number of sent shock. 
       
    % Theoretical Values 
    shockFunc1 = @(x) x * (1 - (gamma - 1)*(x-1)/sqrt(2 * gamma * (2 * gamma + (gamma + 1)*(x-1))))^(-2 * gamma /(gamma - 1)) - ratio_p4p1;
    ratio_p2p1 = fzero(shockFunc1,2);
    M_S_temp = sqrt((gamma + 1) * (ratio_p2p1 - 1)/(2 * gamma) + 1);
    M_s(i+const,1) = M_S_temp;
    
    % Calculated (But uses p2/p1 vals)
    v_r = 1/data3(i).timeReflected; % Calculates speed of reflected shock
    u_p = (a_i / gamma)*(ratio_p2p1 - 1)*((2*gamma /(gamma + 1))/(ratio_p2p1 + ((gamma-1)/(gamma + 1))))^0.5;
    M_r_exp(i+const,1) = (v_r + u_p)/ a_i;
    
    shockFunc2 = @(x) ((M_S_temp)/(M_S_temp^2 - 1)) * sqrt(1 + (2 * (gamma - 1)/(gamma + 1)^2 ) * (M_S_temp^2 - 1 )*(gamma + (1/M_S_temp^2))) - (x/(x^2-1));
    ratio_p2p1 = fzero(shockFunc2,1.1);
    M_r(i+const,1) = sqrt((gamma + 1) * (ratio_p2p1 - 1)/(2 * gamma) + 1);
end

const = numel(data1) + numel(data2)+ numel(data3);
for i = 1:numel(data4)
    % Calculates p4/p1
    ratio_p4p1 = data4(i).pressureP4 / (data4(i).pressureP4 - data4(i).pressureDP);
    p4p1(i+const,1) = ratio_p4p1; % Stores p4/p1 value in array
    
    % Experimental Values
    a_i = sqrt(gamma * R * (data4(i).temperature + 273.15 )); %Calculate speed of sound for given temperature
    v_s = 1 / data4(i).timeSent; % Calculates speed of sent shock
    M_s_exp(i+const,1) = v_s / a_i; % Calculates Mach number of sent shock. 
       
    % Theoretical Values 
    shockFunc1 = @(x) x * (1 - (gamma - 1)*(x-1)/sqrt(2 * gamma * (2 * gamma + (gamma + 1)*(x-1))))^(-2 * gamma /(gamma - 1)) - ratio_p4p1;
    ratio_p2p1 = fzero(shockFunc1,2);
    M_S_temp = sqrt((gamma + 1) * (ratio_p2p1 - 1)/(2 * gamma) + 1);
    M_s(i+const,1) = M_S_temp;
    
    % Calculated (But uses p2/p1 vals)
    v_r = 1/data4(i).timeReflected; % Calculates speed of reflected shock
    u_p = (a_i / gamma)*(ratio_p2p1 - 1)*((2*gamma /(gamma + 1))/(ratio_p2p1 + ((gamma-1)/(gamma + 1))))^0.5;
    M_r_exp(i+const,1) = (v_r + u_p)/ a_i;
    
    shockFunc2 = @(x) ((M_S_temp)/(M_S_temp^2 - 1)) * sqrt(1 + (2 * (gamma - 1)/(gamma + 1)^2 ) * (M_S_temp^2 - 1 )*(gamma + (1/M_S_temp^2))) - (x/(x^2-1));
    ratio_p2p1 = fzero(shockFunc2,1.1);
    M_r(i+const,1) = sqrt((gamma + 1) * (ratio_p2p1 - 1)/(2 * gamma) + 1);
end

%% Plotting
% Plots sent shock experimental data vs theoretical predictions 
figure(1)
hold on
scatter(p4p1, M_s,'r');
scatter(p4p1, M_s_exp,'b')
xlabel('Pressure Ratio (p_4/p_1)')
ylabel('Mach Number (M_s)')

legend({'M_{theo}','M_{exp}'},'Location','south','Orientation','horizontal')
hold off

% Plots reflected shock experimental data vs theoretical predictions
figure(2)
hold on
scatter(p4p1, M_r,'g');
scatter(p4p1, M_r_exp,'m')
axis auto
xlabel('Pressure Ratio (p_4/p_1)')
ylabel('Mach Number (M_s)')
hold off
legend({'M_{theo}','M_{exp}'},'Location','south','Orientation','horizontal')

