%% Problem 1
% Parameters
% Define first round of calc
global M alt u0 xu xa zu za zq zd mu ma mad mq md
% At ground
M = 0.25;
alt = 0;
u0 = 85.06;
xu = -0.0282;
xa = 0.0415;
zu = -0.212;
za = -44.09;
zq = -3.17;
zd = -4.13;
mu = 0;
ma = -0.530;
mad =  -0.0658;
mq = -0.428;
md = -0.563;

% Setups
t_span = [0 200];
x_null = [0 0 0 0 0];
[t, x] = ode45(@odefun, t_span, x_null)


