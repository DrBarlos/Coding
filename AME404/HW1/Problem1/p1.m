%{
HW#1 - Problem 1
AME 404
Carlos A. Sanchez
Cylindrical Tank, Fluid Quantities
%}

%% Setup
clear, clc;
t_span = [0,3600];
Q_in = [0.001, 0.002, 0.003];
g = 9.81;
C_d = 0.8;
t = [];
h = [];
h_0 = 0; 
d = 0.025;
A_d = 1/4 * d^2;
figure(1)

%% Plot Creation
for i = 1:length(Q_in)
    % Calculations
    [t,h] = ode45(@odefun,t_span,h_0,[],Q_in(i));
    
    % Printing
    plot(t,h), hold on
end
xlabel('Time(s)')
ylabel('Height(m)')
lgd = legend({'0.001', '0.002', '0.003'},'Orientation','vertical', 'Location', 'northwest');
title(lgd,'Q_{in} (m^3 / second) =')
grid on
grid minor

%% Steady State Determination
t_span = [0,1e7];
for i = 1:length(Q_in)
    % Calculations
    [t,h] = ode45(@odefun,t_span,h_0,[],Q_in(i));
    h_num = h(end,1);
    h_infty = (1/(2*g))*( Q_in(i) / (C_d * A_d))^2;
    error_rel = abs(h_num - h_infty) / (h_infty);
    
    % Printing
    fprintf('The steady state height for an inflow rate of %.3f (m^3 / s) is:\n', Q_in(i));
    fprintf('Numerical: %f (m)\n', h_num);
    fprintf('Analytical:%f (m)\n', h_infty);
    fprintf('Relative Error:%f (m)\n', error_rel);
    fprintf('--------------------------------------------------------\n', error_rel)
end