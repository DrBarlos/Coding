%% SemiTheoretical Plotter
% Calculates semi theoretical model plot and comparison with measured time traces
%{
Assumes that 
t_mat is time matrix
V_mat is voltage matrix
%}

%% Variable Setup
zeta = input('Value of zeta: '); % Asks user for zeta values
w0 = input('Value of undamped natural frequency: '); % Asks user for undampened natural frequency

%% Calculations
[max_V,i] = max(V_mat); % Finds max peak of curve and returns value with index
V_mod = V_mat(i:end,1); % Reduces time matrix such that max is starting point
t_mod = t_mat(i:end,1); % Reduces time matrix associated with V_matrix points
t_mod1 = t_mod - min(t_mod); % Reduces time matrix by time found at max,such that max point starts at zero

t_theo = 0:0.001:max(t_mod1);
A = max(V_mat); % Specifies amplitude using 
wd = w0 * sqrt(1 - zeta^2); % Calculates dampened natural frequency
V_theo = A .* exp(- zeta * w0 * t_theo) .* cos(wd * t_theo); % Uses solution to undampened case to generate curve

%% Plotting
figure
hold on
plot(t_theo, V_theo, 'g-.') % Plots theoretical Model
plot(t_mod1,V_mod,'blue-') % Plots Measured Curve

xlabel('Time (s)')
ylabel('Output Voltage (V)')
axis tight

legend('Theoretical', 'Measured Curve', 'Location', 'northeast','Orientation','horizontal')