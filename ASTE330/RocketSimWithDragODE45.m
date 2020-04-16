function [ Vb, hmax ] = RocketSimWithDrag( M0, Mp, Isp, tb, Cd, Af, constantGravity )
%ROCKETSIMWITHDRAG Simulate vertical flight of single-stage rocket
%vehicle, assuming constant gravity 
%SI units used
%Atmospheric drag is modeled with constant drag coeff Cd
%assuming frontal area Af
%Equations of motion are finite-differenced
%Vb: Burnout speed in m/s
%hmax: Apogee altitude in m

global Mb ueq mdot ge muE R0 CD AF constGrav

if nargin < 7
    constantGravity = 1; % Default to constant gravity
end
constGrav = constantGravity;

CD = Cd;
AF = Af;

muE = 3.986e14; % use meters
R0 = 6378e3;
ge = muE / R0^2;

Mb = M0 - Mp % Burnout mass
ueq = Isp*ge; % Equiv. exhaust vel.
mdot = Mp / tb; % Mass flow rate

% Initial conditions:
h = 0;
V = 0;
M = M0;
state0 = [ h M V ]';

T = 3600; % 1 hour: should have reached apogee by then

% Events: specifies a function that can stop the computation when it's zero
options = odeset( 'RelTol', 1.0e-6, 'AbsTol', 1.0e-9, ...
    'Events', @stopAtApogee );

% Integrate equations of motion -- note that drag is computed by propagator
[ tOut, stateOut, te, ye, ie ] = ode45( @propagateRocket, [ 0 T ], state0, options );
finalState = stateOut( length(stateOut), : ); 
Vb = ye(1,3);
hmax = ye(2,1);
M = ye(2,2)
V = ye(2,3)

te
ye 
ie

end

function [value,isTerminal,direction] = stopAtApogee( t, state )
global Mb

value(1) = state(2) - Mb; % Notice when mass drops to burnout mass
isTerminal(1) = 0; % Don't stop at burnout
direction(1) = -1; % Notice only when mass is decreasing

value(2) = state(3); % Notice when velocity < 0
isTerminal(2) = 1; % Stop when this happens
direction(2) = -1; % Notice only when velocity is decreasing

end   

function d = propagateRocket( t, state )
global Mb ueq mdot ge muE R0 CD AF constGrav
%disp( sprintf( '%f %f %f', state(1), state(2), state(3)) )

%state vector: h, M, V
h = state(1);
M = state(2);
V = state(3);

if constGrav
    g = ge;
else
    g = muE / (R0 + h)^2;
end

% Parameters in curve fit for atmospheric density variation
a = 1.2;
b = 2.9e-5;

rho = a * exp( -b*h^1.15 ); % air density
Pd = rho * V^2 / 2; % dynamic pressure
  
d = zeros(3,1);
d(1) = V;
d(3) = -g - CD*AF*Pd/M; % Include drag
if M > Mb
    d(2) = -mdot;
    d(3) = d(3) + mdot*ueq/M;
else
    d(2) = 0;
end

end





