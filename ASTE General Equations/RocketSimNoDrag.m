function [ Vb, hmax ] = RocketSimNoDrag( M0, Mp, Isp, tb )
%ROCKETSIMWITHDRAG Simulate vertical flight of single-stage rocket
%vehicle, assuming constant gravity 
%SI units used
%Atmospheric drag is modeled with constant drag coeff Cd
%assuming frontal area Af
%Equations of motion are finite-differenced
%Vb: Burnout speed in m/s
%hmax: Apogee altitude in m

Cd = 0.27; % Drag Coefficient
a = 1.2; % Coeff a
b = 2.9e-5 % Coeff b
Af = 0.032; % Frontal Area

muE = 3.986e14; % use meters
R0 = 6378e3;
ge = muE / R0^2;

Mb = M0 - Mp; % Burnout mass
ueq = Isp*ge; % Equiv. exhaust vel.
mdot = Mp / tb; % Mass flow rate

dt = 0.01; % Timestep for simulation

% Initial conditions:
h = 0;
V = 0;
M = M0;

% Ascent under power, changing every dt
while M > Mb
  dM = mdot * dt;
  M = M - dM;
  dV = dM*ueq/M - ge*dt - ((2*dM)/(dt*Cd*Af*0.5*a*exp(-(b*h^1.15))));
  V = V + dV;
  h = h + V*dt;
end

Vb = V;

% Coast to apogee, changing every dt
while V > 0
  dV = -ge*dt;
  V = V + dV;
  h = h + V*dt;
end

hmax = h;




