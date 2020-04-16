%{
HW#1 - Problem 2
AME 404
Carlos A. Sanchez
Spherical Tank, Stiff Problem
%}

%% Setup
clear, clc;
t_span = [0,3600];
Q_in = [0.01, 0.02, 0.03];
R = 2;
t = [];
h = [];
h_0 = 1e-6; 
figure(1)

%% Plot Creation
for i = 1:length(Q_in)
    % Calculations
    [t,h] = ode15s(@odefun,t_span,h_0,[],Q_in(i));
    % Printing
    plot(t,h), hold on
end
xlabel('Time(s)')
ylabel('Height(m)')
lgd = legend({'0.01', '0.02', '0.03'},'Orientation','vertical', 'Location', 'northwest');
title(lgd,'Q_{in} (m^3 / second) =')
grid on
grid minor

%% Steady State Determination
t_span = [0,4000];
for i = 1:length(Q_in)
    % Calculations
    [t,h] = ode45(@odefun,t_span,h_0,[],Q_in(i));
    for k = 1:length(h)
        h_ins = h(k);
        if h_ins > 2*R
            t_num = t(k,1);
            break
        end
    end
    t_max = (4 * pi * R^3)/ (3 * Q_in(i));
    error_abs = abs(t_num - t_max) / (t_max);
    
    % Printing
    fprintf('The steady state time for an inflow rate of %.3f (m^3 / s) is:\n', Q_in(i));
    fprintf('Numerical: %f (s)\n', t_num);
    fprintf('Analytical:%f (s)\n', t_max);
    fprintf('Absolute Error:%f (s)\n', error_abs);
    fprintf('--------------------------------------------------------\n', error_abs)
end