function [ Vb, hmax ] = RocketSimWithDrag( M0, Mp, Isp, tb, Cd, Af, DoDrag )
%ROCKETSIMWITHDRAG Simulate vertical flight of single-stage rocket
%vehicle, assuming constant gravity 
%SI units used
%Atmospheric drag is modeled with constant drag coeff Cd
%assuming frontal area Af
%Equations of motion are finite-differenced
%Vb: Burnout speed in m/s
%hmax: Apogee altitude in m

if nargin < 7
    DoDrag = 1
end

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

% Parameters in curve fit for atmospheric density variation
a = 1.2;
b = 2.9e-5;

% Ascent under power
while M > Mb
  dM = -mdot * dt;
  dV = -dM*ueq/M - ge*dt;
  if DoDrag
    rho = a * exp( -b*h^1.15 ); % air density
    Pd = rho * V^2 / 2; % dynamic pressure
    dV = dV - (Cd*Af*Pd*dt)/M;
  end
  dh = V*dt;
  M = M + dM;
  V = V + dV;
  h = h + dh;
  
end
disp( 'Finished motor burn' );

Vb = V;

% Coast to apogee
while V > 0
  h = h + V*dt;
  V = V - ge*dt;
  if DoDrag
    rho = a * exp( -b*h^1.15 );
    Pd = rho * V^2 / 2; % dynamic pressure
    V = V - (Cd*Af*Pd/Mb)*dt;
  end  
end

hmax = h;




