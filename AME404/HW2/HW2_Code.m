%{
HW#1 - Problem 2
AME 404
Carlos A. Sanchez
Nonlinear Spring Oscillator
%}

%% Setup
clear, clc;
t_span = [0 300];
x_null = [0 0];
omega = [0.5, 1.24, 1.25, 2]; 

%% Initialization
figure(1) 
xlabel('Time (t)')
ylabel('Extension Length (x)')

%% Calculations
for i = 1:length(omega)
     [t, x] = ode45(@odefun, t_span, x_null,[], omega(i));
     subplot(2,2,i)
     plot(t,x(:,1))
     ylabel('Extension Displacement (x)'), xlabel('Time (t)');
end