%{
HW 5 
Carlos A Sanchez
ASTE 404
Shooting Technique
%}

clear all;

%% Setup
% Known Vals
clear all;
y_0 = 0;

% Constants
q = 1e5;
EI = 1.4e7;
L = 10;
x_span = [0 10];

%Parameters and Function Values
Bs = 0; % Boundary Target Value
dydx_i = 0; % Initial Guess
del_lambda = 0.05; % Guess step increment
tol = 1e-6; % Error Tolerance
option = odeset('RelTol', tol);

%% Shooting Algorithm

% First Guess
lambda0 = dydx_i; 
[x, y] = ode45(@odefun,x_span, [y_0, lambda0],option);
B0 = y(end,1);
lambda1 = lambda0 + del_lambda;

% Iteration
iter = 0;
while abs(B0) > tol
    % Integrating equation
    dydx_0 = lambda1;
    [x, y] = ode45(@odefun,x_span,[y_0,lambda1],option);
    B1 = y(end,1);
    
    % Setting up for next iteration
    guess = lambda1 - B1 / (B1 - B0) * (lambda1 - lambda0);
    lambda0 = lambda1;
    lambda1 = guess;
    B0 = B1;
    iter = iter + 1;
    fprintf('Iteration: %d, dy/dx: %g\n',iter, lambda1)
end

%% Linear Model
x1 = 0:0.1:10;
y2 = - (q * L^4)/(24 * EI) * ( (x1 ./ L).^4 - 2 *(x1 ./ L).^3 + (x1 ./ L));

%% Plotting
figure(1)
plot(x,y(:,1)),hold on
plot(x1,y2)
legend({'Non-Linear','Linear Approximation'},'Location','northwest','Orientation','horizontal')
xlabel('x (m)'), ylabel('y (m)');