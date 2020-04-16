%% JPP Processing
%{
------------------
by Carlos A. Sanchez and Daniel Silva

This code processes the data collected in lab to create boiling temperature
over molality plots, using the measured experimental values to create a
semi-theoretical plot. 
%}
%% Setup
V = ones(1,1); 
del_V = ones(1,1);

%% Input Data Lists
Flder = 'C:\Users\Carlos\Documents\MATLAB\Mechops\JPP\Data';
D = dir(fullfile(Flder,'*.xlsx')); % Collects directory of files

for i = 1:numel(D)
    currentFile  = D(i).name;
    voltage_arr = xlsread(fullfile(Flder,currentFile),'C3:C102'); % Extracts voltage data from files
    V_i  = mean(voltage_arr); % 
    del_V_i = std(voltage_arr);
    V(i,1) = V_i;
    del_V(i,1) = del_V_i;
end

%% Preliminary Constants
% Properties of Water
rho = 947.61; % in kg/m^3
del_H_vap = 40660; % in J / kg
T_b = 373.17; % in K
M_w = .0180153; % in kg/mol

% Properties of Salt
M_salt = 58.443; % in g/mol 
i = 2; % van't Hoff factor

% Measurement Errors
del_m = 1; % in g
del_m_w = 10; % in g

% Ideal Gas
R = 8.314; % in J/(mol * K);

%% Manual Data Input (
% Mass array must be of same size as number of data lists
m = [0,12,35,58,82,116]; % mass of salt for each trial in g
m_w = .190; % mass of water in beaker in kg

%% Calculations
% Voltage to Temperature
T = 115.405 * V + ones(length(V),1) * 11.8019;
dif_T = T - T(1);

% Molality
N = m / M_salt; %num of moles of salt
b = N / m_w; % Molality of solution

% Theoretical 
% + Ebullioscopic constant
k_theo = R * M_w * (273.15 + T(1)) ^ 2 / del_H_vap; % Calculates semitheoretical value of ebulliscopic constant
b_theo = 0:0.1:11;
del_T_theo = i * k_theo * b_theo; % Calculates expected changes in temperature

% Experimental
% +Molality Error
del_b = ones(1,1);
% Calculate error individually for each mass data point
for j = 1:numel(m)
    del_b(j,1) = sqrt( (del_m * 1 / (m_w * M_salt * 1000) )^2 + ( del_m_w * m(j) / (m_w^2 * M_salt * 1000))^2);
end

% +Difference in Temperature Error
del_dif_T = i * k_theo * del_b;
%% Plotting
figure(1)
hold on

errorbar(b,dif_T,del_dif_T, del_dif_T,del_b,del_b,'or')
plot(b_theo,del_T_theo,'-.k')

xlabel('Molality ($\frac{mol}{kg}$)','Interpreter','latex')
ylabel('$\Delta T_b$','Interpreter','latex')
legend({'Experimental','Theoretical'},'Orientation','horizontal','Location','north')

axis auto